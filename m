Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 4 Sep 2013 13:55:13 +0200
Message-ID: <CANq1E4ThsLwpWKs2VR+2DT41cDfV+_XX+DdLDF7Yo+Sm+t1ryw@mail.gmail.com>
Subject: [BUG bluetoothd] reconnecting input devices results in org.bluez.Error.NotAvailable
From: David Herrmann <dh.herrmann@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I run the following commands in bluetoothctl on bluez-5.7-1 (but I
know this bug since I started using bluetoothctl (probably 5.0 or
5.1), just didn't get around reporting it, yet. Sorry.):
  [bluetooth]# power on
    [CHG] Controller 00:25:00:50:C4:C9 Class: 0x00010c
    Changing power on succeeded
    [CHG] Controller 00:25:00:50:C4:C9 Powered: yes
  [bluetooth]# connect 00:1E:35:3B:7E:6D
    Attempting to connect to 00:1E:35:3B:7E:6D
    Connection successful
    [CHG] Device 00:1E:35:3B:7E:6D Connected: yes

Works just fine. Then I disconnect the device by removing its
batteries. bluez notices this and removes the connection:
    [CHG] Device 00:1E:35:3B:7E:6D Connected: no

However, a following connect always fails immediately:
  [bluetooth]# connect 00:1E:35:3B:7E:6D
    Attempting to connect to 00:1E:35:3B:7E:6D
    Failed to connect: org.bluez.Error.NotAvailable

Any following commands, whether "connect" or "info" on the given
device result in:
  [bluetooth]# info  00:1E:35:3B:7E:6D
    Device  00:1E:35:3B:7E:6D not available

power off -> power on doesn't help. I need to restart bluetoothd to
make it work again. The related debug log is appended below. Any hints
where to start debugging is welcome.

I tested this with two HIDP devices.

Thanks
David

log starts with "power on" in bluetoothctl:

Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:property_set_mode() sending Set Powered command for
index 0
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:dev_class_changed_callback() Class: 0x00010c
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/attrib-server.c:attrib_db_update() handle=0x0008
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:property_set_mode_complete() Success (0x00)
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:new_settings_callback() Settings: 0x000000d3
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:settings_changed() Changed settings: 0x00000001
Sep 04 13:39:03 david-mb bluetoothd[16799]:
src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1E_35_3B_7E_6D
(all), client :1.13
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/service.c:change_state() 0x93fde0: device 00:1E:35:3B:7E:6D
profile input-hid state changed: disconnected -> connecting (0)
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/adapter.c:connected_callback() hci0 device 00:1E:35:3B:7E:6D
connected eir_len 21
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/service.c:change_state() 0x93fde0: device 00:1E:35:3B:7E:6D
profile input-hid state changed: connecting -> connected (0)
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/device.c:device_profile_connected() input-hid Success (0)
Sep 04 13:39:21 david-mb bluetoothd[16799]:
src/device.c:device_profile_connected() returning response to :1.13

[...kernel HID messages for the device...]

Sep 04 13:39:48 david-mb bluetoothd[16799]:
profiles/input/device.c:ctrl_watch_cb() Device 00:1E:35:3B:7E:6D
disconnected
Sep 04 13:39:48 david-mb bluetoothd[16799]:
profiles/input/device.c:intr_watch_cb() Device 00:1E:35:3B:7E:6D
disconnected
Sep 04 13:39:48 david-mb bluetoothd[16799]:
profiles/input/device.c:input_device_enter_reconnect_mode()
path=/org/bluez/hci0/dev_00_1E_35_3B_7E_6D reconnect_mode=device
Sep 04 13:39:48 david-mb bluetoothd[16799]:
src/adapter.c:dev_disconnected() Device 00:1E:35:3B:7E:6D
disconnected, reason 2
Sep 04 13:39:48 david-mb bluetoothd[16799]:
src/adapter.c:adapter_remove_connection()
Sep 04 13:39:48 david-mb bluetoothd[16799]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1E:35:3B:7E:6D
type 0 status 0xe
Sep 04 13:39:48 david-mb bluetoothd[16799]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Sep 04 13:39:48 david-mb bluetoothd[16799]:
src/device.c:device_bonding_failed() status 14
Sep 04 13:39:48 david-mb bluetoothd[16799]: src/adapter.c:resume_discovery()

[any further commands like "connect" result in:]

Sep 04 13:42:06 david-mb bluetoothd[16799]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1E_35_3B_7E_6D
(all), client :1.13
