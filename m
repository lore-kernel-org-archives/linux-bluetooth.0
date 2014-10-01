Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Gal <a.gal@miip.ca>
Date: Wed, 1 Oct 2014 12:02:10 -0400
Message-ID: <CAEa95a=_KJNtZa_BDwMJqd7T_R8DBfdThKNygg-HVKNWcNTFqQ@mail.gmail.com>
Subject: sixaxis & sony/snakebyte ps3 navigation move controller issues
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am using the latest bluez (from git).

## Problem 1: Sony Move Navigation Controller not recognized

This was easily fixed by adding a new device in the devices contained
in plugins/sixaxis.c.
I will post a patch later today.

## Problem 2: Sony Move Navigation Controller connection procedure issues

After plugging-in the controller to the usb cable for the master
reset, a device is created (with no services).

in bluetoothctl:
power on
agent on
default-agent
trust 00:07:04:B9:CC:64

Pressing the sony button on the controller (00:07:04:B9:CC:64 ), the
controller tries to connect to the master a couple of times, but fails
every time this is error:

bluetoothd[2740]: src/adapter.c:connected_callback() hci0 device
00:07:04:B9:CC:64 connected eir_len 5
bluetoothd[2740]: src/device.c:device_set_class()
/org/bluez/hci0/dev_00_07_04_B9_CC_64 0x000508
bluetoothd[2740]: profiles/input/server.c:connect_event_cb() Incoming
connection from 00:07:04:B9:CC:64 on PSM 17
bluetoothd[2740]: profiles/input/device.c:input_device_set_channel()
idev (nil) psm 17
bluetoothd[2740]: Refusing input device connect: No such file or directory (2)
bluetoothd[2740]: profiles/input/server.c:confirm_event_cb()
bluetoothd[2740]: Refusing connection from 00:07:04:B9:CC:64: unknown device
bluetoothd[2740]: src/adapter.c:dev_disconnected() Device
00:07:04:B9:CC:64 disconnected, reason 3
bluetoothd[2740]: src/adapter.c:adapter_remove_connection()
bluetoothd[2740]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[2740]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
00:07:04:B9:CC:64 type 0 status 0xe
bluetoothd[2740]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[2740]: src/device.c:device_bonding_failed() status 14
bluetoothd[2740]: src/adapter.c:resume_discovery()

[bluetooth]# info 00:07:04:B9:CC:64
Device 00:07:04:B9:CC:64
        Name: PLAYSTATION(R)3 Controller
        Alias: PLAYSTATION(R)3 Controller
        Class: 0x000508
        Icon: input-gaming
        Paired: no
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        Modalias: usb:v054Cp042Fd0000

Since there are no services associated with the device, I assume bluez
does not know what do to with it.

However, if I try to connect to it while the controller is connecting,
at some point it will retrieve the services and, eventually, connect
(and create the appropriate /dev/input/jsX).

[bluetooth]# connect 00:07:04:B9:CC:64
Attempting to connect to 00:07:04:B9:CC:64
[CHG] Device 00:07:04:B9:CC:64 Modalias: usb:v054Cp0268d0100
[CHG] Device 00:07:04:B9:CC:64 UUIDs:
        00001124-0000-1000-8000-00805f9b34fb
        00001200-0000-1000-8000-00805f9b34fb

Would it be possible to "hardcode" these services for this device or
would that be a nasty hack ?


## Problem 3: SnakeByte PS3 clone Navigation Move master reset

The sixaxis plugin recognizes the controller and resets the master,
however the device address is buggy:

bluetoothd[1762]: plugins/sixaxis.c:get_supported_device() pid is: 268
bluetoothd[1762]: sixaxis: compatible device connected:
PLAYSTATION(R)3 Controller (054C:0268)
bluetoothd[1762]: plugins/sixaxis.c:setup_device() remote
00:32:00:45:00:A1 old_master 20:36:00:32:00:45 new_master
00:02:72:C8:CF:71
bluetoothd[1762]: src/device.c:device_create() dst 00:32:00:45:00:A1
bluetoothd[1762]: src/device.c:device_new() address 00:32:00:45:00:A1
bluetoothd[1762]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_00_32_00_45_00_A1
bluetoothd[1762]: sixaxis: setting up new device
bluetoothd[1762]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_00_32_00_45_00_A1 PLAYSTATION(R)3 Controller
bluetoothd[1762]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1762]: plugins/sixaxis.c:get_leds_data() number 1

I will get this even if I replug the usb cable again; the old_master
never changes.

## Problem 4: SnakeByte PS3 clone Navigation Move pairing failure

If I repeat the same procedure that worked with the realy Sony
controller but it won't work at all; there are no services associated
with that device at all.

Any ideas would be welcome.

Thank you,

Alex
