Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Sep 2008 15:44:47 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <322551.10888.qm@web52907.mail.re2.yahoo.com>
Subject: [Bluez-devel] Linux 2.6.26.4: BT dongle will not pair with A2DP
	speakers
Reply-To: rankincj@yahoo.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I am using a Belkin BT USB dongle (IDs 0x050d:0x0121) with my Linux 2.6.26.4 box, and I am unable to pair it with a pair of BT speakers. Basically, I am doing the following:

# hcitool scan               To get the remote address <bdaddr>
# hcitool cc <bdaddr>
# hcitool auth <bdaddr>

I have been able to pair the speakers with my laptop and its built-in BT support. However, with my desktop and this BT dongle, the connection always drops before I have time to type the PIN in.

I am still able to talk to the speakers via the dongle using l2ping:

# l2ping -c 10 00:14:EF:00:20:05
Ping: 00:14:EF:00:20:05 from 00:0A:3A:7D:FF:80 (data size 44) ...
4 bytes from 00:14:EF:00:20:05 id 0 time 6.88ms
4 bytes from 00:14:EF:00:20:05 id 1 time 19.17ms
4 bytes from 00:14:EF:00:20:05 id 2 time 7.93ms
4 bytes from 00:14:EF:00:20:05 id 3 time 23.69ms
4 bytes from 00:14:EF:00:20:05 id 4 time 25.48ms
4 bytes from 00:14:EF:00:20:05 id 5 time 30.25ms
4 bytes from 00:14:EF:00:20:05 id 6 time 25.02ms
4 bytes from 00:14:EF:00:20:05 id 7 time 12.81ms
4 bytes from 00:14:EF:00:20:05 id 8 time 31.59ms
4 bytes from 00:14:EF:00:20:05 id 9 time 30.32ms
10 sent, 10 received, 0% loss

and have also successfully paired the dongle with my mobile phone and transferred files between the phone and the PC. However, the speakers are proving impossible. This is what bluez says about the speakers:

# hcitool inq
Inquiring ...
	00:14:EF:00:20:05	clock offset: 0x37ed	class: 0x240404

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

And this is what bluez says about my dongle:

# hciconfig -a hci0
hci0:	Type: USB
	BD Address: 00:0A:3A:7D:FF:80 ACL MTU: 1017:5 SCO MTU: 64:0
	UP RUNNING PSCAN 
	RX bytes:8565 acl:88 sco:0 events:268 errors:0
	TX bytes:3853 acl:80 sco:0 commands:80 errors:0
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

According to the manufacturer, the dongle supports BT v2.0 with EDR.

I am now at a loss to debug this further. Can anyone suggest why the connection is being dropped before I have a chance to pair the speakers, please? Or maybe a way of debugging what is happening? Could it even be that the dongle simply doesn't support something that the speakers need, and would there be a way of finding out what this may be, please?

Thanks for any assistance here,
Cheers,
Chris

P.S. I am using Fedora 9, which has the following bluez packages:
bluez-libs-devel-3.35-1.fc9.i386
bluez-utils-3.35-3.fc9.i386
bluez-utils-alsa-3.35-3.fc9.i386
bluez-utils-gstreamer-3.35-3.fc9.i386
bluez-gnome-0.26-1.fc9.i386
bluez-libs-3.35-1.fc9.i386



      

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
