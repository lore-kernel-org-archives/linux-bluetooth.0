Return-Path: <cyrus@holtmann.org>
From: "Dan A. Dickey" <dan.dickey@savvis.net>
To: linux-bluetooth@vger.kernel.org
Subject: Need help with debugging a bluetooth mouse (trackball)
Date: Thu, 18 Jun 2009 14:16:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200906181416.20421.dan.dickey@savvis.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a Kensington SlimBlade Trackball mouse that I'm trying to get working again.
It has worked in the past.

Currently, I'm running 2.6.30 and bluez-4.41.

My adaptor shows up just fine:
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:19:15:60:19:6A ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:7286 acl:81 sco:0 events:231 errors:0
        TX bytes:2610 acl:98 sco:0 commands:99 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'fizban-0'
        Class: 0x4a0104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x414e LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)


And when I move the mouse (roll the ball) - I get the following from a 'bluetoothd -n -d':
bluetoothd[4179]: adapter_get_device(00:02:76:03:A8:51)
bluetoothd[4179]: adapter_create_device(00:02:76:03:A8:51)
bluetoothd[4179]: Creating device /org/bluez/4179/hci0/dev_00_02_76_03_A8_51
bluetoothd[4179]: btd_device_ref(0x7f8d4e403d20): ref=1
bluetoothd[4179]: Incoming connection on PSM 17

'hcitool con' shows:
# hcitool con
Connections:
        > ACL 00:02:76:03:A8:51 handle 11 state 1 lm MASTER

'list-bluetooth-devices' shows:
# list-bluetooth-devices
[ /org/bluez/4179/hci0 ]
    Name = fizban-0
    Powered = 1
    Devices = dev_00_02_76_03_A8_51
    DiscoverableTimeout = 0
    PairableTimeout = 0
    Discoverable = 0
    Address = 00:19:15:60:19:6A
    Discovering = 0
    Pairable = 1
    Class = 4849924
    [ /org/bluez/4179/hci0/dev_00_02_76_03_A8_51 ]
        Name = Kensington SlimBlade Trackball Mouse
        Paired = 0
        Adapter = /org/bluez/4179/hci0
        Alias = Kensington SlimBlade Trackball Mouse
        Connected = 1
        UUIDs =
        Address = 00:02:76:03:A8:51
        Class = 0x002580
        Trusted = 0
        Icon = input-mouse

One of the things that looks suspicious above is that it shows 'Paired = 0'.
When I run simple-agent, I just get:# simple-agent              
Agent registered                     
Authorize (/org/bluez/2468/hci0/dev_00_02_76_03_A8_51, 00001124-0000-1000-8000-00805f9b34fb)


So... any help to figure out this problem would be much appreciated.
Let me know what I can try... I'm a developer so I can handle rebuilding whatever.

One thing I'm curious about is where can I see the ID_VENDOR and ID_MODEL
that get passed between udev and the hid2hci rules?  Since this is a kensingon
mouse, I presume it doesn't match one of the entries in there...
	-Dan

-- 
Dan A. Dickey | Senior Software Engineer

Savvis
10900 Hampshire Ave. S., Bloomington, MN  55438
Office: 952.852.4803 | Fax: 952.852.4951
E-mail: dan.dickey@savvis.net
