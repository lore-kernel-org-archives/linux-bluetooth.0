Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Sep 2008 16:06:02 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Reply-To: rankincj@yahoo.com
Subject: Linux 2.6.26.4: BT dongle will not pair with A2DP speakers
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <232389.93036.qm@web52902.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am running a 2.6.26.4 kernel with Fedora 9, with the following bluez packages installed:

bluez-hcidump-1.41-1.fc9.i386
bluez-libs-devel-3.35-1.fc9.i386
bluez-utils-3.35-3.fc9.i386
bluez-utils-alsa-3.35-3.fc9.i386
bluez-utils-gstreamer-3.35-3.fc9.i386
bluez-gnome-0.26-1.fc9.i386
bluez-libs-3.35-1.fc9.i386

I also have a USB BT dongle, and I am unable to persuade this dongle to pair with my A2DP speakers. This is what bluez tells me about the speakers:

# hcitool inq
Inquiring ...
	00:14:EF:00:20:05	clock offset: 0x3800	class: 0x240404

# hcitool info 00:14:EF:00:20:05
Requesting information ...
	BD Address:  00:14:EF:00:20:05
	OUI Company: TZero Technologies, Inc. (00-14-EF)
	LMP Version: 2.0 (0x3) LMP Subversion: 0x103a
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xff 0xff 0x8f 0x7e 0x98 0x19 0x00 0x80
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
		<power control> <transparent SCO> <broadcast encrypt> 
		<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
		<AFH cap. slave> <AFH class. slave> <3-slot EDR ACL> 
		<5-slot EDR ACL> <AFH cap. master> <AFH class. master> 
		<extended features> 
T
This is what I can tell about the dongle itself:

# hciconfig -a hci0
hci0:	Type: USB
	BD Address: 00:0A:3A:7D:FF:80 ACL MTU: 1017:5 SCO MTU: 64:0
	UP RUNNING PSCAN 
	RX bytes:10633 acl:102 sco:0 events:338 errors:0
	TX bytes:4703 acl:94 sco:0 commands:108 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'whatever'
	Class: 0x080404
	Service Classes: Capturing
	Device Class: Audio/Video, Device conforms to the Headset profile
	HCI Ver: 2.0 (0x3) HCI Rev: 0x419d LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)

What is happening is that every attempt to connect to these speakers is being dropped before I have a chance to authenticate with my PIN. This is the output from hcidump for a connection attempt:

# hcidump -V -i hci0
HCI sniffer - Bluetooth packet analyzer ver 1.41
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:14:EF:00:20:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:14:EF:00:20:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
< ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 12 policy 0x0e
    Link policy: HOLD SNIFF PARK 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x8f 0x7e 0x98 0x19 0x00 0x80
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 12
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:14:EF:00:20:05 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:14:EF:00:20:05 name 'HouseParty Blu-Gear4'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host

It looks like these speakers don't like my dongle for some reason, but I have no idea why. The dongle is advertised as supporting BT v2.0 with EDR. I have also successfully paired these speakers with my laptop and its built-in BT support, and have also paired this dongle with my mobile phone and transferred files across to my desktop.

Can anyone see anything which might explain what is happening, please? Or maybe suggest a means of debugging this further?

Thanks for any assistance,
Cheers,
Chris



      
