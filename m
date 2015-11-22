Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <58FD7F101A2B4D9AB24C5AB9404F6923@boyiliaoPC>
From: <boyiliao@yahoo.com.tw>
To: <linux-bluetooth@vger.kernel.org>, <Majordomo@vger.kernel.org>
Subject: bluetoothd crashes when connecting to XiaoMi RC
Date: Sun, 22 Nov 2015 08:21:58 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0051_01D124FE.DAD96B30"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

這是 MIME 格式的 Multipart 郵件。

------=_NextPart_000_0051_01D124FE.DAD96B30
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi,

I am using bluez 5.35 on Raspberry pi (kernel 4.1.6).

I try to using XiaoMi BLE remote control on Raspberry pi , I found when 
gatt.c gatt_read_char() function call gattrib.c g_attrib_ref () will cause 
bluetoothd crashed, because I think it acess a wrong address 
"attrib/gattrib.c:g_attrib_ref() 0x1c9210: g_attrib_ref=808464433"

the attachment is the bluetoothd log


BR,
Patrick 

------=_NextPart_000_0051_01D124FE.DAD96B30
Content-Type: text/plain;
	format=flowed;
	name="bluez_XiMi_log.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bluez_XiMi_log.txt"

bluetoothd[7711]: src/device.c:device_bonding_failed() status 14
bluetoothd[7711]: src/adapter.c:resume_discovery()
bluetoothd[7711]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[7711]: src/device.c:device_remove() Removing device =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A
bluetoothd[7711]: src/service.c:change_state() 0x1bb288: device =
5C:31:3E:60:1F:1A profile deviceinfo state changed: disconnected -> =
unavailable (0)
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c0e90: =
g_attrib_unref=3D2
bluetoothd[7711]: src/service.c:btd_service_unref() 0x1bb288: ref=3D0
bluetoothd[7711]: src/service.c:change_state() 0x1bc638: device =
5C:31:3E:60:1F:1A profile Scan Parameters Client Driver state changed: =
disconnected -> unavailable (0)
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c0e90: =
g_attrib_unref=3D1
bluetoothd[7711]: src/service.c:btd_service_unref() 0x1bc638: ref=3D0
bluetoothd[7711]: src/service.c:change_state() 0x1bc690: device =
5C:31:3E:60:1F:1A profile gap-profile state changed: disconnected -> =
unavailable (0)
bluetoothd[7711]: profiles/gap/gas.c:gap_driver_remove() GAP profile =
remove (5C:31:3E:60:1F:1A)
bluetoothd[7711]: src/service.c:btd_service_unref() 0x1bc690: ref=3D0
bluetoothd[7711]: src/service.c:change_state() 0x1bc710: device =
5C:31:3E:60:1F:1A profile input-hog state changed: disconnected -> =
unavailable (0)
bluetoothd[7711]: profiles/input/hog.c:hog_remove() path =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c0e90: =
g_attrib_unref=3D0
bluetoothd[7711]: src/service.c:btd_service_unref() 0x1bc710: ref=3D0
bluetoothd[7711]: src/device.c:btd_device_unref() Freeing device =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A
bluetoothd[7711]: src/device.c:device_free() 0x1badf8
bluetoothd[7711]: src/adapter.c:remove_whitelist_complete() =
5C:31:3E:60:1F:1A removed from kernel whitelist
bluetoothd[7711]: src/adapter.c:start_discovery() sender :1.25
bluetoothd[7711]: src/adapter.c:update_discovery_filter()
bluetoothd[7711]: src/adapter.c:discovery_filter_to_mgmt_cp()
bluetoothd[7711]: src/adapter.c:trigger_start_discovery()
bluetoothd[7711]: src/adapter.c:cancel_passive_scanning()
bluetoothd[7711]: src/adapter.c:start_discovery_timeout()
bluetoothd[7711]: src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
bluetoothd[7711]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[7711]: src/adapter.c:discovering_callback() hci0 type 7 =
discovering 1 method 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -65 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_create() dst 5C:31:3E:60:1F:1A
bluetoothd[7711]: src/device.c:device_new() address 5C:31:3E:60:1F:1A
bluetoothd[7711]: src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -65
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -64 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
E0:CE:C3:10:D4:08, rssi -74 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_create() dst E0:CE:C3:10:D4:08
bluetoothd[7711]: src/device.c:device_new() address E0:CE:C3:10:D4:08
bluetoothd[7711]: src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_E0_CE_C3_10_D4_08
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -74
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 4
bluetoothd[7711]: src/device.c:device_set_class() =
/org/bluez/hci0/dev_E0_CE_C3_10_D4_08 0x02010C
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
00:15:00:84:D0:77, rssi -49 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_create() dst 00:15:00:84:D0:77
bluetoothd[7711]: src/device.c:device_new() address 00:15:00:84:D0:77
bluetoothd[7711]: src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_00_15_00_84_D0_77
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -49
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 4
bluetoothd[7711]: src/device.c:device_set_class() =
/org/bluez/hci0/dev_00_15_00_84_D0_77 0x3E010C
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
E0:CE:C3:10:D4:08, rssi -67 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -62 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -67 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
E0:CE:C3:10:D4:08, rssi -68 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -65 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -53 =
delta 12
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -50 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -57 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -50 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -52 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -45 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -45 =
delta 8
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -63 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -63 =
delta 18
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -53 =
delta 10
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -51 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
48:5D:60:21:82:7F, rssi -74 flags 0x0000 eir_len 38
bluetoothd[7711]: src/device.c:device_create() dst 48:5D:60:21:82:7F
bluetoothd[7711]: src/device.c:device_new() address 48:5D:60:21:82:7F
bluetoothd[7711]: src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_48_5D_60_21_82_7F
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -74
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 4
bluetoothd[7711]: src/device.c:device_set_class() =
/org/bluez/hci0/dev_48_5D_60_21_82_7F 0x6E0100
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -61 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -61 =
delta 8
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -52 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -52 =
delta 9
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
E0:91:53:4D:16:84, rssi -83 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_create() dst E0:91:53:4D:16:84
bluetoothd[7711]: src/device.c:device_new() address E0:91:53:4D:16:84
bluetoothd[7711]: src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_E0_91_53_4D_16_84
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -83
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 4
bluetoothd[7711]: src/device.c:device_set_class() =
/org/bluez/hci0/dev_E0_91_53_4D_16_84 0x7E010C
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -52 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -52 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -60 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -60 =
delta 8
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -51 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -51 =
delta 9
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -52 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -66 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -66 =
delta 15
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi -53 =
delta 13
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -53 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -58 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
00:15:00:84:D0:77, rssi -43 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
00:15:00:84:D0:77, rssi -46 flags 0x0000 eir_len 23
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -57 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -58 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -57 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -57 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/device.c:device_set_legacy() legacy 0
bluetoothd[7711]: src/adapter.c:stop_discovery() sender :1.25
bluetoothd[7711]: src/adapter.c:discovery_destroy() owner :1.25
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[7711]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[7711]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
00:15:00:84:D0:77, rssi -39 flags 0x0000 eir_len 23
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
5C:31:3E:60:1F:1A, rssi -59 flags 0x0000 eir_len 39
bluetoothd[7711]: src/adapter.c:device_found_callback() hci0 addr =
20:16:D8:69:86:C2, rssi -81 flags 0x0001 eir_len 5
bluetoothd[7711]: src/adapter.c:discovering_callback() hci0 type 7 =
discovering 0 method 0
bluetoothd[7711]: src/adapter.c:trigger_passive_scanning()
bluetoothd[7711]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[7711]: src/adapter.c:trigger_passive_scanning()
bluetoothd[7711]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[7711]: src/device.c:device_connect_le() Connection attempt =
to: 5C:31:3E:60:1F:1A
bluetoothd[7711]: src/adapter.c:connected_callback() hci0 device =
5C:31:3E:60:1F:1A connected eir_len 0
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D1
bluetoothd[7711]: src/device.c:gatt_debug() MTU exchange complete, with =
MTU: 23
bluetoothd[7711]: src/device.c:gatt_debug() Primary services found: 9
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0001, end: 0x000b, =
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x000c, end: 0x000f, =
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0010, end: 0x0016, =
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0017, end: 0x001b, =
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x001c, end: 0x0021, =
uuid: 00001813-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0022, end: 0x0070, =
uuid: 00001812-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0071, end: 0x0073, =
uuid: 00001803-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0074, end: 0x0076, =
uuid: 00001802-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0077, end: 0xffff, =
uuid: 00001804-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Secondary service discovery =
failed. ATT ECODE: 0x10
bluetoothd[7711]: src/adapter.c:new_irk_callback() hci0 new IRK for =
5C:31:3E:60:1F:1A RPA 00:00:00:00:00:00
bluetoothd[7711]: src/adapter.c:new_csrk_callback() hci0 new CSRK for =
5C:31:3E:60:1F:1A type 1
bluetoothd[7711]: src/adapter.c:new_csrk_callback() hci0 new CSRK for =
5C:31:3E:60:1F:1A type 0
bluetoothd[7711]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK for 5C:31:3E:60:1F:1A type 0 enc_size 16
bluetoothd[7711]: src/device.c:device_set_bonded()
bluetoothd[7711]: src/device.c:device_bonding_complete() bonding (nil) =
status 0x00
bluetoothd[7711]: src/adapter.c:resume_discovery()
bluetoothd[7711]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK for 5C:31:3E:60:1F:1A type 0 enc_size 16
bluetoothd[7711]: src/device.c:device_set_bonded()
bluetoothd[7711]: src/device.c:device_bonding_complete() bonding (nil) =
status 0x00
bluetoothd[7711]: src/adapter.c:resume_discovery()
bluetoothd[7711]: src/device.c:gatt_debug() Included services found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0023, start: =
0x0017, end: 0x001b,uuid: 0000180f-0000-1000-8000-0080
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 5
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003, =
value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005, =
value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007, =
value: 0x0007, props: 0x0a, uuid: 00002a02-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0008, end: 0x0009, =
value: 0x0009, props: 0x08, uuid: 00002a03-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x000a, end: 0x000b, =
value: 0x000b, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x000d, end: 0x000f, =
value: 0x000e, props: 0x20, uuid: 00002a05-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x000f, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0011, end: 0x0012, =
value: 0x0012, props: 0x02, uuid: 00002a25-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0013, end: 0x0014, =
value: 0x0014, props: 0x02, uuid: 00002a28-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0015, end: 0x0016, =
value: 0x0016, props: 0x02, uuid: 00002a50-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0018, end: 0x001b, =
value: 0x0019, props: 0x12, uuid: 00002a19-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x001a, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x001b, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 2
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x001d, end: 0x001e, =
value: 0x001e, props: 0x04, uuid: 00002a4f-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x001f, end: 0x0021, =
value: 0x0020, props: 0x10, uuid: 00002a31-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0021, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/adapter.c:new_conn_param() hci0 5C:31:3E:60:1F:1A =
(1) min 0x0010 max 0x0010 latency 0x012b timeout 0x0c1c
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 26
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0024, end: 0x0025, =
value: 0x0025, props: 0x02, uuid: 00002a4a-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0026, end: 0x0027, =
value: 0x0027, props: 0x04, uuid: 00002a4c-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0028, end: 0x0029, =
value: 0x0029, props: 0x06, uuid: 00002a4e-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x002a, end: 0x002c, =
value: 0x002b, props: 0x02, uuid: 00002a4b-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x002d, end: 0x0030, =
value: 0x002e, props: 0x12, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0031, end: 0x0034, =
value: 0x0032, props: 0x12, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0035, end: 0x0038, =
value: 0x0036, props: 0x12, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0039, end: 0x003b, =
value: 0x003a, props: 0x0e, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x003c, end: 0x003e, =
value: 0x003d, props: 0x12, uuid: 00002a22-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x003f, end: 0x0040, =
value: 0x0040, props: 0x0a, uuid: 00002a32-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0041, end: 0x0043, =
value: 0x0042, props: 0x12, uuid: 00002a33-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0044, end: 0x0046, =
value: 0x0045, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0047, end: 0x0049, =
value: 0x0048, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x004a, end: 0x004c, =
value: 0x004b, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x004d, end: 0x004f, =
value: 0x004e, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0050, end: 0x0052, =
value: 0x0051, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0053, end: 0x0055, =
value: 0x0054, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0056, end: 0x0058, =
value: 0x0057, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0059, end: 0x005b, =
value: 0x005a, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x005c, end: 0x005e, =
value: 0x005d, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x005f, end: 0x0061, =
value: 0x0060, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0062, end: 0x0064, =
value: 0x0063, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0065, end: 0x0067, =
value: 0x0066, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0068, end: 0x006a, =
value: 0x0069, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x006b, end: 0x006d, =
value: 0x006c, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x006e, end: 0x0070, =
value: 0x006f, props: 0x0a, uuid: 00002a4d-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x002c, uuid: =
00002907-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x002f, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0030, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0033, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0034, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0037, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0038, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x003b, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x003e, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0043, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0046, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0049, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x004c, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x004f, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0052, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0055, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0058, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x005b, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x005e, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0061, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0064, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0067, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x006a, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x006d, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x0070, uuid: =
00002908-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0072, end: 0x0073, =
value: 0x0073, props: 0x0a, uuid: 00002a06-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0075, end: 0x0076, =
value: 0x0076, props: 0x04, uuid: 00002a06-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[7711]: src/device.c:gatt_debug() start: 0x0078, end: 0xffff, =
value: 0x0079, props: 0x12, uuid: 00002a07-0000-1
bluetoothd[7711]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[7711]: src/device.c:gatt_debug() handle: 0x007a, uuid: =
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:gatt_client_ready_cb() status: success, =
error: 10
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001813-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001812-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001803-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001802-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/device.c:update_gatt_uuids() UUID Added: =
00001804-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: profiles/gap/gas.c:gap_driver_probe() GAP profile =
probe (5C:31:3E:60:1F:1A)
bluetoothd[7711]: src/service.c:change_state() 0x1cbfe0: device =
5C:31:3E:60:1F:1A profile gap-profile state changed: unavailable -> =
disconnected (0)
bluetoothd[7711]: src/device.c:btd_device_add_attio_callback() 0x1bc6d8 =
registered ATT connection callback
bluetoothd[7711]: src/device.c:device_set_auto_connect() =
5C:31:3E:60:1F:1A auto connect: 1
bluetoothd[7711]: src/device.c:device_set_auto_connect() Already =
connected
bluetoothd[7711]: src/service.c:change_state() 0x1cc060: device =
5C:31:3E:60:1F:1A profile deviceinfo state changed: unavailable -> =
disconnected (0)
bluetoothd[7711]: profiles/scanparam/scan.c:scan_param_probe() Probing =
Scan Parameters
bluetoothd[7711]: src/device.c:btd_device_add_attio_callback() 0x1bc6d8 =
registered ATT connection callback
bluetoothd[7711]: src/device.c:device_set_auto_connect() =
5C:31:3E:60:1F:1A auto connect: 1
bluetoothd[7711]: src/service.c:change_state() 0x1cc228: device =
5C:31:3E:60:1F:1A profile Scan Parameters Client Driver state changed: =
unavailable -> disconnected (0)
bluetoothd[7711]: profiles/input/hog.c:hog_probe() path =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A
bluetoothd[7711]: src/device.c:btd_device_add_attio_callback() 0x1bc6d8 =
registered ATT connection callback
bluetoothd[7711]: src/device.c:device_set_auto_connect() =
5C:31:3E:60:1F:1A auto connect: 1
bluetoothd[7711]: src/service.c:change_state() 0x1cc300: device =
5C:31:3E:60:1F:1A profile input-hog state changed: unavailable -> =
disconnected (0)
bluetoothd[7711]: src/device.c:device_svc_resolved() =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A err 0
bluetoothd[7711]: profiles/gap/gas.c:gap_driver_accept() GAP profile =
accept (5C:31:3E:60:1F:1A)
bluetoothd[7711]: profiles/gap/gas.c:handle_characteristic() Unsupported =
characteristic: 00002a02-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: profiles/gap/gas.c:handle_characteristic() Unsupported =
characteristic: 00002a03-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: profiles/gap/gas.c:handle_characteristic() Unsupported =
characteristic: 00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[7711]: src/service.c:change_state() 0x1cbfe0: device =
5C:31:3E:60:1F:1A profile gap-profile state changed: disconnected -> =
connecting (0)
bluetoothd[7711]: src/service.c:change_state() 0x1cc060: device =
5C:31:3E:60:1F:1A profile deviceinfo state changed: disconnected -> =
connecting (0)
bluetoothd[7711]: src/service.c:change_state() 0x1cc228: device =
5C:31:3E:60:1F:1A profile Scan Parameters Client Driver state changed: =
disconnected -> connecting (0)
bluetoothd[7711]: src/service.c:change_state() 0x1cc300: device =
5C:31:3E:60:1F:1A profile input-hog state changed: disconnected -> =
connecting (0)
bluetoothd[7711]: src/gatt-client.c:btd_gatt_client_ready() GATT client =
ready
bluetoothd[7711]: src/gatt-client.c:btd_gatt_client_ready() Exporting =
services
bluetoothd[7711]: src/gatt-client.c:create_services() Exporting objects =
for GATT services: 5C:31:3E:60:1F:1A
bluetoothd[7711]: Unable to register GATT service with handle 0x000c for =
device 5C:31:3E:60:1F:1A:
bluetoothd[7711]: Unable to register GATT service with handle 0x0017 for =
device 5C:31:3E:60:1F:1A:
bluetoothd[7711]: Unable to register GATT service with handle 0x0071 for =
device 5C:31:3E:60:1F:1A:
bluetoothd[7711]: Unable to register GATT service with handle 0x0074 for =
device 5C:31:3E:60:1F:1A:
bluetoothd[7711]: Unable to register GATT service with handle 0x0077 for =
device 5C:31:3E:60:1F:1A:
bluetoothd[7711]: src/adapter.c:add_device_complete() 5C:31:3E:60:1F:1A =
(1) added to kernel connect list
bluetoothd[7711]: src/device.c:notify_attios()
bluetoothd[7711]: src/device.c:attio_connected()
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D2
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D3
bluetoothd[7711]: src/device.c:attio_connected()
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D4
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D5
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D6
bluetoothd[7711]: src/device.c:attio_connected()
bluetoothd[7711]: profiles/input/hog.c:attio_connected_cb() HoG =
connected
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D7
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D8
bluetoothd[7711]: src/device.c:notify_attios()
bluetoothd[7711]: src/device.c:notify_attios()
bluetoothd[7711]: src/device.c:gatt_debug() Registered handler for =
"Service Changed": 1
bluetoothd[7711]: profiles/gap/gas.c:read_device_name_cb() GAP Device =
Name: XiaoMi RC
bluetoothd[7711]: src/device.c:btd_device_device_set_name() =
/org/bluez/hci0/dev_5C_31_3E_60_1F_1A XiaoMi RC
bluetoothd[7711]: profiles/gap/gas.c:read_appearance_cb() GAP =
Appearance: 0x03c0
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D9
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D8
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D7
bluetoothd[7711]: profiles/scanparam/scan.c:iwin_discovered_cb() Scan =
Interval Window handle: 0x001e
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D6
bluetoothd[7711]: profiles/scanparam/scan.c:refresh_discovered_cb() Scan =
Refresh handle: 0x0020
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D7
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D6
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D5
bluetoothd[7711]: profiles/scanparam/scan.c:ccc_written_cb() Scan =
Refresh: notification enabled
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0024 UUID: =
00002a4a-0000-1000-8000-00805f9b34fb properties: 02
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0026 UUID: =
00002a4c-0000-1000-8000-00805f9b34fb properties: 04
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0028 UUID: =
00002a4e-0000-1000-8000-00805f9b34fb properties: 06
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x002a UUID: =
00002a4b-0000-1000-8000-00805f9b34fb properties: 02
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D6
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D7
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x002d UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D8
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0031 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D9
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0035 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D10
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0039 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0e
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D11
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x003c UUID: =
00002a22-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x003f UUID: =
00002a32-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0041 UUID: =
00002a33-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0044 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D12
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0047 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D13
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x004a UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D14
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x004d UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D15
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0050 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D16
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0053 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D17
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0056 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D18
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0059 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D19
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x005c UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D20
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x005f UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D21
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0062 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D22
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0065 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D23
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x0068 UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D24
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x006b UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D25
bluetoothd[7711]: profiles/input/hog.c:char_discovered_cb() 0x006e UUID: =
00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D26
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D28
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D27
bluetoothd[7711]: profiles/input/hog.c:proto_mode_read_cb() HoG device =
0x0022 is operating in Report Protocol Mode
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D26
bluetoothd[7711]: profiles/input/hog.c:info_read_cb() bcdHID: 0x0111 =
bCountryCode: 0x00 Flags: 0x01
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D25
bluetoothd[7711]: profiles/input/hog.c:external_report_reference_cb() =
External report reference read, external report characteristic UUID: =
0x2a19
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D26
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D25
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0x01 Report type: 0x01
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D24
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0x02 Report type: 0x01
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D23
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0x03 Report type: 0x01
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D22
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0x00 Report type: 0x02
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D21
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe0 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D20
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe1 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D19
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe2 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D18
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe3 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D17
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe4 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D16
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe5 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D15
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe6 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D14
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe7 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D13
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe8 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D12
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xe9 Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D11
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xea Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D10
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xeb Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D9
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xec Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D8
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xed Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D7
bluetoothd[7711]: profiles/input/hog.c:report_reference_cb() Report ID: =
0xee Report type: 0x03
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D6
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() Report MAP:
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 05 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 09 06
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 a1 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 85 02
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 05 07
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 19 e0
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 29 e7
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 15 00
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 25 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 75 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 95 08
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 81 02
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 81 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 95 05
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 75 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 05 08
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 19 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 29 05
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 91 02
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 75 03
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 91 01
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 95 06
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 15 00
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 25 fe
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 05 07
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 19 00
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 29 fe
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 81 00
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() 	 c0
bluetoothd[7711]: profiles/input/hog.c:report_map_read_cb() DIS =
information: vendor_src=3D0x1, vendor=3D0x2717, product=3D0x3200, =
version=3D0x110
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D5
bluetoothd[7711]: profiles/input/hog.c:report_ccc_written_cb() Report =
0x002d CCC written: notifications enabled
bluetoothd[7711]: profiles/input/hog.c:report_ccc_written_cb() Report =
0x0031 CCC written: notifications enabled
bluetoothd[7711]: Report 0x0035 CCC write failed: Attribute can't be =
written
bluetoothd[7711]: profiles/input/hog.c:external_service_char_cb() 0x0018 =
UUID: 00002a19-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D6
bluetoothd[7711]: attrib/gattrib.c:g_attrib_unref() 0x1c60f0: =
g_attrib_unref=3D5
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c60f0: =
g_attrib_ref=3D6
bluetoothd[7711]: attrib/gattrib.c:g_attrib_ref() 0x1c9210: =
g_attrib_ref=3D808464433
Segmentation fault
------=_NextPart_000_0051_01D124FE.DAD96B30--

