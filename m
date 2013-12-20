Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2013 16:43:17 +0100
Message-ID: <CAPk--xzV9n5-RnAhPhbM2hCnftvJxeCm9E0Wgkj+zzdqNqseVQ@mail.gmail.com>
Subject: Unable to use Sony Dualshock 4 game controller
From: Christopher Rosell <chrippa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there,

I'm attempting to use a Sony Dualshock 4 game controller with bluez,
but have run into some problems. I'm running Linux kernel 3.12.4 on
Arch Linux with bluez 5.12.

The DS4 is a standard bluetooth device, unlike the DS3 and I was able
to pair and use it without any problems in Windows 7, but in Linux I
have not been able to get it working correctly. The controller can be
started in two modes, a pairing mode by pressing the buttons Share and
PS at the same time and a normal mode by pressing the PS button only.

The pairing appears to work correctly but once it connects I get these
errors and then the connection is dropped:

Dec 20 16:08:01 locutus bluetoothd[17163]: Refusing input device
connect: No such file or directory (2)
Dec 20 16:08:01 locutus bluetoothd[17163]: Refusing connection from
A4:15:66:73:03:F3: unknown device
Dec 20 16:08:01 locutus bluetoothd[17163]: A4:15:66:73:03:F3: error
updating services: Input/output error (5)


I used bluetoothctl to do the pairing, here is the log:

[root@locutus chrippa]# bluetoothctl -a
[NEW] Controller 00:26:83:30:B7:CB locutus [default]
Agent registered
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:26:83:30:B7:CB Discovering: yes
[NEW] Device 00:3C:7F:F0:F0:0A 00-3C-7F-F0-F0-0A
[NEW] Device A4:15:66:73:03:F3 Wireless Controller
[bluetooth]# pair A4:15:66:73:03:F3
Attempting to pair with A4:15:66:73:03:F3
[CHG] Device A4:15:66:73:03:F3 Connected: yes
[CHG] Device A4:15:66:73:03:F3 Paired: yes
Pairing successful
[CHG] Device A4:15:66:73:03:F3 Connected: no


Later, when attempting to start the controller in normal mode, I get
the first two errors only:

Dec 20 16:19:00 locutus bluetoothd[17163]: Refusing input device
connect: No such file or directory (2)
Dec 20 16:19:00 locutus bluetoothd[17163]: Refusing connection from
A4:15:66:73:03:F3: unknown device



Here is also the full debug log:


Dec 20 16:31:36 locutus bluetoothd[24893]: src/agent.c:agent_ref()
0x1d987a0: ref=1
Dec 20 16:31:36 locutus bluetoothd[24893]:
src/agent.c:register_agent() agent :1.33
Dec 20 16:31:39 locutus bluetoothd[24893]:
src/adapter.c:property_set_mode() sending Set Powered command for
index 0
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/adapter.c:dev_class_changed_callback() Class: 0x0c0104
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/attrib-server.c:attrib_db_update() handle=0x0008
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/adapter.c:property_set_mode_complete() Success (0x00)
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/adapter.c:new_settings_callback() Settings: 0x000000d3
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/adapter.c:settings_changed() Changed settings: 0x00000001
Dec 20 16:31:40 locutus bluetoothd[24893]:
src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
Dec 20 16:31:53 locutus bluetoothd[24893]:
src/adapter.c:start_discovery() sender :1.33
Dec 20 16:31:53 locutus bluetoothd[24893]:
src/adapter.c:trigger_start_discovery()
Dec 20 16:31:53 locutus bluetoothd[24893]:
src/adapter.c:start_discovery_timeout()
Dec 20 16:31:53 locutus bluetoothd[24893]:
src/adapter.c:start_discovery_complete() status 0x00
Dec 20 16:31:53 locutus bluetoothd[24893]:
src/adapter.c:discovering_callback() hci0 type 1 discovering 1
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/adapter.c:device_found_callback() hci0 addr A4:15:66:73:03:F3,
rssi -75 flags 0x0000 eir_len 42
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/device.c:device_create() dst A4:15:66:73:03:F3
Dec 20 16:31:59 locutus bluetoothd[24893]: src/device.c:device_new()
address A4:15:66:73:03:F3
Dec 20 16:31:59 locutus bluetoothd[24893]: src/device.c:device_new()
Creating device /org/bluez/hci0/dev_A4_15_66_73_03_F3
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/device.c:btd_device_set_temporary() temporary 1
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_A4_15_66_73_03_F3 is not on the list, ignoring
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/device.c:device_set_legacy() legacy 0
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/device.c:device_set_rssi() rssi -75
Dec 20 16:31:59 locutus bluetoothd[24893]:
src/device.c:device_set_class() /org/bluez/hci0/dev_A4_15_66_73_03_F3
0x002508
Dec 20 16:32:03 locutus bluetoothd[24893]:
src/adapter.c:device_found_callback() hci0 addr A4:15:66:73:03:F3,
rssi -73 flags 0x0000 eir_len 42
Dec 20 16:32:03 locutus bluetoothd[24893]:
src/device.c:device_set_legacy() legacy 0
Dec 20 16:32:03 locutus bluetoothd[24893]:
src/adapter.c:discovering_callback() hci0 type 1 discovering 0
Dec 20 16:32:03 locutus bluetoothd[24893]:
src/adapter.c:trigger_start_discovery()
Dec 20 16:32:07 locutus bluetoothd[24893]:
src/device.c:btd_device_set_temporary() temporary 0
Dec 20 16:32:07 locutus bluetoothd[24893]: src/agent.c:agent_ref()
0x1d987a0: ref=2
Dec 20 16:32:07 locutus bluetoothd[24893]:
src/device.c:bonding_request_new() Requesting bonding for
A4:15:66:73:03:F3
Dec 20 16:32:07 locutus bluetoothd[24893]: src/agent.c:agent_ref()
0x1d987a0: ref=3
Dec 20 16:32:07 locutus bluetoothd[24893]: src/agent.c:agent_unref()
0x1d987a0: ref=2
Dec 20 16:32:07 locutus bluetoothd[24893]: src/adapter.c:suspend_discovery()
Dec 20 16:32:07 locutus bluetoothd[24893]:
src/adapter.c:adapter_bonding_attempt() hci0 bdaddr A4:15:66:73:03:F3
type 0 io_cap 0x01
Dec 20 16:32:07 locutus bluetoothd[24893]:
src/adapter.c:connected_callback() hci0 device A4:15:66:73:03:F3
connected eir_len 26
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/adapter.c:new_link_key_callback() hci0 new key for
A4:15:66:73:03:F3 type 5 pin_len 0
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/device.c:device_set_bonded() bonded 1
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/device.c:device_bonding_complete() bonding 0x1da0760 status 0x00
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/device.c:device_bonding_complete() Proceeding with service
discovery
Dec 20 16:32:10 locutus bluetoothd[24893]: src/agent.c:agent_unref()
0x1d987a0: ref=1
Dec 20 16:32:10 locutus bluetoothd[24893]: src/adapter.c:resume_discovery()
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/adapter.c:trigger_start_discovery()
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/adapter.c:pair_device_complete() Success (0x00)
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr A4:15:66:73:03:F3
type 0 status 0x0
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/device.c:device_bonding_complete() bonding (nil) status 0x00
Dec 20 16:32:10 locutus bluetoothd[24893]: src/adapter.c:resume_discovery()
Dec 20 16:32:10 locutus bluetoothd[24893]:
src/adapter.c:trigger_start_discovery()
Dec 20 16:32:13 locutus bluetoothd[24893]:
profiles/input/server.c:connect_event_cb() Incoming connection from
A4:15:66:73:03:F3 on PSM 17
Dec 20 16:32:13 locutus bluetoothd[24893]:
profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
Dec 20 16:32:13 locutus bluetoothd[24893]: Refusing input device
connect: No such file or directory (2)
Dec 20 16:32:13 locutus bluetoothd[24893]:
profiles/input/server.c:confirm_event_cb()
Dec 20 16:32:13 locutus bluetoothd[24893]: Refusing connection from
A4:15:66:73:03:F3: unknown device
Dec 20 16:32:13 locutus bluetoothd[24893]: A4:15:66:73:03:F3: error
updating services: Input/output error (5)
Dec 20 16:32:13 locutus bluetoothd[24893]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_A4_15_66_73_03_F3 err -5
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/adapter.c:dev_disconnected() Device A4:15:66:73:03:F3
disconnected, reason 3
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/adapter.c:adapter_remove_connection()
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr A4:15:66:73:03:F3
type 0 status 0xe
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/device.c:device_bonding_failed() status 14
Dec 20 16:32:14 locutus bluetoothd[24893]: src/adapter.c:resume_discovery()
Dec 20 16:32:14 locutus bluetoothd[24893]:
src/adapter.c:trigger_start_discovery()


--
Christopher Rosell
