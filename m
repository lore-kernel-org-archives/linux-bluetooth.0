Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Petri Gynther <pgynther@google.com>
Date: Wed, 9 Nov 2016 11:39:34 -0800
Message-ID: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
Subject: BlueZ 5.43: HoG peripheral services re-discovered again and again on
 every reconnect
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi linux-bluetooth:

I'm seeing the following issue with BlueZ 5.43 and Linux 4.4.30.

When a previously bonded HoG remote control reconnects to BlueZ 5.43
host, BlueZ goes ahead and re-discovers the primary services of the
bonded remote again and again on every reconnect.

Why is this necessary? Shouldn't this information be cached on the
initial pairing/bonding, and a reconnect can get this information from
the relevant persistent file, rather than wasting BLE airtime and
delaying the reconnect?

Here is the log:
15,148349,14484016000,-;btmon: < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2   [hci0] 16:45:13.144717
15,148350,14484016000,-;btmon:         Scanning: Disabled (0x00)
15,148351,14484016000,-;btmon:         Filter duplicates: Disabled (0x00)
15,148352,14484024000,-;btmon: > HCI Event: Command Complete (0x0e)
plen 4              [hci0] 16:45:13.151431
15,148353,14484024000,-;btmon:       LE Set Scan Enable (0x08|0x000c) ncmd 1
15,148354,14484024000,-;btmon:         Status: Success (0x00)
15,148355,14484024000,-;btmon: < HCI Command: LE Create Connec..
(0x08|0x000d) plen 25  [hci0] 16:45:13.151696
15,148356,14484024000,-;btmon:         Scan interval: 60.000 msec (0x0060)
15,148357,14484026000,-;btmon:         Scan window: 60.000 msec (0x0060)
15,148358,14484026000,-;btmon:         Filter policy: White list is
not used (0x00)
15,148359,14484026000,-;btmon:         Peer address type: Public (0x00)
15,148360,14484026000,-;btmon:         Peer address: D4:F5:13:xx:xx:xx
(OUI D4-F5-13)
15,148361,14484026000,-;btmon:         Own address type: Public (0x00)
15,148362,14484026000,-;btmon:         Min connection interval: 10.00
msec (0x0008)
15,148363,14484026000,-;btmon:         Max connection interval: 10.00
msec (0x0008)
15,148364,14484026000,-;btmon:         Connection latency: 0x0032
15,148365,14484026000,-;btmon:         Supervision timeout: 5000 msec (0x01f4)
15,148366,14484026000,-;btmon:         Min connection length: 0.000
msec (0x0000)
15,148367,14484026000,-;btmon:         Max connection length: 0.000
msec (0x0000)
15,148368,14484035000,-;btmon: > HCI Event: Command Status (0x0f) plen
4                [hci0] 16:45:13.163738
15,148369,14484036000,-;btmon:       LE Create Connection (0x08|0x000d) ncmd 1
15,148370,14484036000,-;btmon:         Status: Success (0x00)
15,148371,14484042000,-;bluez: bluetoothd[1985]:
src/adapter.c:connected_callback() hci0 device D4:F5:13:xx:xx:xx
connected eir_len 0
15,148372,14484042000,-;bluez: bluetoothd[1985]:
src/adapter.c:connected_callback() device 0x56c520 paired 1 bonded 1
bonding 0
15,148373,14484048000,-;btmon: > HCI Event: LE Meta Event (0x3e) plen
19                [hci0] 16:45:13.166525
15,148374,14484048000,-;btmon:       LE Connection Complete (0x01)
15,148375,14484048000,-;btmon:         Status: Success (0x00)
15,148376,14484048000,-;btmon:         Handle: 128
15,148377,14484048000,-;btmon:         Role: Master (0x00)
15,148378,14484048000,-;btmon:         Peer address type: Public (0x00)
15,148379,14484048000,-;btmon:         Peer address: D4:F5:13:xx:xx:xx
(OUI D4-F5-13)
15,148380,14484048000,-;btmon:         Connection interval: 10.00 msec (0x0008)
15,148381,14484048000,-;btmon:         Connection latency: 62.50 msec (0x0032)
15,148382,14484048000,-;btmon:         Supervision timeout: 5000 msec (0x01f4)
15,148383,14484048000,-;btmon:         Master clock accuracy: 0x01
15,148384,14484054000,-;btmon: < HCI Command: LE Read Remote Us..
(0x08|0x0016) plen 2  [hci0] 16:45:13.167102
15,148385,14484057000,-;btmon:         Handle: 128
15,148386,14484057000,-;btmon: @ Device Connected: D4:F5:13:xx:xx:xx
(1) flags 0x0000
15,148387,14484060000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 6              [hci0] 16:45:13.186288
15,148388,14484060000,-;btmon:       SMP: Security Request (0x0b) len 1
15,148389,14484060000,-;btmon:         Authentication requirement:
Bonding, MITM, Legacy, No Keypresses (0x05)
15,148390,14484060000,-;btmon: > HCI Event: Command Status (0x0f) plen
4                [hci0] 16:45:13.187449
15,148391,14484060000,-;btmon:       LE Read Remote Used Features
(0x08|0x0016) ncmd 1
15,148392,14484060000,-;btmon:         Status: Success (0x00)
15,148393,14484083000,-;btmon: > HCI Event: LE Meta Event (0x3e) plen
12                [hci0] 16:45:13.204567
15,148394,14484083000,-;btmon:       LE Read Remote Used Features (0x04)
15,148395,14484083000,-;btmon:         Status: Success (0x00)
15,148396,14484083000,-;btmon:         Handle: 128
15,148397,14484083000,-;btmon:         Features: 0x01 0x00 0x00 0x00
0x00 0x00 0x00 0x00
15,148398,14484083000,-;btmon:           LE Encryption
15,148399,14484084000,-;bluez: bluetoothd[1985]:
src/gatt-database.c:connect_cb() New incoming LE ATT connection
15,148400,14484084000,-;bluez: bluetoothd[1985]:
src/device.c:device_attach_att() Elevating security level since LTK is
available
15,148401,14484090000,-;btmon: < HCI Command: LE Start Encrypt..
(0x08|0x0019) plen 28  [hci0] 16:45:13.204768
15,148402,14484092000,-;btmon:         Handle: 128
15,148403,14484092000,-;btmon:         Random number: 0x2f1ece959be98720
15,148404,14484092000,-;btmon:         Encrypted diversifier: 0xf64c
15,148405,14484092000,-;btmon:         Long term key:
81f83ba06c91dd2e8a19cbe65fd5123a
15,148406,14484095000,-;btmon: > HCI Event: Command Status (0x0f) plen
4                [hci0] 16:45:13.219246
15,148407,14484097000,-;btmon:       LE Start Encryption (0x08|0x0019) ncmd 1
15,148408,14484098000,-;btmon:         Status: Success (0x00)
15,148409,14484101000,-;bluez: bluetoothd[1985]:
attrib/gattrib.c:g_attrib_ref() 0x51aab8: g_attrib_ref=1
15,148410,14484101000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:gap_accept() GAP profile accept (D4:F5:13:xx:xx:xx)
15,148411,14484103000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a02-0000-1000-8000-00805f9b34fb
15,148412,14484104000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a03-0000-1000-8000-00805f9b34fb
15,148413,14484112000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a04-0000-1000-8000-00805f9b34fb
15,148414,14484119000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x56ae98: device D4:F5:13:xx:xx:xx
profile gap-profile state changed: disconnected -> connected (0)
15,148415,14484121000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo
profile accept (D4:F5:13:xx:xx:xx)
15,148416,14484121000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a23-0000-1000-8000-00805f9b34fb
15,148417,14484123000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a24-0000-1000-8000-00805f9b34fb
15,148418,14484124000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a25-0000-1000-8000-00805f9b34fb
15,148419,14484125000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a26-0000-1000-8000-00805f9b34fb
15,148420,14484127000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a27-0000-1000-8000-00805f9b34fb
15,148421,14484127000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a28-0000-1000-8000-00805f9b34fb
15,148422,14484132000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a29-0000-1000-8000-00805f9b34fb
15,148423,14484133000,-;bluez: bluetoothd[1985]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a2a-0000-1000-8000-00805f9b34fb
15,148424,14484136000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x512ff0: device D4:F5:13:xx:xx:xx
profile deviceinfo state changed: disconnected -> connected (0)
15,148425,14484139000,-;bluez: bluetoothd[1985]:
profiles/battery/battery.c:batt_accept() BATT connected
15,148426,14484139000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x517cf0: device D4:F5:13:xx:xx:xx
profile Battery state changed: disconnected -> connected (0)
15,148427,14484141000,-;bluez: bluetoothd[1985]:
plugins/policy.c:service_cb() Added Battery reconnect 0
15,148428,14484142000,-;bluez: bluetoothd[1985]:
profiles/scanparam/scan.c:scan_param_accept() Scan Parameters Client
Driver profile accept (D4:F5:13:xx:xx:xx)
15,148429,14484147000,-;bluez: bluetoothd[1985]:
profiles/scanparam/scan.c:handle_iwin() Scan Interval Window handle:
0x002b
15,148430,14484150000,-;bluez: bluetoothd[1985]:
profiles/scanparam/scan.c:handle_refresh() Scan Refresh handle: 0x002d
15,148431,14484151000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x563e48: device D4:F5:13:xx:xx:xx
profile Scan Parameters Client Driver state changed: disconnected ->
connected (0)
15,148434,14484159000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x517cd0: device D4:F5:13:xx:xx:xx
profile input-hog state changed: disconnected -> connected (0)
15,148435,14484159000,-;bluez: bluetoothd[1985]:
plugins/policy.c:service_cb() Added input-hog reconnect 0
15,148436,14484162000,-;bluez: bluetoothd[1985]:
profiles/oad/oad.c:oad_accept() OAD connected
15,148437,14484164000,-;bluez: bluetoothd[1985]:
src/service.c:change_state() 0x56aa90: device D4:F5:13:xx:xx:xx
profile OAD state changed: disconnected -> connected (0)
15,148438,14484167000,-;bluez: bluetoothd[1985]:
plugins/policy.c:service_cb() Added OAD reconnect 0
15,148439,14484168000,-;bluez: bluetoothd[1985]:
profiles/oad/oad.c:oad_is_time_for_upgrade_check() OAD not time for
upgrade check yet (27717 seconds left)
15,148440,14484172000,-;bluez: bluetoothd[1985]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
15,148444,14484647000,-;btmon: > HCI Event: Encryption Change (0x08)
plen 4             [hci0] 16:45:13.772757
15,148445,14484648000,-;btmon:         Status: Success (0x00)
15,148446,14484650000,-;btmon:         Handle: 128
15,148447,14484650000,-;btmon:         Encryption: Enabled with AES-CCM (0x01)
15,148448,14484650000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:13.773623
15,148449,14484650000,-;btmon:       ATT: Write Command (0x52) len 6
15,148450,14484650000,-;btmon:         Handle: 0x002b
15,148451,14484650000,-;btmon:           Data: 60003000
15,148452,14484650000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 7              [hci0] 16:45:13.776191
15,148453,14484650000,-;btmon:       ATT: Exchange MTU Request (0x02) len 2
15,148454,14484650000,-;btmon:         Client RX MTU: 517
15,148455,14484653000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:13.781800
15,148456,14484654000,-;btmon:         Num handles: 1
15,148457,14484654000,-;btmon:         Handle: 128
15,148458,14484654000,-;btmon:         Count: 1
15,148459,14484656000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 8              [hci0] 16:45:13.783776
15,148460,14484656000,-;btmon:       ATT: Handle Value Notification (0x1b) len 3
15,148461,14484656000,-;btmon:         Handle: 0x002e
15,148462,14484656000,-;btmon:           Data: 00
15,148463,14484658000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:13.785586
15,148464,14484658000,-;btmon:         Num handles: 1
15,148465,14484658000,-;btmon:         Handle: 128
15,148466,14484658000,-;btmon:         Count: 1
15,148467,14484676000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
15,148468,14484676000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 7              [hci0] 16:45:13.803216
15,148469,14484676000,-;btmon:       ATT: Exchange MTU Response (0x03) len 2
15,148470,14484676000,-;btmon:         Server RX MTU: 23
15,148471,14484680000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 7              [hci0] 16:45:13.805360
15,148472,14484680000,-;btmon:       ATT: Read Request (0x0a) len 2
15,148473,14484680000,-;btmon:         Handle: 0x0003
15,148476,14485197000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:14.323660
15,148477,14485197000,-;btmon:         Num handles: 1
15,148478,14485197000,-;btmon:         Handle: 128
15,148479,14485197000,-;btmon:         Count: 1
15,148480,14485215000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 12             [hci0] 16:45:14.343324
15,148481,14485215000,-;btmon:       ATT: Read Response (0x0b) len 7
15,148482,14485215000,-;btmon:         Value: xxxxxxxx
15,148483,14485216000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: xxxxxxxx
15,148484,14485218000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 7              [hci0] 16:45:14.345190
15,148485,14485218000,-;btmon:       ATT: Read Request (0x0a) len 2
15,148486,14485218000,-;btmon:         Handle: 0x0005
15,148487,14485280000,-;btmon: > HCI Event: Vendor (0xff) plen 5
                 [hci0] 16:45:14.408751
15,148488,14485280000,-;btmon:         05 80 00 09 00
                 .....
15,148497,14485736000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:14.864603
15,148498,14485736000,-;btmon:         Num handles: 1
15,148499,14485736000,-;btmon:         Handle: 128
15,148500,14485736000,-;btmon:         Count: 1
15,148501,14485744000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 7              [hci0] 16:45:14.871746
15,148502,14485744000,-;btmon:       ATT: Read Response (0x0b) len 2
15,148503,14485744000,-;btmon:         Value: c003
15,148504,14485744000,-;bluez: bluetoothd[1985]:
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x03c0
15,148505,14485746000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 7              [hci0] 16:45:14.873179
15,148506,14485746000,-;btmon:       ATT: Read Request (0x0a) len 214487
15,148507,14485746000,-;btmon:         Handle: 0x0022
15,148508,14485754000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:14.881837
15,148509,14485754000,-;btmon:         Num handles: 1
15,148510,14485754000,-;btmon:         Handle: 128
15,148511,14485754000,-;btmon:         Count: 1
15,148512,14485769000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 12             [hci0] 16:45:14.895082
15,148513,14485769000,-;btmon:       ATT: Read Response (0x0b) len 7
15,148514,14485771000,-;btmon:         Value: 010d0001f01600
15,148515,14485771000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 7              [hci0] 16:45:14.895711
15,148516,14485771000,-;btmon:       ATT: Read Request (0x0a) len 2
15,148517,14485772000,-;btmon:         Handle: 0x0
15,148518,14485775000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:14.903381
15,148519,14485775000,-;btmon:         Num handles: 1
15,148520,14485775000,-;btmon:         Handle: 128
15,148521,14485775000,-;btmon:         Count: 1
15,148522,14485786000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 6              [hci0] 16:45:14.913585
15,148523,14485786000,-;btmon:       ATT: Read Response (0x0b) len 1
15,148524,14485788000,-;bluez: bluetoothd[1985]:
profiles/battery/battery.c:level_read_char_cb() BATT level=100
15,148525,14485788000,-;btmon:         Value: 64
15,148526,14485790000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 9              [hci0] 16:45:14.918396
15,148527,14485790000,-;btmon:       ATT: Write Request (0x12) len 4
15,148528,14485790000,-;btmon:         Handle: 0x002e
15,148529,14485790000,-;btmon:           Data: 0100
15,148531,14486306000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.434853
15,148532,14486306000,-;btmon:         Num handles: 1
15,148533,14486306000,-;btmon:         Handle: 128
15,148534,14486306000,-;btmon:         Count: 1
15,148535,14486316000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 5              [hci0] 16:45:15.443551
15,148536,14486316000,-;btmon:       ATT: Write Response (0x13) len 0
15,148537,14486317000,-;bluez: bluetoothd[1985]:
profiles/scanparam/scan.c:refresh_ccc_written_cb() Scan Refresh:
notification enabled
15,148538,14486317000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.444853
15,148539,14486317000,-;btmon:       ATT: Read By Type Request (0x08) len 6
15,148540,14486317000,-;btmon:         Handle range: 0x002f-0x0037
15,148541,14486318000,-;btmon:         Attribute type: Characteristic (0x2803)
15,148542,14486326000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.454609
15,148543,14486326000,-;btmon:         Num handles: 1
15,148544,14486326000,-;btmon:         Handle: 128
15,148545,14486326000,-;btmon:         Count: 1
15,148546,14486356000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 27             [hci0] 16:45:15.484547
15,148547,14486356000,-;btmon:       ATT: Read By Type Response (0x09) len 22
15,148548,14486356000,-;btmon:         Attribute data length: 7
15,148549,14486356000,-;btmon:         Attribute data list: 3 entries
15,148550,14486357000,-;btmon:         Handle: 0x0030
15,148551,14486357000,-;btmon:         Value: 1e3100f1ff
15,148552,14486357000,-;btmon:         Handle: 0x0033
15,148553,14486357000,-;btmon:         Value: 0a3400f2ff
15,148554,14486357000,-;btmon:         Handle: 0x0035
15,148555,14486357000,-;btmon:         Value: 123600f4ff

BlueZ request to re-discover peripheral's Primary Service starts below:

15,148556,14486357000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.485545
15,148557,14486357000,-;btmon:       ATT: Read By Group Type Request
(0x10) len 6
15,148558,14486358000,-;btmon:         Handle range: 0x0001-0xffff
15,148559,14486358000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,148560,14486364000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.491805
15,148561,14486364000,-;btmon:         Num handles: 1
15,148562,14486364000,-;btmon:         Handle: 128
15,148563,14486364000,-;btmon:         Count: 1
15,148564,14486384000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 24             [hci0] 16:45:15.511935
15,148565,14486384000,-;btmon:       ATT: Read By Group Type Response
(0x11) len 19
15,148566,14486384000,-;btmon:         Attribute data length: 6
15,148567,14486384000,-;btmon:         Attribute group list: 3 entries
15,148568,14486384000,-;btmon:         Handle range: 0x0001-0x000b
15,148569,14486384000,-;btmon:         UUID: Generic Access Profile (0x1800)
15,148570,14486385000,-;btmon:         Handle range: 0x000c-0x000f
15,148571,14486385000,-;btmon:         UUID: Generic Attribute Profile (0x1801)
15,148572,14486385000,-;btmon:         Handle range: 0x0010-0x0022
15,148573,14486386000,-;btmon:         UUID: Device Information (0x180a)
15,148574,14486386000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.512563
15,148575,14486386000,-;btmon:       ATT: Read By Type Request (0x08) len 6
15,148576,14486386000,-;btmon:         Handle range: 0x0036-0x0037
15,148577,14486386000,-;btmon:         Attribute type: Characteristic (0x2803)
15,148578,14486395000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.521844
15,148579,14486395000,-;btmon:         Num handles: 1
15,148580,14486395000,-;btmon:         Handle: 128
15,148581,14486400000,-;btmon:         Count: 1
15,148582,14486404000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 9              [hci0] 16:45:15.532197
15,148583,14486404000,-;btmon:       ATT: Error Response (0x01) len 4
15,148584,14486404000,-;btmon:         Read By Type Request (0x08)
15,148585,14486404000,-;btmon:         Handle: 0x0036
15,148586,14486404000,-;btmon:         Error: Attribute Not Found (0x0a)
15,148587,14486405000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.533289
15,148588,14486405000,-;btmon:       ATT: Read By Group Type Request
(0x10) len 6
15,148589,14486405000,-;btmon:         Handle range: 0x0023-0xffff
15,148590,14486405000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,148591,14486414000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.541821
15,148592,14486414000,-;btmon:         Num handles: 1
15,148593,14486414000,-;btmon:         Handle: 128
15,148594,14486414000,-;btmon:         Count: 1
15,148595,14486448000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 24             [hci0] 16:45:15.574739
15,148596,14486449000,-;btmon:       ATT: Read By Group Type Response
(0x11) len 19
15,148597,14486449000,-;btmon:         Attribute data length: 6
15,148598,14486450000,-;btmon:         Attribute group list: 3 entries
15,148599,14486450000,-;btmon:         Handle range: 0x0023-0x0028
15,148600,14486450000,-;btmon:         UUID: Battery Service (0x180f)
15,148601,14486450000,-;btmon:         Handle range: 0x0029-0x002e
15,148602,14486450000,-;btmon:         UUID: Scan Parameters (0x1813)
15,148603,14486450000,-;btmon:         Handle range: 0x002f-0x0037
15,148604,14486450000,-;btmon:         UUID: Unknown (0xfff0)
15,148605,14486450000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 9              [hci0] 16:45:15.575704
15,148606,14486450000,-;btmon:       ATT: Find Information Request (0x04) len 4
15,148607,14486450000,-;btmon:         Handle range: 0x0036-0x0037
15,148608,14486454000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.581832
15,148609,14486454000,-;btmon:         Num handles: 1
15,148610,14486454000,-;btmon:         Handle: 128
15,148611,14486454000,-;btmon:         Count: 1
15,148614,14486476000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 14             [hci0] 16:45:15.603418
15,148615,14486476000,-;btmon:       ATT: Find Information Response (0x05) len 9
15,148616,14486476000,-;btmon:         Format: UUID-16 (0x01)
15,148617,14486476000,-;btmon:         Handle: 0x0036
15,148618,14486476000,-;btmon:         UUID: Unknown (0xfff4)
15,148619,14486477000,-;btmon:         Handle: 0x0037
15,148620,14486477000,-;btmon:         UUID: Client Characteristic
Configuration (0x2902)
15,148621,14486477000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 10             [hci0] 16:45:15.604557
15,148622,14486477000,-;btmon:       ATT: Write Request (0x12) len 5
15,148623,14486477000,-;btmon:         Handle: 0x0034
15,148624,14486477000,-;btmon:           Data: 030000
15,148625,14486485000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.613570
15,148626,14486485000,-;btmon:         Num handles: 1
15,148627,14486485000,-;btmon:         Handle: 128
15,148628,14486485000,-;btmon:         Count: 1
15,148629,14486496000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 5              [hci0] 16:45:15.623625
15,148630,14486496000,-;btmon:       ATT: Write Response (0x13) len 0
15,148631,14486496000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.624699
15,148632,14486496000,-;btmon:       ATT: Read By Group Type Request
(0x10) len 6
15,148633,14486496000,-;btmon:         Handle range: 0x0038-0xffff
15,148634,14486496000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,148635,14486509000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.637188
15,148636,14486509000,-;btmon:         Num handles: 1
15,148637,14486509000,-;btmon:         Handle: 128
15,148638,14486509000,-;btmon:         Count: 1
15,148639,14486525000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 12             [hci0] 16:45:15.652267
15,148640,14486525000,-;btmon:       ATT: Read By Group Type Response
(0x11) len 7
15,148641,14486525000,-;btmon:         Attribute data length: 6
15,148642,14486525000,-;btmon:         Attribute group list: 1 entry
15,148643,14486525000,-;btmon:         Handle range: 0x0038-0x005c
15,148644,14486525000,-;btmon:         UUID: Human Interface Device (0x1812)
15,148645,14486526000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 9              [hci0] 16:45:15.654189
15,148646,14486526000,-;btmon:       ATT: Write Request (0x12) len 4
15,148647,14486526000,-;btmon:         Handle: 0x0037
15,148648,14486526000,-;btmon:           Data: 0100
15,148650,14486543000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.671923
15,148651,14486543000,-;btmon:         Num handles: 1
15,148652,14486543000,-;btmon:         Handle: 128
15,148653,14486544000,-;btmon:         Count: 1
15,148654,14486574000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 5              [hci0] 16:45:15.702603
15,148655,14486574000,-;btmon:       ATT: Write Response (0x13) len 0
15,148656,14486575000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.703208
15,148657,14486575000,-;btmon:       ATT: Read By Group Type Request
(0x10) len 6
15,148658,14486575000,-;btmon:         Handle range: 0x005d-0xffff
15,148659,14486575000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,148660,14486586000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:15.714715
15,148661,14486586000,-;btmon:         Num handles: 1
15,148662,14486586000,-;btmon:         Handle: 128
15,148663,14486586000,-;btmon:         Count: 1
15,148664,14486617000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 26             [hci0] 16:45:15.744781
15,148665,14486617000,-;btmon:       ATT: Read By Group Type Response
(0x11) len 21
15,148666,14486617000,-;btmon:         Attribute data length: 20
15,148667,14486617000,-;btmon:         Attribute group list: 1 entry
15,148668,14486617000,-;btmon:         Handle range: 0x005d-0x0070
15,148669,14486617000,-;btmon:         UUID: Vendor specific
(f000fef0-0451-4000-b000-000000000000)
15,148670,14486618000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 11             [hci0] 16:45:15.746142
15,148671,14486619000,-;btmon:       ATT: Read By Group Type Request
(0x10) len 6
15,148672,14486619000,-;btmon:         Handle range: 0x0071-0xffff
15,148673,14486620000,-;btmon:         Attribute group type: Primary
Service (0x2800)
15,148675,14487139000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:16.267193
15,148676,14487139000,-;btmon:         Num handles: 1
15,148677,14487139000,-;btmon:         Handle: 128
15,148678,14487139000,-;btmon:         Count: 1
15,148679,14487156000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 26             [hci0] 16:45:16.284511
15,148680,14487156000,-;btmon:       ATT: Read By Group Type Response
(0x11) len 21
15,148681,14487156000,-;btmon:         Attribute data length: 20
15,148682,14487156000,-;btmon:         Attribute group list: 1 entry
15,148683,14487157000,-;btmon:         Handle range: 0x0071-0xffff
15,148684,14487157000,-;btmon:         UUID: Vendor specific
(f000ffc0-0451-4000-b000-000000000000)
15,148685,14487157000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() Primary services found: 9
15,148686,14487157000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0001, end: 0x000b, uuid:
00001800-0000-1000-8000-00805f9b34fb
15,148687,14487157000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x000c, end: 0x000f, uuid:
00001801-0000-1000-8000-00805f9b34fb
15,148688,14487158000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0010, end: 0x0022, uuid:
0000180a-0000-1000-8000-00805f9b34fb
15,148689,14487158000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0023, end: 0x0028, uuid:
0000180f-0000-1000-8000-00805f9b34fb
15,148690,14487160000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0029, end: 0x002e, uuid:
00001813-0000-1000-8000-00805f9b34fb
15,148691,14487160000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x002f, end: 0x0037, uuid:
0000fff0-0000-1000-8000-00805f9b34fb
15,148692,14487160000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0038, end: 0x005c, uuid:
00001812-0000-1000-8000-00805f9b34fb
15,148693,14487161000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x005d, end: 0x0070, uuid:
f000fef0-0451-4000-b000-000000000000
15,148694,14487163000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() start: 0x0071, end: 0xffff, uuid:
f000ffc0-0451-4000-b000-000000000000
15,148695,14487166000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_client_ready_cb() status: success, error: 0
15,148696,14487169000,-;bluez: bluetoothd[1985]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
15,148697,14487169000,-;bluez: bluetoothd[1985]:
src/gatt-client.c:create_services() Exporting objects for GATT
services: D4:F5:13:xx:xx:xx
15,148698,14487169000,-;bluez: bluetoothd[1985]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_D4_F5_13_xx_xx_xx err 0
15,148700,14487208000,-;btmon: < ACL Data TX: Handle 128 flags 0x00
dlen 9              [hci0] 16:45:16.336263
15,148701,14487208000,-;btmon:       ATT: Write Request (0x12) len 4
15,148702,14487208000,-;btmon:         Handle: 0x000f
15,148703,14487208000,-;btmon:           Data: 0200
15,148713,14487675000,-;btmon: > HCI Event: Number of Completed
Packets (0x13) plen 5   [hci0] 16:45:16.803794
15,148714,14487675000,-;btmon:         Num handles: 1
15,148715,14487676000,-;btmon:         Handle: 128
15,148716,14487676000,-;btmon:         Count: 1
15,148717,14487705000,-;btmon: > ACL Data RX: Handle 128 flags 0x02
dlen 5              [hci0] 16:45:16.833390
15,148718,14487705000,-;btmon:       ATT: Write Response (0x13) len 0
15,148719,14487706000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() Registered handler for "Service Changed": 2


In the above log, I see that MTU exchange takes place:
15,148467,14484676000,-;bluez: bluetoothd[1985]:
src/device.c:gatt_debug() MTU exchange complete, with MTU: 23

Looking at the relevant code in src/shared/gatt-client.c, function
exchange_mtu_cb():

        util_debug(client->debug_callback, client->debug_data,
                                        "MTU exchange complete, with MTU: %u",
                                        bt_att_get_mtu(client->att));

discover:
        client->discovery_req = bt_gatt_discover_all_primary_services(
                                                        client->att, NULL,
                                                        discover_primary_cb,
                                                        discovery_op_ref(op),
                                                        discovery_op_unref);


The call to bt_gatt_discover_all_primary_services() is unconditional,
whether the device was previously bonded or not.

-- Petri
