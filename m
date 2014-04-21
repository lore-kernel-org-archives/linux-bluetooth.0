Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Gabe Rosenhouse <gabe@missionst.com>
Date: Mon, 21 Apr 2014 11:30:20 -0700
Message-ID: <CAFPczvv4vumXsOtwqjhYNfQCf_b=6UKdxbit9qKY2JB6ssX1dQ@mail.gmail.com>
Subject: GATT service works on Raspberry Pi with bluetoothd v5.16 but not with
 5.17 or 5.18
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to develop an application that will run on a Raspberry Pi
and expose a GATT service via a USB Bluetooth 4.0 device.   I've found
that when the Ras Pi is running bluetoothd v. 5.16, I'm able to
connect to it from a separate device and probe for GATT services.  But
when running 5.17 or 5.18, the connection fails.


Test conditions:

I'm running Raspbian, on a Raspberry Pi Model B, revision 2.  The
Linux version at the top of dmesg is:
   Linux version 3.10.25+ (dc4@dc4-arm-01) (gcc version 4.7.2 20120731
(prerelease) (crosstool-NG linaro-1.13.1+bzr2458 - Linaro GCC 2012.08)
) #622 PREEMPT Fri Jan 3 18:41:00 GMT 2014

dmesg | grep Blue shows:

[    5.566339] Bluetooth: Core ver 2.16
[    5.961130] Bluetooth: HCI device and connection manager initialized
[    6.148806] Bluetooth: HCI socket layer initialized
[    6.328700] Bluetooth: L2CAP socket layer initialized
[    6.501270] Bluetooth: SCO socket layer initialized
[    8.779403] Bluetooth: hci0 command 0x0c16 tx timeout
[ 3886.221570] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 3886.221606] Bluetooth: BNEP filters: protocol multicast
[ 3886.221662] Bluetooth: BNEP socket layer initialized

and lsusb shows the hardware device:
   Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)


Methods:

For all tests, on the Ras Pi, I cd into the bluez-5.1X directory and then run:
  ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc
--localstatedir=/var --disable-systemd
  make && sudo make install
  sudo /usr/libexec/bluetooth/bluetoothd -n -d

In a separate terminal on the Ras Pi, I then ran
   sudo hciconfig hci0 up && sudo hciconfig hci0 leadv 0

Finally, on a separate device with BlueZ 5.18 compiled, I run:
  sudo /usr/libexec/bluetooth/bluetoothd
  sudo hciconfig hci0 up && sudo hciconfig hci0 noleadv
  attrib/gatttool -b $RASPI_HWADDR --primary



Version-specific outputs:


BlueZ 5.17:

When running BlueZ 5.17 on the Ras Pi, that gatttool command errors with:
  Discover all primary services failed: Internal application error: I/O

And the tail of bluetoothd looks like:

bluetoothd[22210]: src/adapter.c:load_link_keys_complete() link keys
loaded for hci0
bluetoothd[22210]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[22210]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[22210]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[22210]: src/adapter.c:adapter_start() adapter
/org/bluez/hci0 has been enabled
bluetoothd[22210]: src/adapter.c:trigger_passive_scanning()
bluetoothd[22210]: src/adapter.c:connected_callback() hci0 device
00:02:72:C5:E2:1B connected eir_len 0
bluetoothd[22210]: src/device.c:device_create() dst 00:02:72:C5:E2:1B
bluetoothd[22210]: src/device.c:device_new() address 00:02:72:C5:E2:1B
bluetoothd[22210]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22210]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[22210]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B is not on the list, ignoring
bluetoothd[22210]: src/attrib-server.c:connect_event()
bluetoothd[22210]: src/device.c:device_create() dst 00:02:72:C5:E2:1B
bluetoothd[22210]: src/device.c:device_new() address 00:02:72:C5:E2:1B
bluetoothd[22210]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22210]: Unable to register device interface for 00:02:72:C5:E2:1B
bluetoothd[22210]: src/device.c:device_free() 0xa1b770
bluetoothd[22210]: src/adapter.c:dev_disconnected() Device
00:02:72:C5:E2:1B disconnected, reason 2
bluetoothd[22210]: src/adapter.c:adapter_remove_connection()
bluetoothd[22210]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22210]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22210]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22210]: src/device.c:device_free() 0xa1fe80
bluetoothd[22210]: src/adapter.c:bonding_attempt_complete() hci0
bdaddr 00:02:72:C5:E2:1B type 1 status 0xe
bluetoothd[22210]: src/adapter.c:resume_discovery()

Note that it tries to create the device twice - the first time
successfully, but the second time it fails.


BlueZ 5.16:

On the other hand, when the Ras Pi is running bluetoothd 5.16, then
the gatttool on the separate device runs ok.  Output:
  attr handle = 0x0001, end grp handle = 0x0008 uuid:
00001800-0000-1000-8000-00805f9b34fb
  attr handle = 0x0010, end grp handle = 0x0010 uuid:
00001801-0000-1000-8000-00805f9b34fb

And ouptut from the bottom of bluetoothd 5.16 on Ras Pi ends with:

bluetoothd[22445]: src/adapter.c:load_link_keys_complete() link keys
loaded for hci0
bluetoothd[22445]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[22445]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.16
bluetoothd[22445]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[22445]: src/adapter.c:local_name_changed_callback() Current
alias: BlueZ 5.16
bluetoothd[22445]: src/attrib-server.c:attrib_db_update() handle=0x0006
bluetoothd[22445]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[22445]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[22445]: src/adapter.c:adapter_start() adapter
/org/bluez/hci0 has been enabled
bluetoothd[22445]: src/adapter.c:trigger_passive_scanning()
bluetoothd[22445]: src/adapter.c:connected_callback() hci0 device
00:02:72:C5:E2:1B connected eir_len 0
bluetoothd[22445]: src/device.c:device_create() dst 00:02:72:C5:E2:1B
bluetoothd[22445]: src/device.c:device_new() address 00:02:72:C5:E2:1B
bluetoothd[22445]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22445]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[22445]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B is not on the list, ignoring
bluetoothd[22445]: src/attrib-server.c:connect_event()
bluetoothd[22445]: attrib/gattrib.c:g_attrib_ref() 0x296038: ref=1
bluetoothd[22445]: attrib/gattrib.c:g_attrib_ref() 0x296038: ref=2
bluetoothd[22445]: attrib/gattrib.c:g_attrib_unref() 0x296038: ref=1
bluetoothd[22445]: src/attrib-server.c:channel_handler() op 0x10
bluetoothd[22445]: attrib/gattrib.c:g_attrib_ref() 0x296038: ref=2
bluetoothd[22445]: attrib/gattrib.c:g_attrib_unref() 0x296038: ref=1
bluetoothd[22445]: src/attrib-server.c:channel_handler() op 0x10
bluetoothd[22445]: attrib/gattrib.c:g_attrib_ref() 0x296038: ref=2
bluetoothd[22445]: attrib/gattrib.c:g_attrib_unref() 0x296038: ref=1
bluetoothd[22445]: src/adapter.c:dev_disconnected() Device
00:02:72:C5:E2:1B disconnected, reason 3
bluetoothd[22445]: src/adapter.c:adapter_remove_connection()
bluetoothd[22445]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22445]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22445]: src/adapter.c:bonding_attempt_complete() hci0
bdaddr 00:02:72:C5:E2:1B type 1 status 0xe
bluetoothd[22445]: src/adapter.c:resume_discovery()
bluetoothd[22445]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_00_02_72_C5_E2_1B
bluetoothd[22445]: src/device.c:device_free() 0x295e80
bluetoothd[22445]: attrib/gattrib.c:g_attrib_unref() 0x296038: ref=0


I'm quite new to reporting issues in a forum like this.  Please let me
know what additional information I can provide.

Thanks for your time.

Gabe Rosenhouse
