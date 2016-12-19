Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5byg5aKe5rOi?= <zengbo.zhang@gmail.com>
Date: Mon, 19 Dec 2016 17:47:24 +0800
Message-ID: <CAOMnebqO6uRDXr-g16xTg8gY7Kh_-81fiYNNMHywc-ykOrc1Cg@mail.gmail.com>
Subject: Strange issue for a blood pressure device
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

        I tested a blood pressure bluetooth device so I can use it for
later use. But I found a strange issue: I can connect to the device
successful ONLY BEFORE SCANNING after RE-PLUGGING THE Bluetooth dongle
OR RESTARTING THE BLUETOOTH DAEMON.   I attached  an interactive log
at the end of this mail of the using of bluetoothctl.

my enviroment: latest manjaro linux stable; kernel: 4.4.33; bluez 5.43 .

The device factory provided a protocol and two test methods on
Android/IOS. For android host, it connect to the device over an
serial; For ios host, it connect to the device over LE, both works
flne. I wanted to connect to it on linux using LE mode.

Maybe this information is helpful:  the uuids of the device changed
over time. when just scanning, it reports 2 [ 0xff00, 0x1101 ], when I
tried to connect it , it reports [0x1101, 0x1200 ] , and I can't
connect to it without re-pluging the dongle. If I connect it
succefully, it reports about 6 service uuids.

So why this issue? I can do more test  but I don't know how to do
without any suggestion, thanks.


[bluetooth]# connect 88:1B:99:0D:A1:34
Attempting to connect to 88:1B:99:0D:A1:34
[CHG] Device 88:1B:99:0D:A1:34 Connected: yes
Connection successful
[CHG] Device 88:1B:99:0D:A1:34 ServicesResolved: yes
[BP06D21609010379]# disconnect 88:1B:99:0D:A1:34
Attempting to disconnect from 88:1B:99:0D:A1:34
[CHG] Device 88:1B:99:0D:A1:34 ServicesResolved: no
Successful disconnected
[CHG] Device 88:1B:99:0D:A1:34 Connected: no
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:1A:7D:DA:71:05 Discovering: yes
[CHG] Device 88:1B:99:0D:A1:34 RSSI: -78
[CHG] Device 88:1B:99:0D:A1:34 TxPower: 2
[CHG] Device 88:1B:99:0D:A1:34 ManufacturerData Key: 0x4d42
[CHG] Device 88:1B:99:0D:A1:34 ManufacturerData Value: 0x37
[CHG] Device 88:1B:99:0D:A1:34 ManufacturerData Value: 0x37
[CHG] Device 88:1B:99:0D:A1:34 RSSI: -70
[CHG] Device 88:1B:99:0D:A1:34 RSSI: -78
[bluetooth]# scan off
[CHG] Device 88:1B:99:0D:A1:34 TxPower is nil
[CHG] Device 88:1B:99:0D:A1:34 RSSI is nil
Discovery stopped
[CHG] Controller 00:1A:7D:DA:71:05 Discovering: no
[bluetooth]# connect 1B:99:0D:A1:34
Attempting to connect to 88:1B:99:0D:A1:34
[CHG] Device 88:1B:99:0D:A1:34 Connected: yes
[CHG] Device 88:1B:99:0D:A1:34 ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 88:1B:99:0D:A1:34 ServicesResolved: no
[CHG] Device 88:1B:99:0D:A1:34 Connected: no
