Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Moritz Bunkus <moritz@bunkus.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040528154111.GD24083@bunkus.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AsxXAMtlQ5JHofzM"
Subject: [Bluez-users] connection to Motorola V525 fails
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 28 May 2004 17:41:11 +0200


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list,

(resent because of the size limitation - please ignore the other mail
if it'll be approved later)

I can't establish a working connection between my computer(s) and my
bluetooth mobile, a Motorola V525. At [1] (sorry, only in German) a user
has described how to get that exact combination to work properly, but it
doesn't work for me.

So what does work? 'hcitool scan' finds my phone. 'sdptool browse
00:...' does list all the services on the phone, and I've found the
channel for the OBEX transfers which is 9. But using the obextool from
[2] fails. It does connect to the phone, and the following PIN
verification completes successfully. Afterwards the phone asks me if the
file transfer should be accepted, I hit 'yes' but that's it - no more
data flows between the two devices.

Now a bit about my system and the software revisions I've used. I've
tried with bluez-utils 2.4 through 2.7 (some of them Debian/unstable
packages, 2.5 from souce). I've tried kernels 2.4.24, 2.6.4 and 2.6.6
with the -mh1 patch. I've tried two different USB dongles, both are CSR
based, but I only have one available at the moment. Here's the output of
'hciconfig -a' for this dongle:

hci0:   Type: USB
        BD Address: 00:02:72:40:45:26 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:4378 acl:44 sco:0 events:120 errors:0
        TX bytes:1654 acl:48 sco:0 commands:43 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'ls-bs-ws6-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
        0x20d
        Manufacturer: Cambridge Silicon Radio (10)

This is a device by Yakumo, one of the cheaper stuff sold around
here. The other dongle was built by Acer, but I don't know its exact
description. Both are USB dongles, obviously, and they're both
recognized flawlessly. At the moment I don't have access to any other
Bluetooth hardware - neither to computers with built-in Bluetooth
support, nor to other dongles or devices.

The remaining files are attached to this mail. The first is the
hcid.conf which is basically the default configuration. I've also tried
with enabling authentication and encryption, but basically I've left
both disabled for most of the tests.

The second file, 'motorola-v525-bluezutils24.dump', is the output of
'hcidump -t -x' during the call to 'obextool push test.jpg 00:... 9'. It
was done with bluez-utils 2.4 (older package from Debian/unstable). The
third is the same but with bluez-utils 2.7 (package from [3]).

I hope someone can make sense of the dumps. I can also provide an
additional dump made by the author of [1] which shows a successful
transfer to his Motorola V525.

Hopefully I haven't forgotten too much vital stuff. I'd appreciate any
help. Thanks.

Mosu

[1]  http://www.handykult.de/forums/archive/index.php/t-87776
[2]  http://www.unrooted.net/openSource/bluez/
[3]  http://bluez.sourceforge.net/download/debian/
-- 
If Darl McBride was in charge, he'd probably make marriage
unconstitutional too, since clearly it de-emphasizes the commercial
nature of normal human interaction, and probably is a major impediment
to the commercial growth of prostitution. - Linus Torvalds

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hcid.conf"
Content-Transfer-Encoding: quoted-printable

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluez-pin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy=20
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="motorola-v525-bluezutils24.dump"
Content-Transfer-Encoding: quoted-printable

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
1085751416.248372 < HCI Command: Create Connection(0x01|0x0005) plen 13
  93 C1 BB 28 0A 00 18 CC 01 00 00 00 01=20
1085751416.255191 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04=20
1085751418.127718 > HCI Event: Connect Complete(0x03) plen 11
  00 29 00 93 C1 BB 28 0A 00 01 00=20
1085751418.127889 < ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
1085751418.127906 < HCI Command: Write Link Policy Settings(0x02|0x000d) pl=
en 4
  29 00 0E 00=20
1085751418.133712 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.142709 > HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05=20
1085751418.143708 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00=20
1085751418.173713 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1085751418.173966 < ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024=20
1085751418.175702 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1506=20
1085751418.175833 < ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1085751418.182704 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.185701 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.202705 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 1024=20
1085751418.202764 < ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
1085751418.208693 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.235694 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
1085751418.235749 < ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 1019=
 max_retrans 0 credits 7
1085751418.243684 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.266688 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 1019=
 max_retrans 0 credits 0
1085751418.266744 < ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32=20
1085751418.273681 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00=20
1085751418.362657 > HCI Event: Link Key Request(0x17) plen 6
  93 C1 BB 28 0A 00=20
1085751418.362833 < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  93 C1 BB 28 0A 00 7E 7B 47 77 CE B2 23 1F 2A 91 EB 01 64 1A=20
  58 7B=20
1085751418.377652 > HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 93 C1 BB 28 0A 00=20
1085751418.752559 > HCI Event: Encrypt Change(0x08) plen 4
  00 29 00 01=20

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="motorola-v525-bluezutils27.dump"
Content-Transfer-Encoding: quoted-printable

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
1085751713.613746 < HCI Command: Create Connection(0x01|0x0005) plen 13
  93 C1 BB 28 0A 00 18 CC 01 00 00 00 01=20
1085751713.620709 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04=20
1085751716.103081 > HCI Event: Connect Complete(0x03) plen 11
  00 2A 00 93 C1 BB 28 0A 00 01 00=20
1085751716.103322 < ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
1085751716.103340 < HCI Command: Write Link Policy Settings(0x02|0x000d) pl=
en 4
  2A 00 0F 00=20
1085751716.111076 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.119073 > HCI Event: Max Slots Change(0x1b) plen 3
  2A 00 05=20
1085751716.121071 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 2A 00=20
1085751716.145074 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1085751716.145260 < ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024=20
1085751716.147066 > ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1506=20
1085751716.147207 < ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1085751716.159064 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.163060 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.179062 > ACL data: handle 0x002a flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 1024=20
1085751716.179618 < ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
1085751716.186056 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.223054 > ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
1085751716.223112 < ACL data: handle 0x002a flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 1019=
 max_retrans 0 credits 7
1085751716.231045 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.255045 > ACL data: handle 0x002a flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 1019=
 max_retrans 0 credits 0
1085751716.255099 < ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32=20
1085751716.262040 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00=20
1085751716.329022 > HCI Event: Link Key Request(0x17) plen 6
  93 C1 BB 28 0A 00=20
1085751716.329506 < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  93 C1 BB 28 0A 00 7E 7B 47 77 CE B2 23 1F 2A 91 EB 01 64 1A=20
  58 7B=20
1085751716.344019 > HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 93 C1 BB 28 0A 00=20
1085751716.710924 > HCI Event: Encrypt Change(0x08) plen 4
  00 2A 00 01=20

--AsxXAMtlQ5JHofzM--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
