Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Ben Davis <bendavis78@gmail.com>
Date: Sun, 20 Jul 2014 18:13:15 -0500
Message-ID: <CAHGZte6L-phK3NjbKX2gXzguA4SVRDB3XNcBfriKsSby1Vvo4A@mail.gmail.com>
Subject: Refusing input device connect: No such file or directory (2)
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I cannot connect my bluetooth keyboard. I'm using bluez 5.21-2 on
archlinux. I'm using bluetoothctl, and am running "bluetoothd -nd" to
view debug output. When I press the pair button on my keyboard, the
device shows up and is then immediately removed. This is what it shows
in bluetoothctl:

[NEW] Device 28:37:37:2A:BC:7A Apple Wireless Keyboard
[CHG] Device 28:37:37:2A:BC:7A Connected: no
[DEL] Device 28:37:37:2A:BC:7A Apple Wireless Keyboard


And this is the output from bluetoothd during the event:

bluetoothd[8708]: src/adapter.c:connected_callback() hci0 device
28:37:37:2A:BC:7A connected eir_len 5
bluetoothd[8708]: src/device.c:device_create() dst 28:37:37:2A:BC:7A
bluetoothd[8708]: src/device.c:device_new() address 28:37:37:2A:BC:7A
bluetoothd[8708]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_28_37_37_2A_BC_7A
bluetoothd[8708]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[8708]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_28_37_37_2A_BC_7A is not on the list, ignoring
bluetoothd[8708]: src/device.c:device_set_class()
/org/bluez/hci0/dev_28_37_37_2A_BC_7A 0x002540
bluetoothd[8708]: profiles/input/server.c:connect_event_cb() Incoming
connection from 28:37:37:2A:BC:7A on PSM 17
bluetoothd[8708]: profiles/input/device.c:input_device_set_channel()
idev (nil) psm 17
bluetoothd[8708]: Refusing input device connect: No such file or directory (2)
bluetoothd[8708]: profiles/input/server.c:confirm_event_cb()
bluetoothd[8708]: Refusing connection from 28:37:37:2A:BC:7A: unknown device
bluetoothd[8708]: src/adapter.c:dev_disconnected() Device
28:37:37:2A:BC:7A disconnected, reason 3
bluetoothd[8708]: src/adapter.c:adapter_remove_connection()
bluetoothd[8708]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/hci0/dev_28_37_37_2A_BC_7A
bluetoothd[8708]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_28_37_37_2A_BC_7A
bluetoothd[8708]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_28_37_37_2A_BC_7A
bluetoothd[8708]: src/device.c:device_free() 0xedcae0
bluetoothd[8708]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[8708]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
28:37:37:2A:BC:7A type 0 status 0xe
bluetoothd[8708]: src/adapter.c:resume_discovery()


I'm assuming the problem has something to do with the "Refusing input
device connect: No such file or directory (2)".  What exactly is it
trying to access that doesn't exist?
