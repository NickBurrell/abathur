library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity line_ram is
    Generic(
            LINE_LEN   : NATURAL := 640; -- Length of line in pixels
            ADDR_LEN   : NATURAL := 10; -- Length of address for reading/writing a given pixel
            PIXEL_SIZE : NATURAL := 8); -- Pixel size in bits
    Port ( clk : in STD_LOGIC;
           write_enabled : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (PIXEL_SIZE-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (PIXEL_SIZE-1 downto 0);
           addr : in STD_LOGIC_VECTOR (ADDR_LEN-1 downto 0));
end line_ram;

architecture Structural of line_ram is
    type line_data is array (0 to LINE_LEN) of STD_LOGIC_VECTOR(PIXEL_SIZE-1 downto 0);
    signal _data : line_data;
    begin
    process(clk) begin  
        if rising_edge(clk) then
            if write_enabled = '1' then
                ram(conv_integer(addr)) <= data_in;
                data_out <= data_in;
            else
                data_out <= _data(conv_integer(addr));
            end if;
        end if;
    end process;

end Structural;
