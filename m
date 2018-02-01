Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 1 Feb 2018 23:24:37 +0000
Message-ID: <CAAu3APYyQ5b1kDhFaJVZMCpYXvtz6R+sF5mv=juxVAPzbD0vqQ@mail.gmail.com>
Subject: btvirt not working
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to get the adapter emulator working for BLE but I am
having some issues:

pi@RPi3:~/bluez/bluez-5.43 $ sudo ./emulator/btvirt -l2
Bluetooth emulator ver 5.43
Failed to open Virtual HCI device

If I select BR/ER only then it works:

pi@RPi3:~/bluez/bluez-5.43 $ sudo emulator/btvirt -B -l2
Bluetooth emulator ver 5.43

As in another terminal I can see the extra adapters:

pi@RPi3:~ $ bluetoothctl list
[NEW] Controller 00:AA:01:01:00:24 RPi3 #3 [default]
[NEW] Controller 00:AA:01:00:00:23 RPi3 #2
[NEW] Controller B8:27:EB:22:57:E0 RPi3

I have also tried with just LE only controller:

pi@RPi3:~/bluez/bluez-5.43 $ sudo emulator/btvirt -L -l2
Bluetooth emulator ver 5.43
Failed to open Virtual HCI device

The btmon trace for this is:

pi@RPi3:~ $ sudo btmon
Bluetooth monitor ver 5.43
= Note: Linux version 4.9.59-v7+ (armv7l)
                                                        0.220518
= Note: Bluetooth subsystem version 2.22
                                                        0.220527
= New Index: B8:27:EB:22:57:E0 (Primary,UART,hci0)
                                                 [hci0] 0.220531
= Open Index: B8:27:EB:22:57:E0
                                                 [hci0] 0.220533
= Index Info: B8:27:EB:22:57:E0 (Broadcom Corporation)
                                                 [hci0] 0.220535
@ MGMT Open: bluetoothd (privileged) version 1.14
                                               {0x0001} 0.220539
@ MGMT Open: btmon (privileged) version 1.14
                                               {0x0002} 0.220807
= New Index: 00:00:00:00:00:00 (Primary,Virtual,hci1)
                                                 [hci1] 6.103687
= Open Index: 00:00:00:00:00:00
                                                 [hci1] 6.103726
< HCI Command: Reset (0x03|0x0003) plen 0
                                                 [hci1] 6.103875
= Close Index: 00:00:00:00:00:00
                                                [hci1] 16.676567
= Delete Index: 00:00:00:00:00:00
                                                [hci1] 16.676627

Any suggestions as to what the issue might be?
Or what to try next?

Thanks,
Barry
