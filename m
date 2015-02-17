Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2015 14:16:37 -0700
Message-ID: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com>
Subject: android-bluez with usb adapter
From: Keith Conger <keith.conger@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to swap out bluedroid with android-bluez to add bluetooth
usb adapter support into KitKat for my Beaglebone Black(ARM). Should
this be possible?

I followed this guide,
http://forum.xda-developers.com/showthread.php?t=2640723 skipping the
CSR parts.

Here is a logcat with debugging enabled.  I've googled the errors and
have had no luck.  Does anyone have any ideas?

I/bluetoothd( 1072): Bluetooth daemon 5.28

D/bluetoothd( 1072):
external/bluetooth/bluez/android/main.c:set_capabilities() Caps: eff:
0x3400, perm: 0x3400, inh: 0x0

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:bt_bluetooth_start()
index -1

I/bluetoothd( 1072): Starting SDP server

D/bluetoothd( 1072): external/bluetooth/bluez/android/main.c:main()
Entering main loop

I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0001

I/bluetoothd( 1072): mgmt_if: < 01 00 ff ff 00 00
          ..??..

I/bluetoothd( 1072): mgmt_if: > 01 00 ff ff 06 00 01 00 00 01 07 00
          ..??........

I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0001 complete: 0x00

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:read_version_complete()

I/bluetoothd( 1072): Bluetooth management interface 1.7 initialized

I/bluetoothd( 1072): Kernel connection control will be used

I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0003

I/bluetoothd( 1072): mgmt_if: < 03 00 ff ff 00 00
          ..??..

I/bluetoothd( 1072): mgmt_if: > 01 00 ff ff 07 00 03 00 00 01 00 00 00
          ..??.........

I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0003 complete: 0x00

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:read_index_list_complete()

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:read_index_list_complete()
Number of controllers: 1

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0004

I/bluetoothd( 1072): mgmt_if: < 04 00 00 00 00 00
          ......

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 1b 01 04 00 00 e9 36 36 e7
18 00 03  .........?66?...

I/bluetoothd( 1072): mgmt_if:   0f 00 bf 10 00 00 90 00 00 00 00 00 00
42 43 4d  ..?..........BCM

I/bluetoothd( 1072): mgmt_if:   32 30 34 35 42 33 00 00 00 00 00 00 00
00 00 00  2045B3..........

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00
          .

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0004 complete: 0x00

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:read_info_complete()

D/bluetoothd( 1072):
external/bluetooth/bluez/src/sdpd-service.c:register_device_id()
Adding device id record for 0002:1d6b:0247:051c

D/bluetoothd( 1072):
external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
Adding record with handle 0x10001

D/bluetoothd( 1072):
external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
Record pattern UUID 00001002-0000-1000-8000-00805f9

D/bluetoothd( 1072):
external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
Record pattern UUID 0000113a-0000-1000-8000-00805f9

D/bluetoothd( 1072):
external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
Record pattern UUID 0000113b-0000-1000-8000-00805f9

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:load_ltks() ltks 0

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:load_irks() irks 0

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:load_link_keys() keys 0

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x000e

I/bluetoothd( 1072): mgmt_if: < 0e 00 00 00 02 00 02 0c
          ........

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 0e 00 00 00 00 00
          ............

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x000e complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0011

I/bluetoothd( 1072): mgmt_if: < 11 00 00 00 10 00 00 00 00 00 00 00 00
00 00 00  ................

I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00
          ......

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 11 00 00 00 00 00
          ............

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0011 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0034

I/bluetoothd( 1072): mgmt_if: < 34 00 00 00 07 00 00 00 00 00 00 00 00
          4............

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 0a 00 34 00 00 00 00 00 00
00 00 00  ......4.........

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0034 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0018

I/bluetoothd( 1072): mgmt_if: < 18 00 00 00 01 00 01
          .......

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 18 00 00
          .........

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0018 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0028

I/bluetoothd( 1072): mgmt_if: < 28 00 00 00 08 00 02 00 6b 1d 47 02 1c
05        (.......k.G...

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 28 00 00
          ......(..

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0028 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010

I/bluetoothd( 1072): mgmt_if: < 10 00 00 00 11 00 fb 34 9b 5f 80 00 00
80 00 10  ......?4._......

I/bluetoothd( 1072): mgmt_if:   00 00 00 12 00 00 00
          .......

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 10 00 00 00 00 00
          ............

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010

I/bluetoothd( 1072): mgmt_if: < 10 00 00 00 11 00 fb 34 9b 5f 80 00 00
80 00 10  ......?4._......

I/bluetoothd( 1072): mgmt_if:   00 00 3b 11 00 00 00
          ..;....

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 10 00 00 00 00 00
          ............

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010 complete: 0x00

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0013

I/bluetoothd( 1072): mgmt_if: < 13 00 00 00 02 00 00 00
          ........

I/bluetoothd( 1072): mgmt_if: > 02 00 00 00 03 00 13 00 0c
          .........

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x13 status: 0x0c

I/bluetoothd( 1072): Failed to load LTKs: Not Supported (0x0c)

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0030

I/bluetoothd( 1072): mgmt_if: < 30 00 00 00 02 00 00 00
          0.......

I/bluetoothd( 1072): mgmt_if: > 02 00 00 00 03 00 30 00 0c
          ......0..

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x30 status: 0x0c

I/bluetoothd( 1072): Failed to load IRKs: Not Supported (0x0c)

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0012

I/bluetoothd( 1072): mgmt_if: < 12 00 00 00 03 00 00 00 00
          .........

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 12 00 00
          .........

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0012 complete: 0x00

D/bluetoothd( 1072):
external/bluetooth/bluez/android/bluetooth.c:load_link_keys_complete()
status 0

I/bluetoothd( 1072): Adapter initialized

D/bluetoothd( 1072): external/bluetooth/bluez/android/ipc.c:cmd_connect_cb()

E/bluetoothd( 1072): IPC: command socket connect failed

I/bluetoothd( 1072): Switching controller off

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0005

I/bluetoothd( 1072): mgmt_if: < 05 00 00 00 01 00 00
          .......

I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 07 00 05 00 00 90 00 00 00
          .............

I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0005 complete: 0x00

D/bluetoothd( 1072): external/bluetooth/bluez/android/main.c:cleanup_services()

I/bluetoothd( 1072): Stopping SDP server

I/bluetoothd( 1072): Exit
