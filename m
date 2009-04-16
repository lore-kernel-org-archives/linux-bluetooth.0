Return-Path: <cyrus@holtmann.org>
Message-ID: <49E7B7B4.3010009@d-meeus.be>
Date: Fri, 17 Apr 2009 00:56:52 +0200
From: =?UTF-8?B?RG9taW5pcXVlIE1lZcO5cw==?= <dominique@d-meeus.be>
MIME-Version: 1.0
To: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: btusb/Bluez incompatibility with D-Link DBT 122 dongle
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My dongle works to a certain extent with btusb alone.
lsusb | grep Bluetooth: Bus 003 Device 002: ID 2001:f111 D-Link Corp. 
[hex] DBT-122 Bluetooth adapter
uname -a: Linux library 2.6.28-11-generic #41-Ubuntu SMP Wed Apr 8 
04:38:53 UTC 2009 i686 GNU/Linux
dpkg -l | grep bluez: ...bluez        4.35-0ubuntu1...
lsmod | grep btusb: btusb        19608  2
sudo /etc/init.d/bluetooth stop: * Stopping bluetooth        [ OK ]
sudo hciconfig hci0 up
hciconfig -a
hci0:    Type: USB
    BD Address: 00:13:46:00:55:A0 ACL MTU: 377:10 SCO MTU: 16:0
    UP RUNNING
    RX bytes:1015 acl:0 sco:0 events:30 errors:0
    TX bytes:632 acl:0 sco:0 commands:36 errors:0
    Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy:
    Link mode: SLAVE ACCEPT
    Name: 'Broadcom BCM2035'
    Class: 0x000000
    Service Classes: Unspecified
    Device Class: Miscellaneous,
    HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
    Manufacturer: Broadcom Corporation (15)
hcitool scan: Scanning ...    00:13:70:0E:8A:77    Nokia 6021

So with btusb alone, my dongle is recognised and sees my phone. (I could 
also ask for more details about my phone or successfully l2ping it, et 
cetera.)
But if I want to pair with my phone to actually DO something (like using 
Wammu) I need more Bluez software. Wammu expects me to do:
sudo /etc/init.d/bluetooth start:  * Starting bluetooth        [ OK ]

But with this, nothing works any more
hciconfig -a
hci0:    Type: USB
    BD Address: 00:13:46:00:55:A0 ACL MTU: 377:10 SCO MTU: 16:0
    UP RUNNING
    RX bytes:1802 acl:0 sco:0 events:55 errors:0
    TX bytes:1219 acl:0 sco:0 commands:57 errors:0
    Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy:
    Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out (110)

And no more scan or l2ping. Wammu cannot connect either.
(The D-Link DBT-122 works perfectly with Bluez 3.26 under Ubuntu 8.04)
Is this bug (regression) peculiar to Ubuntu 8.10 and 9.04 or an upstream 
Bluez bug ?
-- 
Amicalement, Dominique
