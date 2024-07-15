-- Entity Declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity saltwater_chlorine_generator is
    Port (
        clk : in STD_LOGIC; -- Clock signal
        rst : in STD_LOGIC; -- Reset signal
        rotary_a : in STD_LOGIC; -- Rotary encoder signal A
        rotary_b : in STD_LOGIC; -- Rotary encoder signal B
        btn_add_salt : in STD_LOGIC; -- Button to add salt (Y16)
        
        sw_user_mode : in STD_LOGIC; -- Switch for user input mode (T16)
        -- switch is T16. LED is D18. I misread the label on the board //GZM
        btn_increase_temp : in STD_LOGIC; -- Button to increase temperature (P15)
        -- switch is P15. LED is M15. I misread the label on the board //GZM
        btn_increase_salt : in STD_LOGIC; -- Button to increase salt PPM (G15)
        -- switch is G15. LED is M14. I misread the label on the board //GZM
        
        btn_pump_control : in STD_LOGIC; -- Button to control pool pump (K19)
        -- Outputs to LEDs and displays
        led_flow_status : out STD_LOGIC_VECTOR (2 downto 0); -- RGB LED for water flow (LD5)
        led_system_status : out STD_LOGIC_VECTOR (2 downto 0); -- RGB LED for system status (LD6)
        
        ssd_display : out STD_LOGIC_VECTOR (6 downto 0); -- Seven-segment display
        -- change vector from 7 downto 0 to 6 downto 0. reference assignment 03 //GZM
        
        oled_data : out STD_LOGIC_VECTOR (23 downto 0) -- OLED display data
    );
end saltwater_chlorine_generator;

-- Architecture Body
architecture Behavioral of saltwater_chlorine_generator is
    signal pool_size_gallons : integer := 0; -- Pool size in thousands of gallons
    signal salt_ppm : integer := 0; -- Salt concentration in parts per million (ppm)
    signal temperature : integer := 0; -- Water temperature
    signal water_flow_on : STD_LOGIC := '0'; -- Water flow status
    signal system_status : STD_LOGIC_VECTOR (2 downto 0) := "000"; -- System status (green initially)
begin

    -- Initialization Process
    process(clk, rst)
    begin
        if rst = '1' then
            pool_size_gallons <= 0;
            salt_ppm <= 0;
            temperature <= 0;
            water_flow_on <= '0';
            system_status <= "000"; -- Green initially
        elsif rising_edge(clk) then
            -- Initialization code for Pmods, LEDs, and other peripherals
            -- Placeholder for actual initialization
        end if;
    end process;

    -- User Input Handling Process
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset user input values
            pool_size_gallons <= 0;
            salt_ppm <= 0;
            temperature <= 0;
        elsif rising_edge(clk) then
            -- Handle user input for initial settings
            if sw_user_mode = '1' then
                -- User input mode
                if rotary_a = '1' and rotary_b = '0' then
                    -- Handle rotary encoder input for navigating menus
                elsif rotary_a = '0' and rotary_b = '1' then
                    -- Handle rotary encoder input for changing values
                end if;
                
                if btn_increase_salt = '1' then
                    -- Change salt PPM
                    salt_ppm <= salt_ppm + 500; -- Increment by 500 ppm
                elsif btn_increase_temp = '1' then
                    -- Change temperature
                    temperature <= temperature + 1; -- Increment temperature by 1 degree
                end if;
                
                if btn_add_salt = '1' then
                    -- Add salt
                    salt_ppm <= salt_ppm + 20;
                    -- Trigger remeasurement logic
                end if;
            else
                -- Normal running mode
            end if;
        end if;
    end process;

end Behavioral;
