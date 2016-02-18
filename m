Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Bluez LE: Unable to get readings from LE devices
To: linux-bluetooth@vger.kernel.org
References: <56C5F299.5080909@prudentl.com>
From: ram <ram@prudentl.com>
Message-ID: <56C5F69E.6080207@prudentl.com>
Date: Thu, 18 Feb 2016 11:51:42 -0500
MIME-Version: 1.0
In-Reply-To: <56C5F299.5080909@prudentl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We are working on integrating a set of medical devices from TaiDoc using 
Bluez. These devices work very well on Android and iPhone. We can get it 
paired to a Linux machine successfully using our custom agent. However, 
after the first reading, our driver goes into a loop trying to retrieve 
the reading unsuccessfully.

With release 5.37, the services and characteristics kept on loading and 
unloading. However, with the recent patches, btmon gives error asking 
for pin or key. The devices don't have any pin to authenticate. I'm 
attaching btmon and Bluez output. Would appreciate any feedback.

Measurement Reading bluetoothd and btmon output:

bluetoothd[6591]: src/adapter.c:connected_callback() hci0 device 
C0:26:DF:00:05:5A connected eir_len 0
bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security 
level since LTK is available
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xeda6f0: g_attrib_ref=1
bluetoothd[6591]: src/service.c:change_state() 0xee1a10: device 
C0:26:DF:00:05:5A profile 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 state 
changed: disconnected -> connecting (0)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/gatt-client.c:register_notify() Re-register 
subscribed notification client
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 2
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x0001, 
end: 0x0007
bluetoothd[6591]: src/service.c:change_state() 0xee1330: device 
C0:26:DF:00:05:5A profile gap-profile state changed: connecting -> 
disconnected (-103)
bluetoothd[6591]: src/device.c:device_profile_connected() gap-profile 
Software caused connection abort (103)
bluetoothd[6591]: src/service.c:change_state() 0xee1330: device 
C0:26:DF:00:05:5A profile gap-profile state changed: disconnected -> 
unavailable (0)
bluetoothd[6591]: profiles/gap/gas.c:gap_driver_remove() GAP profile 
remove (C0:26:DF:00:05:5A)
bluetoothd[6591]: src/service.c:btd_service_unref() 0xee1330: ref=0
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x0001, end: 0x0007
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x0008, 
end: 0x000b
bluetoothd[6591]: src/service.c:change_state() 0xee1700: device 
C0:26:DF:00:05:5A profile Proximity Reporter GATT Driver state changed: 
connecting -> disconnected (-103)
bluetoothd[6591]: src/device.c:device_profile_connected() Proximity 
Reporter GATT Driver Software caused connection abort (103)
bluetoothd[6591]: src/service.c:change_state() 0xee1700: device 
C0:26:DF:00:05:5A profile Proximity Reporter GATT Driver state changed: 
disconnected -> unavailable (0)
bluetoothd[6591]: 
profiles/proximity/reporter.c:unregister_reporter_device() unregister on 
device /org/bluez/hci0/dev_C0_26_DF_00_05_5A
bluetoothd[6591]: src/service.c:btd_service_unref() 0xee1700: ref=0
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x0008, end: 0x000b
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x000c, 
end: 0x0011
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x000c, end: 0x0011
bluetoothd[6591]: src/gatt-client.c:unregister_service() Removing GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char000d
bluetoothd[6591]: src/gatt-client.c:unregister_descriptor() Removing 
GATT descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char000d/desc000f
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char0010
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x0012, 
end: 0x0015
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x0012, end: 0x0015
bluetoothd[6591]: src/gatt-client.c:unregister_service() Removing GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012/char0013
bluetoothd[6591]: src/gatt-client.c:unregister_descriptor() Removing 
GATT descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012/char0013/desc0015
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x0016, 
end: 0x001a
bluetoothd[6591]: src/service.c:change_state() 0xedab70: device 
C0:26:DF:00:05:5A profile deviceinfo state changed: connecting -> 
disconnected (-103)
bluetoothd[6591]: src/device.c:device_profile_connected() deviceinfo 
Software caused connection abort (103)
bluetoothd[6591]: src/service.c:change_state() 0xedab70: device 
C0:26:DF:00:05:5A profile deviceinfo state changed: disconnected -> 
unavailable (0)
bluetoothd[6591]: src/service.c:btd_service_unref() 0xedab70: ref=0
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x0016, end: 0x001a
bluetoothd[6591]: src/gatt-client.c:unregister_service() Removing GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016/char0017
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016/char0019
bluetoothd[6591]: src/device.c:gatt_service_removed() start: 0x001b, 
end: 0xffff
bluetoothd[6591]: src/service.c:change_state() 0xee1a10: device 
C0:26:DF:00:05:5A profile 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 state 
changed: connecting -> disconnected (-103)
bluetoothd[6591]: src/device.c:device_profile_connected() 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 Software 
caused connection abort (103)
bluetoothd[6591]: src/service.c:change_state() 0xee1a10: device 
C0:26:DF:00:05:5A profile 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 state 
changed: disconnected -> unavailable (0)
bluetoothd[6591]: src/gatt-database.c:profile_device_remove() 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 removed
bluetoothd[6591]: src/service.c:btd_service_unref() 0xee1a10: ref=0
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_service_removed() 
GATT Services Removed - start: 0x001b, end: 0xffff
bluetoothd[6591]: src/gatt-client.c:unregister_service() Removing GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b
bluetoothd[6591]: src/gatt-client.c:unregister_characteristic() Removing 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b/char001c
bluetoothd[6591]: src/gatt-client.c:notify_client_unref() owner :1.31
bluetoothd[6591]: src/gatt-client.c:notify_client_free() owner :1.31
bluetoothd[6591]: src/gatt-client.c:unregister_descriptor() Removing 
GATT descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b/char001c/desc001e
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Software caused 
connection abort (103)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xeda6f0: 
g_attrib_unref=0
bluetoothd[6591]: src/adapter.c:connected_callback() hci0 device 
C0:26:DF:00:05:5A connected eir_len 0
bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security 
level since LTK is available
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xed9d50: g_attrib_ref=1
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/device.c:load_gatt_db() Restoring 
C0:26:DF:00:05:5A gatt database from file
bluetoothd[6591]: No cache for C0:26:DF:00:05:5A
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 2
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Software caused 
connection abort (103)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xed9d50: 
g_attrib_unref=0
bluetoothd[6591]: src/adapter.c:connected_callback() hci0 device 
C0:26:DF:00:05:5A connected eir_len 0
bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security 
level since LTK is available
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xed9d50: g_attrib_ref=1
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/device.c:load_gatt_db() Restoring 
C0:26:DF:00:05:5A gatt database from file
bluetoothd[6591]: No cache for C0:26:DF:00:05:5A
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 2
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Software caused 
connection abort (103)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xed9d50: 
g_attrib_unref=0
bluetoothd[6591]: src/adapter.c:connected_callback() hci0 device 
C0:26:DF:00:05:5A connected eir_len 0
bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security 
level since LTK is available
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xed9d50: g_attrib_ref=1
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/device.c:load_gatt_db() Restoring 
C0:26:DF:00:05:5A gatt database from file
bluetoothd[6591]: No cache for C0:26:DF:00:05:5A
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 2
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Software caused 
connection abort (103)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xed9d50: 
g_attrib_unref=0
bluetoothd[6591]: src/adapter.c:connected_callback() hci0 device 
C0:26:DF:00:05:5A connected eir_len 0
bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security 
level since LTK is available
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xed9d50: g_attrib_ref=1
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/device.c:load_gatt_db() Restoring 
C0:26:DF:00:05:5A gatt database from file
bluetoothd[6591]: No cache for C0:26:DF:00:05:5A
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 2
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Software caused 
connection abort (103)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xed9d50: 
g_attrib_unref=0




 > HCI Event: LE Meta Event (0x3e) plen 41 [hci0] 296.925551
       LE Advertising Report (0x02)
         Num reports: 1
         Event type: Connectable undirected - ADV_IND (0x00)
         Address type: Random (0x01)
         Address: C0:26:DF:00:05:5A (Static)
         Data length: 29
         Name (complete): TAIDOC TD3128
         Appearance: Blood Pressure: Arm (0x0381)
         Flags: 0x05
           LE Limited Discoverable Mode
           BR/EDR Not Supported
         RSSI: -76 dBm (0xb4)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 
2                                                            [hci0] 
296.925575
         Scanning: Disabled (0x00)
         Filter duplicates: Disabled (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 296.954523
       LE Set Scan Enable (0x08|0x000c) ncmd 2
         Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 
25                                                         [hci0] 296.954539
         Scan interval: 60.000 msec (0x0060)
         Scan window: 30.000 msec (0x0030)
         Filter policy: White list is not used (0x00)
         Peer address type: Random (0x01)
         Peer address: C0:26:DF:00:05:5A (Static)
         Own address type: Public (0x00)
         Min connection interval: 50.00 msec (0x0028)
         Max connection interval: 70.00 msec (0x0038)
         Connection latency: 0x0000
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 296.955522
       LE Create Connection (0x08|0x000d) ncmd 2
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 19 [hci0] 297.445535
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 3585
         Role: Master (0x00)
         Peer address type: Random (0x01)
         Peer address: C0:26:DF:00:05:5A (Static)
         Connection interval: 70.00 msec (0x0038)
         Connection latency: 0.00 msec (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Master clock accuracy: 0x00
@ Device Connected: C0:26:DF:00:05:5A (2) flags 0x0000
< HCI Command: LE Start Encryption (0x08|0x0019) plen 
28                                                          [hci0] 
297.445757
         Handle: 3585
         Random number: 0xf53b3985eb209692
         Encrypted diversifier: 0xe663
         Long term key: 212ee6d22e00b56286a69a3322d4ed00
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 297.446496
       LE Start Encryption (0x08|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event: Encryption Change (0x08) plen 4 [hci0] 298.597523
         Status: PIN or Key Missing (0x06)
         Handle: 3585
         Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3 [hci0] 298.597544
         Handle: 3585
         Reason: Authentication Failure (0x05)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 298.598520
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event: Disconnect Complete (0x05) plen 4 [hci0] 298.737520
         Status: Success (0x00)
         Handle: 3585
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: C0:26:DF:00:05:5A (2) reason 2
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 
7                                                        [hci0] 298.838368
         Type: Passive (0x00)
         Interval: 60.000 msec (0x0060)
         Window: 30.000 msec (0x0030)
         Own address type: Public (0x00)
         Filter policy: Ignore not in white list (0x01)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 298.839519
       LE Set Scan Parameters (0x08|0x000b) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 
2                                                            [hci0] 
298.839535
         Scanning: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 298.840507
       LE Set Scan Enable (0x08|0x000c) ncmd 2
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 41 [hci0] 299.521548
       LE Advertising Report (0x02)
         Num reports: 1
         Event type: Connectable undirected - ADV_IND (0x00)
         Address type: Random (0x01)
         Address: C0:26:DF:00:05:5A (Static)
         Data length: 29
         Name (complete): TAIDOC TD3128
         Appearance: Blood Pressure: Arm (0x0381)
         Flags: 0x05
           LE Limited Discoverable Mode
           BR/EDR Not Supported
         RSSI: -77 dBm (0xb3)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 
2                                                            [hci0] 
299.521604
         Scanning: Disabled (0x00)
         Filter duplicates: Disabled (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 299.533517
       LE Set Scan Enable (0x08|0x000c) ncmd 2
         Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 
25                                                         [hci0] 299.533532
         Scan interval: 60.000 msec (0x0060)
         Scan window: 30.000 msec (0x0030)
         Filter policy: White list is not used (0x00)
         Peer address type: Random (0x01)
         Peer address: C0:26:DF:00:05:5A (Static)
         Own address type: Public (0x00)
         Min connection interval: 50.00 msec (0x0028)
         Max connection interval: 70.00 msec (0x0038)
         Connection latency: 0x0000
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 299.534517
       LE Create Connection (0x08|0x000d) ncmd 2
         Status: Success (0x00)
 > HCI Event: LE Meta Event (0x3e) plen 19 [hci0] 300.027526
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 3585
         Role: Master (0x00)
         Peer address type: Random (0x01)
         Peer address: C0:26:DF:00:05:5A (Static)
         Connection interval: 70.00 msec (0x0038)
         Connection latency: 0.00 msec (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Master clock accuracy: 0x00
@ Device Connected: C0:26:DF:00:05:5A (2) flags 0x0000
< HCI Command: LE Start Encryption (0x08|0x0019) plen 
28                                                          [hci0] 
300.027824
         Handle: 3585
         Random number: 0xf53b3985eb209692
         Encrypted diversifier: 0xe663
         Long term key: 212ee6d22e00b56286a69a3322d4ed00
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 300.028516
       LE Start Encryption (0x08|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event: Encryption Change (0x08) plen 4 [hci0] 301.187517
         Status: PIN or Key Missing (0x06)
         Handle: 3585
         Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3 [hci0] 301.187536
         Handle: 3585
         Reason: Authentication Failure (0x05)
 > HCI Event: Command Status (0x0f) plen 4 [hci0] 301.188514
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event: Disconnect Complete (0x05) plen 4 [hci0] 301.257514
         Status: Success (0x00)
         Handle: 3585
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: C0:26:DF:00:05:5A (2) reason 2



Device Paring Bluez output:

bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT 
connection
bluetoothd[6591]: attrib/gattrib.c:g_attrib_ref() 0xed9d50: g_attrib_ref=1
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_connected() Device 
connected.
bluetoothd[6591]: src/device.c:load_gatt_db() Restoring 
C0:26:DF:00:05:5A gatt database from file
bluetoothd[6591]: No cache for C0:26:DF:00:05:5A
bluetoothd[6591]: src/device.c:gatt_debug() MTU exchange complete, with 
MTU: 23
bluetoothd[6591]: src/device.c:gatt_debug() Primary services found: 6
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0001, end: 0x0007, 
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0008, end: 0x000b, 
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x000c, end: 0x0011, 
uuid: 00001810-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0012, end: 0x0015, 
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0016, end: 0x001a, 
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x001b, end: 0xffff, 
uuid: 00001523-1212-efde-1523-785feabcd123
bluetoothd[6591]: src/device.c:gatt_debug() Secondary service discovery 
failed. ATT ECODE: 0x0a
bluetoothd[6591]: src/adapter.c:new_csrk_callback() hci0 new CSRK for 
C0:26:DF:00:05:5A type 0
bluetoothd[6591]: src/adapter.c:new_long_term_key_callback() hci0 new 
LTK for C0:26:DF:00:05:5A type 0 enc_size 16
bluetoothd[6591]: src/device.c:device_set_bonded()
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding 
0xecb1a0 status 0x00
bluetoothd[6591]: src/device.c:device_bonding_complete() Proceeding with 
service discovery
bluetoothd[6591]: src/agent.c:agent_unref() 0xecf490: ref=1
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/adapter.c:trigger_start_discovery()
bluetoothd[6591]: src/adapter.c:cancel_passive_scanning()
bluetoothd[6591]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0x0
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x00
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/adapter.c:trigger_start_discovery()
bluetoothd[6591]: src/adapter.c:cancel_passive_scanning()
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003, 
value: 0x0003, props: 0x0a, uuid: 00002a00-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005, 
value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007, 
value: 0x0007, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0009, end: 0x000b, 
value: 0x000a, props: 0x20, uuid: 00002a05-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[6591]: src/device.c:gatt_debug() handle: 0x000b, uuid: 
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 2
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x000d, end: 0x000f, 
value: 0x000e, props: 0x20, uuid: 00002a35-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0010, end: 0x0011, 
value: 0x0011, props: 0x02, uuid: 00002a49-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[6591]: src/device.c:gatt_debug() handle: 0x000f, uuid: 
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0013, end: 0x0015, 
value: 0x0014, props: 0x12, uuid: 00002a19-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[6591]: src/device.c:gatt_debug() handle: 0x0015, uuid: 
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 2
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0017, end: 0x0018, 
value: 0x0018, props: 0x02, uuid: 00002a24-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x0019, end: 0x001a, 
value: 0x001a, props: 0x02, uuid: 00002a26-0000-1
bluetoothd[6591]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[6591]: src/device.c:gatt_debug() start: 0x001c, end: 0xffff, 
value: 0x001d, props: 0x38, uuid: 00001524-1212-e
bluetoothd[6591]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[6591]: src/device.c:gatt_debug() handle: 0x001e, uuid: 
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:gatt_client_ready_cb() status: success, 
error: 10
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
00001810-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/device.c:update_gatt_uuids() UUID Added: 
00001523-1212-efde-1523-785feabcd123
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: profiles/gap/gas.c:gap_driver_probe() GAP profile 
probe (C0:26:DF:00:05:5A)
bluetoothd[6591]: src/service.c:change_state() 0xee1330: device 
C0:26:DF:00:05:5A profile gap-profile state changed: unavailable -> 
disconnected (0)
bluetoothd[6591]: profiles/gap/gas.c:gap_driver_accept() GAP profile 
accept (C0:26:DF:00:05:5A)
bluetoothd[6591]: profiles/gap/gas.c:handle_characteristic() Unsupported 
characteristic: 00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/service.c:change_state() 0xee1330: device 
C0:26:DF:00:05:5A profile gap-profile state changed: disconnected -> 
connecting (0)
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: 
profiles/proximity/reporter.c:register_reporter_device() register on 
device /org/bluez/hci0/dev_C0_26_DF_00_05_5A
bluetoothd[6591]: src/service.c:change_state() 0xee1700: device 
C0:26:DF:00:05:5A profile Proximity Reporter GATT Driver state changed: 
unavailable -> disconnected (0)
bluetoothd[6591]: src/service.c:change_state() 0xee1700: device 
C0:26:DF:00:05:5A profile Proximity Reporter GATT Driver state changed: 
disconnected -> connecting (0)
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: src/service.c:change_state() 0xedab70: device 
C0:26:DF:00:05:5A profile deviceinfo state changed: unavailable -> 
disconnected (0)
bluetoothd[6591]: 
profiles/deviceinfo/deviceinfo.c:deviceinfo_driver_accept() deviceinfo 
profile accept (C0:26:DF:00:05:5A)
bluetoothd[6591]: 
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported 
characteristic: 00002a24-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: 
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported 
characteristic: 00002a26-0000-1000-8000-00805f9b34fb
bluetoothd[6591]: src/service.c:change_state() 0xedab70: device 
C0:26:DF:00:05:5A profile deviceinfo state changed: disconnected -> 
connecting (0)
bluetoothd[6591]: src/device.c:device_probe_profiles() Probing profiles 
for device C0:26:DF:00:05:5A
bluetoothd[6591]: src/device.c:device_svc_resolved() 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A err 0
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_ready() GATT client 
ready
bluetoothd[6591]: src/gatt-client.c:create_services() Exporting objects 
for GATT services: C0:26:DF:00:05:5A
bluetoothd[6591]: src/gatt-client.c:service_create() Exported GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char000d
bluetoothd[6591]: src/gatt-client.c:descriptor_create() Exported GATT 
characteristic descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char000d/desc000f
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service000c/char0010
bluetoothd[6591]: src/gatt-client.c:service_create() Exported GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012/char0013
bluetoothd[6591]: src/gatt-client.c:descriptor_create() Exported GATT 
characteristic descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0012/char0013/desc0015
bluetoothd[6591]: src/gatt-client.c:service_create() Exported GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016/char0017
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service0016/char0019
bluetoothd[6591]: src/gatt-client.c:service_create() Exported GATT 
service: /org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b
bluetoothd[6591]: src/gatt-client.c:characteristic_create() Exported 
GATT characteristic: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b/char001c
bluetoothd[6591]: src/gatt-client.c:descriptor_create() Exported GATT 
characteristic descriptor: 
/org/bluez/hci0/dev_C0_26_DF_00_05_5A/service001b/char001c/desc001e
bluetoothd[6591]: src/gatt-database.c:manager_register_profile() sender 
:1.32
bluetoothd[6591]: src/gatt-database.c:profile_add() Added 
":1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123"
bluetoothd[6591]: src/gatt-database.c:profile_device_probe() 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 probed
bluetoothd[6591]: src/service.c:change_state() 0xee1a10: device 
C0:26:DF:00:05:5A profile 
:1.32/com/.../gatt_profile/00001523-1212-efde-1523-785feabcd123 state 
changed: unavailable -> disconnected (0)
bluetoothd[6591]: src/device.c:device_set_auto_connect() 
C0:26:DF:00:05:5A auto connect: 1
bluetoothd[6591]: src/device.c:device_set_auto_connect() Already connected
bluetoothd[6591]: src/adapter.c:add_device_complete() C0:26:DF:00:05:5A 
(2) added to kernel connect list
bluetoothd[6591]: src/gatt-client.c:notify_client_ref() owner :1.31
bluetoothd[6591]: src/device.c:gatt_debug() Registered handler for 
"Service Changed": 1
bluetoothd[6591]: profiles/gap/gas.c:read_device_name_cb() GAP Device 
Name: TAIDOC TD3128
bluetoothd[6591]: profiles/gap/gas.c:read_appearance_cb() GAP 
Appearance: 0x0381
bluetoothd[6591]: src/adapter.c:start_discovery_timeout()
bluetoothd[6591]: src/adapter.c:start_discovery_timeout() 
adapter->current_discovery_filter == 0
bluetoothd[6591]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[6591]: src/adapter.c:discovering_callback() hci0 type 7 
discovering 1 method 0
bluetoothd[6591]: src/adapter.c:stop_discovery() sender :1.29
bluetoothd[6591]: src/adapter.c:discovery_destroy() owner :1.29
bluetoothd[6591]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[6591]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[6591]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[6591]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[6591]: src/adapter.c:trigger_passive_scanning()
bluetoothd[6591]: src/adapter.c:discovering_callback() hci0 type 7 
discovering 0 method 0
bluetoothd[6591]: src/adapter.c:dev_disconnected() Device 
C0:26:DF:00:05:5A disconnected, reason 1
bluetoothd[6591]: src/adapter.c:adapter_remove_connection()
bluetoothd[6591]: plugins/policy.c:disconnect_cb() reason 1
bluetoothd[6591]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
C0:26:DF:00:05:5A type 2 status 0xe
bluetoothd[6591]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x0e
bluetoothd[6591]: src/device.c:device_bonding_failed() status 14
bluetoothd[6591]: src/adapter.c:resume_discovery()
bluetoothd[6591]: src/device.c:att_disconnected_cb()
bluetoothd[6591]: src/device.c:att_disconnected_cb() Connection timed 
out (110)
bluetoothd[6591]: src/gatt-client.c:btd_gatt_client_disconnected() 
Device disconnected. Cleaning up.
bluetoothd[6591]: attrib/gattrib.c:g_attrib_unref() 0xed9d50: 
g_attrib_unref=0
