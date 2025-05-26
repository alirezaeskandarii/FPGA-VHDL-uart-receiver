----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:30 04/11/2025 
-- Design Name: 
-- Module Name:    uart_rx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rx is
    Port ( clk : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           valid : out  STD_LOGIC);
end uart_rx;

architecture Behavioral of uart_rx is
signal cnt:integer range 0 to 7811;
signal i: integer range 0 to 7;
type state_type is (idle, start, data, stop);
signal state:state_type:=idle;
signal buff:std_logic_vector(7 downto 0);
begin
process(clk)
	begin
		if(rising_edge(clk)) then
			valid <= '0';
			case state is
				when idle=>
					if(rx='0') then
						state <= start;
						cnt <=0;
					end if;
				when start=>
					cnt <= cnt+1;
					if(cnt=7811)then
						cnt <=0;
						i <= 0;
						state <= data;
					end if;
				when data=>
					if(cnt=0)then
						buff(i)<=rx;
					end if;
					cnt<=cnt+1;
					if(cnt=5207)then
						cnt <= 0;
						i<=i+1;
						if(i = 7) then
							state <= stop;
						end if;
					end if;
				when stop=>
					cnt<=cnt+1;
					if(cnt=5207)then
						cnt<=0;
						state <= idle;
						valid <='1';
						dout <=buff;
					end if;
			end case;		
		end if;
end process;

end Behavioral;

