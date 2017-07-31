Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Yunhan Wang <yunhanw@google.com>
Date: Mon, 31 Jul 2017 00:22:10 -0700
Message-ID: <CALvjcs8Ac-dEdGx9P6udrmcetby0hoyn_bgH_CwkzRoD6SctNQ@mail.gmail.com>
Subject: Gatt Dbus example and bluetoothctl question when using virtual emulator
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am doing some experiments to understand Bluez DBUS API using Bluez
5.46, and feel a little bit confused about Gatt Dbus example code and
bluetoothctl.

First, I do sudo bluetoothd --experimental -d, then I create two
virtual bt interfaces and bring up example-gatt-server, then
example-gatt-client cannot find any new gatt service. Any idea?

Also, I have checked all information under org.bluez using d-feet, the
gatt service and characteristics from example-gatt-client have not yet
been added. I print all infos under ObjectManager for bluez, and
cannot find these services and characteristics.

I also try to use register-service, and register-characteristic for
hci0 using bluetoothctl,  but I cannot find any added service and
characteristics under d-feet and ObjectManager. Any idea?


bluez-5.46$ sudo ./emulator/btvirt -L -l2
Bluetooth emulator ver 5.46


bluez-5.46/test$ sudo ./example-gatt-server
Registering GATT application...
GetManagedObjects
GATT application registered
Battery Level drained: 98
Battery Level drained: 96
Battery Level drained: 94
Battery Level drained: 92
Battery Level drained: 90
Battery Level drained: 88
Battery Level drained: 86
Battery Level drained: 84

sudo ./example-gatt-client
Getting objects...
No Heart Rate Service found


sudo ./client/bluetoothctl
[NEW] Controller 00:AA:01:00:00:23 hostname [default]
[NEW] Device 00:AA:01:01:00:24 hostname #2
Agent registered
[bluetooth]# power on
Changing power on succeeded
[CHG] Controller 00:AA:01:00:00:23 Powered: yes
[bluetooth]# register-service 00001820-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
/org/bluez/app/service0xd5eac0
00001820-0000-1000-8000-00805f9b34fb
Internet Protocol Support
[/org/bluez/app/service0xd5eac0] Primary (yes/no): yes
register-characteristic 00002a06-0000-1000-8000-00805f9b34fb
write-without-response
[NEW] Characteristic
/org/bluez/app/service0xd5eac0/chrc0xd5f150
00002a06-0000-1000-8000-00805f9b34fb
Alert Level
[/org/bluez/app/service0xd5eac0/chrc0xd5f150] Enter value: 0x1
[bluetooth]# register-application
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 00001820-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Controller 00:AA:01:00:00:23 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
Application registered
[bluetooth]# advertise on
Advertising object registered


Thanks
Best wishes
Yunhan
