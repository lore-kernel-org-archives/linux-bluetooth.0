Return-Path: <cyrus@holtmann.org>
Message-ID: <53026C2F.4010705@convergeddevices.net>
Date: Mon, 17 Feb 2014 20:08:15 +0000
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Help with AVDTP Connection accept
Content-Type: multipart/mixed;
	boundary="------------050800070709060704000108"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------050800070709060704000108
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
         I have BlueZ 4.101 and the daemon is running(log file 
daemon.txt). I am trying to initiate an AVDTP connection from PTS suite. 
But couldn’t get(or not sure how) the BlueZ side accept the connection. 
 From the log I can see the device reply with no Link key message. But 
the connection gets dropped quickly.

1) From browsing the SDP entries (log :- sdptool.txt ), I don't see an 
entry for A2DP. I ran the configure file with --enable audio and can see 
from the daemon.txt audio plugin is loaded. Should I be adding SDP 
record manually? How can I do that?

2) Am I right in understanding, I should be using test/simple-agent to 
manage SSP? At present I don’t see anything. From forums, I understand, 
the script would prompt for PIN or any security as required. But in my 
case nothing happens.  I have attached the btmon log as well.

Thank you for any pointers or suggestions.

Thanks,
Tony

--------------050800070709060704000108
Content-Type: text/plain; charset="UTF-8"; name="btmon.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="btmon.txt"

Bluetooth monitor ver 4.101
[hci0] 19:43:18.206988 = New Index: 00:1A:7D:DA:71:11 (BR/EDR,USB,hci0)
[hci0] 19:43:33.416132 < HCI Command: Reset (0x03|0x0003) plen 0
[hci0] 19:43:33.551962 > HCI Event: Command Complete (0x0e) plen 4
            01 03 0c 00                                      ....            
[hci0] 19:43:33.552145 < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
[hci0] 19:43:33.555026 > HCI Event: Command Complete (0x0e) plen 12
            01 03 10 00 ff ff 8f fe db ff 5b 87              ..........[.    
[hci0] 19:43:33.555257 < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
[hci0] 19:43:33.557883 > HCI Event: Command Complete (0x0e) plen 12
            01 01 10 00 06 bb 22 06 0a 00 bb 22              ......"...."    
[hci0] 19:43:33.558084 < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
[hci0] 19:43:33.561876 > HCI Event: Command Complete (0x0e) plen 11
            01 05 10 00 36 01 40 0a 00 08 00                 ....6.@....     
[hci0] 19:43:33.562027 < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
[hci0] 19:43:33.564840 > HCI Event: Command Complete (0x0e) plen 10
            01 09 10 00 11 71 da 7d 1a 00                    .....q.}..      
[hci0] 19:43:33.564990 < HCI Command: Read Class of Device (0x03|0x0023) plen 0
[hci0] 19:43:33.567851 > HCI Event: Command Complete (0x0e) plen 7
            01 23 0c 00 00 00 00                             .#.....         
[hci0] 19:43:33.568013 < HCI Command: Read Local Name (0x03|0x0014) plen 0
[hci0] 19:43:33.604743 > HCI Event: Command Complete (0x0e) plen 252
            01 14 0c 00 43 53 52 38 35 31 30 20 41 31 30 00  ....CSR8510 A10.
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00              ............    
[hci0] 19:43:33.604916 < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
[hci0] 19:43:33.606730 > HCI Event: Command Complete (0x0e) plen 6
            01 25 0c 00 60 00                                .%..`.          
[hci0] 19:43:33.606896 < HCI Command: Set Event Filter (0x03|0x0005) plen 1
            00                                               .               
[hci0] 19:43:33.609757 > HCI Event: Command Complete (0x0e) plen 4
            01 05 0c 00                                      ....            
[hci0] 19:43:33.609940 < HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
            00 7d                                            .}              
[hci0] 19:43:33.612756 > HCI Event: Command Complete (0x0e) plen 4
            01 16 0c 00                                      ....            
[hci0] 19:43:33.612941 < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
            00 00 00 00 00 00 01                             .......         
[hci0] 19:43:33.615808 > HCI Event: Command Complete (0x0e) plen 6
            01 12 0c 00 00 00                                ......          
[hci0] 19:43:33.615980 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
            ff ff fb ff 07 f8 bf 3d                          .......=        
[hci0] 19:43:33.622265 > HCI Event: Command Complete (0x0e) plen 4
            01 01 0c 00                                      ....            
[hci0] 19:43:33.622465 < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
[hci0] 19:43:33.637295 > HCI Event: Command Complete (0x0e) plen 68
            01 02 10 00 ff ff ff 03 fe ff ff ff ff ff ff ff  ................
            f3 0f e8 fe 3f f7 83 ff 1c 00 00 00 61 f7 ff ff  ....?.......a...
            7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00                                      ....            
[hci0] 19:43:33.637390 < HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1
            01                                               .               
[hci0] 19:43:33.640306 > HCI Event: Command Complete (0x0e) plen 4
            01 56 0c 00                                      .V..            
[hci0] 19:43:33.640389 < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
            02                                               .               
[hci0] 19:43:33.643335 > HCI Event: Command Complete (0x0e) plen 4
            01 45 0c 00                                      .E..            
[hci0] 19:43:33.643424 < HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen 0
[hci0] 19:43:33.646297 > HCI Event: Command Complete (0x0e) plen 5
            01 58 0c 00 04                                   .X...           
[hci0] 19:43:33.646394 < HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
            01                                               .               
[hci0] 19:43:33.648982 > HCI Event: Command Complete (0x0e) plen 14
            01 04 10 00 01 01 01 00 00 00 00 00 00 00        ..............  
[hci0] 19:43:33.649144 < HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
            00 00                                            ..              
[hci0] 19:43:33.654647 > HCI Event: Command Complete (0x0e) plen 4
            01 6d 0c 00                                      .m..            
[hci0] 19:43:33.654859 < HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
            0f 00                                            ..              
[hci0] 19:43:33.657554 > HCI Event: Command Complete (0x0e) plen 4
            01 0f 08 00                                      ....            
[hci0] 19:43:33.657784 < HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
            01                                               .               
[hci0] 19:43:33.661143 > HCI Event: Command Complete (0x0e) plen 14
            01 04 10 00 01 01 01 00 00 00 00 00 00 00        ..............  
[hci0] 19:43:33.662535 < HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
            01                                               .               
[hci0] 19:43:33.666142 > HCI Event: Command Complete (0x0e) plen 14
            01 04 10 00 01 01 01 00 00 00 00 00 00 00        ..............  
[hci0] 19:43:33.666279 < HCI Command: Write Page Timeout (0x03|0x0018) plen 2
            00 20                                            .               
[hci0] 19:43:33.671070 > HCI Event: Command Complete (0x0e) plen 4
            01 18 0c 00                                      ....            
[hci0] 19:43:33.671127 < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
            00 00 00 00 00 00 01                             .......         
[hci0] 19:43:33.674217 > HCI Event: Command Complete (0x0e) plen 8
            01 0d 0c 00 10 00 00 00                          ........        
[hci0] 19:43:33.674280 < HCI Command: Write Local Name (0x03|0x0013) plen 248
            75 62 75 6e 74 75 2d 56 69 72 74 75 61 6c 42 6f  ubuntu-VirtualBo
            78 2d 30 00 00 00 00 00 00 00 00 00 00 00 00 00  x-0.............
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00                          ........        
[hci0] 19:43:33.677219 > HCI Event: Command Complete (0x0e) plen 4
            01 13 0c 00                                      ....            
[hci0] 19:43:33.834766 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
            ff ff fb ff 07 f8 bf 3d                          .......=        
[hci0] 19:43:33.853516 > HCI Event: Command Complete (0x0e) plen 4
            01 01 0c 00                                      ....            
[hci0] 19:43:33.853579 < HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1
            01                                               .               
[hci0] 19:43:33.856412 > HCI Event: Command Complete (0x0e) plen 4
            01 56 0c 00                                      .V..            
[hci0] 19:43:33.856461 < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
            02                                               .               
[hci0] 19:43:33.859494 > HCI Event: Command Complete (0x0e) plen 4
            01 45 0c 00                                      .E..            
[hci0] 19:43:33.859678 < HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen 0
[hci0] 19:43:33.862403 > HCI Event: Command Complete (0x0e) plen 5
            01 58 0c 00 04                                   .X...           
[hci0] 19:43:33.862498 < HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
            0f 00                                            ..              
[hci0] 19:43:33.866803 > HCI Event: Command Complete (0x0e) plen 4
            01 0f 08 00                                      ....            
[hci0] 19:43:33.866926 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
            00 01 42                                         ..B             
[hci0] 19:43:33.870102 > HCI Event: Command Complete (0x0e) plen 4
            01 24 0c 00                                      .$..            
[hci0] 19:43:33.870207 < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
            02                                               .               
[hci0] 19:43:33.873942 > HCI Event: Command Complete (0x0e) plen 4
            01 1a 0c 00                                      ....            
[hci0] 19:43:33.876508 < HCI Command: Read Local Name (0x03|0x0014) plen 0
[hci0] 19:43:33.918422 > HCI Event: Command Complete (0x0e) plen 252
            01 14 0c 00 75 62 75 6e 74 75 2d 56 69 72 74 75  ....ubuntu-Virtu
            61 6c 42 6f 78 2d 30 00 00 00 00 00 00 00 00 00  alBox-0.........
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00              ............    
[hci0] 19:43:33.918464 < HCI Command: Read Simple Pairing Mode (0x03|0x0055) plen 0
[hci0] 19:43:33.921419 > HCI Event: Command Complete (0x0e) plen 5
            01 55 0c 00 01                                   .U...           
[hci0] 19:43:33.941488 < HCI Command: Read Scan Enable (0x03|0x0019) plen 0
[hci0] 19:43:33.944040 > HCI Event: Command Complete (0x0e) plen 5
            01 19 0c 00 02                                   .....           
[hci0] 19:43:33.944133 < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
            00 14 09 75 62 75 6e 74 75 2d 56 69 72 74 75 61  ...ubuntu-Virtua
            6c 42 6f 78 2d 30 02 0a 04 0d 03 2d 11 12 11 1f  lBox-0.....-....
            11 0c 11 0e 11 03 11 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
            00                                               .               
[hci0] 19:43:33.948993 > HCI Event: Command Complete (0x0e) plen 4
            01 52 0c 00                                      .R..            
[hci0] 19:45:24.002014 > HCI Event: Connect Request (0x04) plen 10
            95 2e 07 dc 1b 00 1c 04 04 01                    ..........      
[hci0] 19:45:24.002286 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
            95 2e 07 dc 1b 00 00                             .......         
[hci0] 19:45:24.010030 > HCI Event: Command Status (0x0f) plen 4
            00 01 09 04                                      ....            
[hci0] 19:45:24.183604 > HCI Event: Role Change (0x12) plen 8
            00 95 2e 07 dc 1b 00 00                          ........        
[hci0] 19:45:24.198571 > HCI Event: Connect Complete (0x03) plen 11
            00 48 00 95 2e 07 dc 1b 00 01 00                 .H.........     
[hci0] 19:45:24.198897 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
            48 00                                            H.              
[hci0] 19:45:24.200321 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
            95 2e 07 dc 1b 00 01                             .......         
[hci0] 19:45:24.205250 > HCI Event: Max Slots Change (0x1b) plen 3
            48 00 05                                         H..             
[hci0] 19:45:24.207249 > HCI Event: Command Status (0x0f) plen 4
            00 00 1b 04                                      ....            
[hci0] 19:45:24.220160 > HCI Event: Command Status (0x0f) plen 4
            00 01 00 00                                      ....            
[hci0] 19:45:24.226113 > HCI Event: Read Remote Supported Features (0x0b) plen 11
            00 48 00 ff ff 8f 7e d8 1f 5b 87                 .H....~..[.     
[hci0] 19:45:24.226215 <
--------------050800070709060704000108
Content-Type: text/plain; charset="UTF-8"; name="daemon.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="daemon.txt"

tony@ubuntu-VirtualBox:~/work/git/dev-team/tony/btPTest/blueZgit/bluez/src$ sudo ./bluetoothd -nd | tee ~/Desktop/btDaemon.txt
bluetoothd[11556]: Bluetooth daemon 4.101
bluetoothd[11556]: src/main.c:parse_config() parsing main.conf
bluetoothd[11556]: src/main.c:parse_config() discovto=0
bluetoothd[11556]: src/main.c:parse_config() pairto=0
bluetoothd[11556]: src/main.c:parse_config() pageto=8192
bluetoothd[11556]: src/main.c:parse_config() auto_to=60
bluetoothd[11556]: src/main.c:parse_config() name=%h-%d
bluetoothd[11556]: src/main.c:parse_config() class=0x000100
bluetoothd[11556]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[11556]: Starting SDP server
bluetoothd[11556]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[11556]: src/plugin.c:add_plugin() Loading pnat plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading sap plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading health plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading thermometer plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading alert plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading time plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading gatt_example plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading proximity plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading maemo6 plugin
bluetoothd[11556]: src/plugin.c:add_plugin() Loading dbusoob plugin
bluetoothd[11556]: src/plugin.c:plugin_init() Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[11556]: plugins/service.c:register_interface() path /org/bluez/11556/any
bluetoothd[11556]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/11556/any
bluetoothd[11556]: plugins/dbusoob.c:dbusoob_init() Setup dbusoob plugin
bluetoothd[11556]: plugins/maemo6.c:maemo6_init() init maemo6 plugin
bluetoothd[11556]: DIS cannot start: GATT is disabled
bluetoothd[11556]: Failed to init deviceinfo plugin
bluetoothd[11556]: proximity/main.c:proximity_init() GATT is disabled
bluetoothd[11556]: Failed to init proximity plugin
bluetoothd[11556]: time/main.c:time_init() GATT is disabled
bluetoothd[11556]: Failed to init time plugin
bluetoothd[11556]: alert/main.c:alert_init() GATT is disabled
bluetoothd[11556]: Failed to init alert plugin
bluetoothd[11556]: thermometer/main.c:thermometer_init() GATT is disabled
bluetoothd[11556]: Failed to init thermometer plugin
bluetoothd[11556]: health/hdp.c:hdp_manager_start() Starting Health manager
bluetoothd[11556]: network/manager.c:read_config() /usr/local/etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[11556]: network/manager.c:read_config() Config options: Security=true
bluetoothd[11556]: input/manager.c:input_manager_init() input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[11556]: plugins/pnat.c:pnat_init() Setup Phonet AT (DUN) plugin
bluetoothd[11556]: plugins/hciops.c:hciops_init() 
bluetoothd[11556]: plugins/gatt-example.c:gatt_example_init() GATT is disabled
bluetoothd[11556]: Failed to init gatt_example plugin
bluetoothd[11556]: plugins/hciops.c:hciops_setup() 
bluetoothd[11556]: src/main.c:main() Entering main loop
bluetoothd[11556]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 op 0 soft 0 hard 0
bluetoothd[11556]: plugins/hciops.c:init_known_adapters() 
bluetoothd[11556]: plugins/hciops.c:init_device() hci0
bluetoothd[11556]: Listening for HCI events on hci0
bluetoothd[11556]: plugins/hciops.c:init_device() child 11557 forked
bluetoothd[11556]: plugins/hciops.c:read_local_features_complete() Got features for hci0
bluetoothd[11556]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[11556]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[11556]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[11556]: plugins/hciops.c:read_tx_power_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:child_exit() child 11557 exited
bluetoothd[11556]: HCI dev 0 up
bluetoothd[11556]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=1
bluetoothd[11556]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[11556]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[11556]: plugins/service.c:register_interface() path /org/bluez/11556/hci0
bluetoothd[11556]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/11556/hci0
bluetoothd[11556]: plugins/maemo6.c:mce_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=2
bluetoothd[11556]: network/manager.c:network_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=3
bluetoothd[11556]: network/server.c:server_register() Registered interface org.bluez.NetworkServer on path /org/bluez/11556/hci0
bluetoothd[11556]: serial/manager.c:proxy_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=4
bluetoothd[11556]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/11556/hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=5
bluetoothd[11556]: sap/manager.c:sap_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000112d-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001204-0000-1000-8000-00805f9
bluetoothd[11556]: sap/server.c:sap_server_register() Listen socket 0x14
bluetoothd[11556]: audio/manager.c:media_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=6
bluetoothd[11556]: audio/manager.c:audio_adapter_ref() 0xb79b5a58: ref=1
bluetoothd[11556]: audio/manager.c:headset_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: audio/manager.c:audio_adapter_ref() 0xb79b5a58: ref=2
bluetoothd[11556]: audio/manager.c:headset_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[11556]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'SCORouting'
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[11556]: audio/manager.c:a2dp_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: audio/manager.c:audio_adapter_ref() 0xb79b5a58: ref=3
bluetoothd[11556]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[11556]: audio/avdtp.c:avdtp_init() audio.conf: Key file does not have key 'Master'
bluetoothd[11556]: audio/manager.c:avrcp_server_probe() path /org/bluez/11556/hci0
bluetoothd[11556]: audio/manager.c:audio_adapter_ref() 0xb79b5a58: ref=4
bluetoothd[11556]: audio/avrcp.c:avrcp_register() audio.conf: Key file does not have key 'Master'
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[11556]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11556]: plugins/hciops.c:update_service_classes() hci0 value 66
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001103-0000-1000-8000-00805f9
bluetoothd[11556]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001201-0000-1000-8000-00805f9
bluetoothd[11556]: plugins/adaptername.c:adaptername_probe() Setting name 'ubuntu-VirtualBox-0' for device 'hci0'
bluetoothd[11556]: plugins/hciops.c:hciops_set_name() hci0, name ubuntu-VirtualBox-0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/formfactor.c:formfactor_probe() Setting 0x000100 for major/minor device class
bluetoothd[11556]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[11556]: plugins/hciops.c:hciops_unblock_device() hci0 dba 00:00:00:00:00:00
bluetoothd[11556]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[11556]: Unable to load keys to adapter_ops: Function not implemented (38)
bluetoothd[11556]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[11556]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/11556/hci0 registered
bluetoothd[11556]: src/adapter.c:btd_adapter_ref() 0xb79b4968: ref=7
bluetoothd[11556]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[11556]: plugins/maemo6.c:adapter_powered() adapter_powered called with 1
bluetoothd[11556]: plugins/maemo6.c:adapter_powered() Startup: reading MCE Bluetooth radio state...
bluetoothd[11556]: audio/manager.c:state_changed() /org/bluez/11556/hci0 powered on
bluetoothd[11556]: audio/telephony.c:telephony_init() 
bluetoothd[11556]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[11556]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[11556]: plugins/hciops.c:hciops_disable_cod_cache() hci0 cache_enable 1
bluetoothd[11556]: plugins/hciops.c:hciops_disable_cod_cache() hci0 current_cod 0x000000 wanted_cod 0x420100
bluetoothd[11556]: plugins/hciops.c:write_class() hci0 class 0x420100
bluetoothd[11556]: Adapter /org/bluez/11556/hci0 has been enabled
bluetoothd[11556]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 0
bluetoothd[11556]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[11556]: src/adapter.c:btd_adapter_unref() 0xb79b4968: ref=6
bluetoothd[11556]: mce replied with an error: org.freedesktop.DBus.Error.ServiceUnknown, The name com.nokia.mce was not provided by any .service files
bluetoothd[11556]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:read_tx_power_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/hciops.c:read_simple_pairing_mode_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11556]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:hciops_set_limited_discoverable() hci0 limited 0
bluetoothd[11556]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x02
bluetoothd[11556]: src/adapter.c:set_mode_complete() 



bluetoothd[11556]: src/adapter.c:register_agent() Agent registered for hci0 at :1.105:/test/agent


bluetoothd[11556]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[11556]: src/adapter.c:adapter_get_device() 00:1B:DC:07:2E:95
bluetoothd[11556]: src/adapter.c:adapter_create_device() 00:1B:DC:07:2E:95
bluetoothd[11556]: src/device.c:device_create() Creating device /org/bluez/11556/hci0/dev_00_1B_DC_07_2E_95
bluetoothd[11556]: src/device.c:btd_device_ref() 0xb79b9988: ref=1
bluetoothd[11556]: src/device.c:device_set_temporary() temporary 1
bluetoothd[11556]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:link_key_request() hci0 dba 00:1B:DC:07:2E:95
bluetoothd[11556]: plugins/hciops.c:get_auth_info() hci0 dba 00:1B:DC:07:2E:95
bluetoothd[11556]: plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
bluetoothd[11556]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[11556]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[11556]: plugins/hciops.c:disconn_complete() handle 72 status 0x00
bluetoothd[11556]: src/event.c:btd_event_disconn_complete() 
bluetoothd[11556]: src/adapter.c:adapter_remove_connection() 
bluetoothd[11556]: src/adapter.c:adapter_remove_connection() Removing temporary device /org/bluez/11556/hci0/dev_00_1B_DC_07_2E_95
bluetoothd[11556]: src/device.c:device_remove() Removing device /org/bluez/11556/hci0/dev_00_1B_DC_07_2E_95
bluetoothd[11556]: src/device.c:btd_device_unref() 0xb79b9988: ref=0
bluetoothd[11556]: src/device.c:device_free() 0xb79b9988
bluetoothd[11556]: plugins/hciops.c:__get_remote_version() hci0 handle 72




--------------050800070709060704000108
Content-Type: text/plain; charset="UTF-8"; name="sdptool.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sdptool.txt"

Browsing FF:FF:FF:00:00:00 ...
Service Name: SIM Access Server
Service RecHandle: 0x10000
Service Class ID List:
  "SIM Access" (0x112d)
  "Generic Telephony" (0x1204)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
Profile Descriptor List:
  "SIM Access" (0x112d)
    Version: 0x0101

Service Name: Headset Audio Gateway
Service RecHandle: 0x10001
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0102

Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x10002
Service Class ID List:
  "Handsfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 13
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0105

Service Name: AVRCP TG
Service RecHandle: 0x10003
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0104

Service Name: AVRCP CT
Service RecHandle: 0x10004
Service Class ID List:
  "AV Remote" (0x110e)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x103
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x10005
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100


--------------050800070709060704000108
Content-Type: text/plain; charset="UTF-8"; name="simpleAgent.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="simpleAgent.txt"

 sudo ./simple-agent hci0 
Agent registered


--------------050800070709060704000108--
