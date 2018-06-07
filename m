Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: pn@denx.de
From: Parthiban Nallathambi <pn@denx.de>
Subject: Bluetooth controller power off and on
Message-ID: <6989de77-7e28-6b4f-d47b-918dd2441c74@denx.de>
Date: Thu, 7 Jun 2018 21:14:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

My bluetooth controller is automatically turns off and on during a particular sequence of operation in bluetoothctl (sequence copied below).

I can see the below line in dmesg output marked in red. But I am not sure about the management command which is failed. I have also atttached
the bluetooth service log from journalctl after enabling debug using SIGUSR2 signal.

>From dmesg:
"Bluetooth: hci0: last event is not cmd complete (0x0f)"

Is this something to do with Bluetooth adapter or USB level errors? Thanks in advance the help.

bluetoothctl sequence:
=======================
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 50:B7:C3:59:89:AF Discovering: yes
[NEW] Device 78:02:F8:8B:D3:4E Soundarya
[bluetooth]# discoverable on
Changing discoverable on succeeded
[CHG] Controller 50:B7:C3:59:89:AF Discoverable: yes
[bluetooth]# pairable on
Changing pairable on succeeded
[NEW] Device A0:2C:36:83:3C:86 LM1182
[CHG] Device A0:2C:36:83:3C:86 RSSI: -85
[NEW] Device C4:86:E9:CA:84:B4 Honor Parthiban
[CHG] Device 78:02:F8:8B:D3:4E RSSI is nil
[DEL] Device 78:02:F8:8B:D3:4E Soundarya
[CHG] Device A0:2C:36:83:3C:86 TxPower is nil
[CHG] Device A0:2C:36:83:3C:86 RSSI is nil
[DEL] Device A0:2C:36:83:3C:86 LM1182
[CHG] Device C4:86:E9:CA:84:B4 RSSI is nil
[DEL] Device C4:86:E9:CA:84:B4 Honor Parthiban
[CHG] Controller 50:B7:C3:59:89:AF Class: 0x00000000 	===> Controller reset?
[CHG] Controller 50:B7:C3:59:89:AF Powered: no
[CHG] Controller 50:B7:C3:59:89:AF Discovering: no
[CHG] Controller 50:B7:C3:59:89:AF Discoverable: no
[DEL] Controller 50:B7:C3:59:89:AF parthiban [default]
[NEW] Controller 50:B7:C3:59:89:AF parthiban [default]
[CHG] Controller 50:B7:C3:59:89:AF Class: 0x0010010c
[CHG] Controller 50:B7:C3:59:89:AF Powered: yes

dmesg:
======
[   94.747481] Bluetooth: RFCOMM TTY layer initialized
[   94.747492] Bluetooth: RFCOMM socket layer initialized
[   94.747501] Bluetooth: RFCOMM ver 1.11
[  122.143297] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  132.693648] usb 6-1: USB disconnect, device number 3
[  132.693902] Bluetooth: hci0: failed to disable LE scan: status 0x1f
[  132.846970] usb 6-1: new full-speed USB device number 4 using ohci-pci
[  133.037185] usb 6-1: string descriptor 0 read error: -22
[  133.037194] usb 6-1: New USB device found, idVendor=0cf3, idProduct=3004
[  133.037199] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  326.146347] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  336.595548] usb 6-1: USB disconnect, device number 4
[  336.595902] Bluetooth: hci0: failed to disable LE scan: status 0x1f
[  336.745366] usb 6-1: new full-speed USB device number 5 using ohci-pci
[  336.935868] usb 6-1: string descriptor 0 read error: -22
[  336.935881] usb 6-1: New USB device found, idVendor=0cf3, idProduct=3004
[  336.935886] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  469.204101] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  485.150940] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  495.516682] usb 6-1: USB disconnect, device number 5
[  495.516988] Bluetooth: hci0: failed to disable LE scan: status 0x1f
[  495.666618] usb 6-1: new full-speed USB device number 6 using ohci-pci
[  495.857004] usb 6-1: string descriptor 0 read error: -22
[  495.857017] usb 6-1: New USB device found, idVendor=0cf3, idProduct=3004
[  495.857022] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3

journalctl -u bluetooth --since today:
======================================

Jun 07 20:11:44 parthiban bluetoothd[367]: Bluetooth daemon 5.49
Jun 07 20:11:46 parthiban systemd[1]: Started Bluetooth service.
Jun 07 20:11:46 parthiban bluetoothd[367]: Starting SDP server
Jun 07 20:11:46 parthiban bluetoothd[367]: Bluetooth management interface 1.14 initialized
Jun 07 20:15:06 parthiban systemd[1]: Stopping Bluetooth service...
Jun 07 20:15:06 parthiban bluetoothd[367]: Terminating
Jun 07 20:15:06 parthiban bluetoothd[367]: Stopping SDP server
Jun 07 20:15:06 parthiban bluetoothd[367]: Exit
Jun 07 20:15:06 parthiban systemd[1]: Stopped Bluetooth service.
Jun 07 20:15:06 parthiban systemd[1]: Starting Bluetooth service...
Jun 07 20:15:06 parthiban bluetoothd[12504]: Bluetooth daemon 5.49
Jun 07 20:15:06 parthiban systemd[1]: Started Bluetooth service.
Jun 07 20:15:06 parthiban bluetoothd[12504]: Starting SDP server
Jun 07 20:15:06 parthiban bluetoothd[12504]: Bluetooth management interface 1.14 initialized
Jun 07 20:15:35 parthiban systemd[1]: bluetooth.service: Current command vanished from the unit file, execution of the command list w>
Jun 07 20:18:07 parthiban systemd[1]: bluetooth.service: Main process exited, code=killed, status=10/USR1
Jun 07 20:18:07 parthiban systemd[1]: bluetooth.service: Failed with result 'signal'.
Jun 07 20:18:28 parthiban systemd[1]: Starting Bluetooth service...
Jun 07 20:18:28 parthiban bluetoothd[12679]: Bluetooth daemon 5.49
Jun 07 20:18:28 parthiban systemd[1]: Started Bluetooth service.
Jun 07 20:18:28 parthiban bluetoothd[12679]: Starting SDP server
Jun 07 20:18:28 parthiban bluetoothd[12679]: Bluetooth management interface 1.14 initialized
Jun 07 20:18:28 parthiban bluetoothd[12679]: Failed to set privacy: Rejected (0x0b)
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:start_discovery() sender :1.52
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:update_discovery_filter()
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:discovery_filter_to_mgmt_cp()
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:trigger_start_discovery()
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:cancel_passive_scanning()
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_timeout()
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 0
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_complete() status 0x00
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:discovering_callback() hci0 type 7 discovering 1 method 0
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 08:9E:08:BE:B3:FC, rssi -83 flags 0x0004>
Jun 07 20:19:05 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 54:60:09:0F:7D:D3, rssi -66 flags 0x0004>
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 78:02:F8:8B:D3:4E, rssi -88 flags 0x0000>
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_create() dst 78:02:F8:8B:D3:4E
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_new() address 78:02:F8:8B:D3:4E
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_78_02_F8_8B_D3_4E
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_set_legacy() legacy 0
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi -88
Jun 07 20:19:06 parthiban bluetoothd[12679]: src/device.c:device_set_class() /org/bluez/hci0/dev_78_02_F8_8B_D3_4E 0x5A020C
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:set_mode() sending set mode command for index 0
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:property_set_mode() sending Set Discoverable command for index 0
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000ad3
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000002
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:property_set_mode_complete() Success (0x00)
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000adb
Jun 07 20:19:09 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000008
Jun 07 20:19:15 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr A0:2C:36:83:3C:86, rssi -95 flags 0x0000>
Jun 07 20:19:15 parthiban bluetoothd[12679]: src/device.c:device_create() dst A0:2C:36:83:3C:86
Jun 07 20:19:15 parthiban bluetoothd[12679]: src/device.c:device_new() address A0:2C:36:83:3C:86
Jun 07 20:19:15 parthiban bluetoothd[12679]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_A0_2C_36_83_3C_86
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/device.c:device_set_legacy() legacy 0
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi -95
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/device.c:device_set_tx_power() tx_power 0
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/device.c:device_set_flags() flags 6
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/adapter.c:discovering_callback() hci0 type 7 discovering 0 method 0
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/adapter.c:trigger_start_discovery()
Jun 07 20:19:16 parthiban bluetoothd[12679]: src/adapter.c:cancel_passive_scanning()
Jun 07 20:19:21 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_timeout()
Jun 07 20:19:21 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 0
Jun 07 20:19:21 parthiban bluetoothd[12679]: src/adapter.c:start_discovery_complete() status 0x00
Jun 07 20:19:21 parthiban bluetoothd[12679]: src/adapter.c:discovering_callback() hci0 type 7 discovering 1 method 0
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 78:02:F8:8B:D3:4E, rssi -84 flags 0x0000>
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/device.c:device_set_legacy() legacy 0
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 54:60:09:0F:7D:D3, rssi -77 flags 0x0004>
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr 08:9E:08:BE:B3:FC, rssi -74 flags 0x0004>
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr A0:2C:36:83:3C:86, rssi -85 flags 0x0000>
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/device.c:device_set_legacy() legacy 0
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi -85 delta 10
Jun 07 20:19:22 parthiban bluetoothd[12679]: src/device.c:device_set_flags() flags 6
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/adapter.c:device_found_callback() hci0 addr C4:86:E9:CA:84:B4, rssi -65 flags 0x0000>
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_create() dst C4:86:E9:CA:84:B4
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_new() address C4:86:E9:CA:84:B4
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_C4_86_E9_CA_84_B4
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_set_legacy() legacy 0
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi -65
Jun 07 20:19:24 parthiban bluetoothd[12679]: src/device.c:device_set_class() /org/bluez/hci0/dev_C4_86_E9_CA_84_B4 0x5A020C
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:discovering_callback() hci0 type 7 discovering 0 method 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:trigger_start_discovery()
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:cancel_passive_scanning()
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:dev_class_changed_callback() Class: 0x000000
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/rfkill.c:rfkill_event() RFKILL event idx 3 type 2 op 1 soft 0 hard 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000ad2
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000009
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:cancel_passive_scanning()
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_set_tx_power() tx_power 127
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_set_rssi_with_delta() rssi 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0 has been disabled
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:index_removed() index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_unregister() Unregister path: /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_78_02_F8_8B_D3_4E
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_78_02_F8_8B_D3_4E
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_free() 0x55e119b8c2d0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_A0_2C_36_83_3C_86
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_A0_2C_36_83_3C_86
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_free() 0x55e119b8ddf0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_C4_86_E9_CA_84_B4
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_C4_86_E9_CA_84_B4
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/device.c:device_free() 0x55e119b8e070
Jun 07 20:19:32 parthiban bluetoothd[12679]: plugins/hostname.c:hostname_remove()
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:media_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() ":1.51/org/bluez/obex/00005005_0000_1000_8000_0002ee0>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10009
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "Object Push" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10008
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "File Transfer" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10007
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "Synchronization" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "Phone Book Access" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10005
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "Message Access" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_remove() "Message Notification" removed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:a2dp_source_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:a2dp_sink_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/avrcp.c:avrcp_target_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/avrcp.c:avrcp_controller_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:nap_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:gn_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:panu_server_remove() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/server.c:path_unregister() Unregistered interface org.bluez.NetworkServ>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_unref() Freeing adapter /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_free() 0x55e119b7c7c0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/rfkill.c:rfkill_event() RFKILL event idx 4 type 2 op 0 soft 0 hard 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:index_added() index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.49
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() Major class: 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() Minor class: 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d0531
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:index_added() sending read info command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:read_info_complete() index 0 status 0x00
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:clear_devices() sending clear devices command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_mode() sending set mode command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_mode() sending set mode command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_mode() sending set mode command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_privacy() sending set privacy command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_privacy() setting privacy mode 0x00 for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bl>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/advertising.c:btd_adv_manager_new() LE Advertising Manager created for adapter: /org>
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: plugins/hostname.c:hostname_probe()
Jun 07 20:19:32 parthiban bluetoothd[12679]: plugins/hostname.c:update_name() name: parthiban
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_set_name() name: parthiban
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_set_name() alias: parthiban
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_name() sending set local name command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_set_class() class: major 1 minor 3
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_dev_class() sending set device class command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:panu_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/server.c:server_register() Registered interface org.bluez.NetworkServer>
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:gn_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/network/manager.c:nap_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/avrcp.c:avrcp_controller_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110f-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/avrcp.c:avrcp_target_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: profiles/audio/a2dp.c:a2dp_source_server_probe() path /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "Message Notification" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Message Notification listening on PSM 4097
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Message Notification listening on chan 17
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001133-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001134-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "Message Access" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Message Access listening on PSM 4099
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Message Access listening on chan 16
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001132-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001134-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "Phone Book Access" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Phone Book Access listening on PSM 4101
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Phone Book Access listening on chan 15
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000112f-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001130-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "Synchronization" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Synchronization listening on chan 14
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001104-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "File Transfer" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() File Transfer listening on PSM 4103
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() File Transfer listening on chan 10
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10007
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001106-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() "Object Push" probed
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Object Push listening on PSM 4105
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_start_servers() Object Push listening on chan 9
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10008
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001105-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/profile.c:ext_adapter_probe() ":1.51/org/bluez/obex/00005005_0000_1000_8000_0002ee00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_add() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10009
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00005005-0000-1000-8000-00>
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_ltks() hci0 keys 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_irks() hci0 irks 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_conn_params() hci0 conn params 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:add_uuid() sending add uuid command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 531
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_dev_class() sending set device class command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_name() sending set local name command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_mode() sending set mode command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x000000c0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000040
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x000002c0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000200
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000ac0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000800
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:set_privacy_complete() Successfuly set privacy for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:local_name_changed_callback() Name: parthiban
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:local_name_changed_callback() Short name:
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:local_name_changed_callback() Current alias: parthiban
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000ad0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000010
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:property_set_mode() sending Set Powered command for index 0
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:dev_class_changed_callback() Class: 0x10010c
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:property_set_mode_complete() Success (0x00)
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:new_settings_callback() Settings: 0x00000ad1
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:settings_changed() Changed settings: 0x00000001
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
Jun 07 20:19:32 parthiban bluetoothd[12679]: src/adapter.c:trigger_passive_scanning()
Jun 07 20:19:41 parthiban bluetoothd[12679]: src/agent.c:agent_disconnect() Agent :1.52 disconnected
Jun 07 20:19:41 parthiban bluetoothd[12679]: src/agent.c:agent_destroy() agent :1.52
Jun 07 20:19:41 parthiban bluetoothd[12679]: src/agent.c:agent_unref() 0x55e119b7ae60: ref=0


-- 
Thanks,
Parthiban N

