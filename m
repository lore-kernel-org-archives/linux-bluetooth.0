Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: neci <robo.neci@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 2 Aug 2006 17:45:46 +0200
References: <200608021725.01649.robo.neci@gmail.com>
	<44D0C6A9.90708@ibdcon.org.br>
In-Reply-To: <44D0C6A9.90708@ibdcon.org.br>
MIME-Version: 1.0
Message-Id: <200608021745.47752.robo.neci@gmail.com>
Cc: Paulo Wollny <paulo.wollny@ibdcon.org.br>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Connection refused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

it is wrong command?
#cd /dev && *mknod rfcomm0* c 216 0 && *mknod* rfcomm1 c 216 1
bash: *mknod: command not found

i edit him

# cd /dev && mknod rfcomm0 c 216 0 && mknod rfcomm1 c 216 1
# chmod 666 /dev/rfcomm*
# rfcomm connect rfcomm0
Can't connect RFCOMM socket: Connection refused

Paulo Wollny write:
> As root, issue the following command:
> cd /dev && *mknod rfcomm0* c 216 0 && *mknod* rfcomm1 c 216 1
> then, chmod 666 /dev/rfcomm*
>
> neci schrieb:
> > Hello,
> > i can't create /dev/rfcomm. What is wrong? attach config files and out
> > from hcidump.
> >
> > # rfcomm connect rfcomm0
> > Can't connect RFCOMM socket: Connection refused
> >
> > # hcidump
> > HCI sniffer - Bluetooth packet analyzer ver 1.24
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > linux:/etc # hcidump
> > HCI sniffer - Bluetooth packet analyzer ver 1.24
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >
> >> HCI Event: Command Status (0x0f) plen 4
> >> HCI Event: Connect Complete (0x03) plen 11
> >
> > < ACL data: handle 42 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 3 scid 0x0040
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> HCI Event: Max Slots Change (0x1b) plen 3
> >> HCI Event: Command Complete (0x0e) plen 6
> >> ACL data: handle 42 flags 0x02 dlen 16
> >
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> >       Connection successful
> > < ACL data: handle 42 flags 0x02 dlen 16
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 1024
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> ACL data: handle 42 flags 0x02 dlen 17
> >> ACL data: handle 42 flags 0x01 dlen 1
> >
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
> >       Success
> >       MTU 335
> >
> >> ACL data: handle 42 flags 0x02 dlen 16
> >
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 335
> > < ACL data: handle 42 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> >       Success
> > < ACL data: handle 42 flags 0x02 dlen 8
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> ACL data: handle 42 flags 0x02 dlen 8
> >
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > < ACL data: handle 42 flags 0x02 dlen 18
> >     L2CAP(d): cid 0x0040 len 14 [psm 3]
> >       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
> >       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
> >       frame_size 330 max_retrans 0 credits 7
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> ACL data: handle 42 flags 0x02 dlen 18
> >
> >     L2CAP(d): cid 0x0040 len 14 [psm 3]
> >       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
> >       dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
> >       frame_size 330 max_retrans 0 credits 4
> > < ACL data: handle 42 flags 0x02 dlen 8
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> >> HCI Event: Role Change (0x12) plen 8
> >> HCI Event: Max Slots Change (0x1b) plen 3
> >> HCI Event: Link Key Request (0x17) plen 6
> >
> > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> >
> >> HCI Event: Command Complete (0x0e) plen 10
> >> ACL data: handle 42 flags 0x02 dlen 8
> >
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> > < ACL data: handle 42 flags 0x02 dlen 8
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
> > < ACL data: handle 42 flags 0x02 dlen 12
> >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> >
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> HCI Event: Number of Completed Packets (0x13) plen 5
> >> ACL data: handle 42 flags 0x02 dlen 8
> >
> >     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> >
> >> ACL data: handle 42 flags 0x02 dlen 12
> >
> >     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >
> >> HCI Event: Command Status (0x0f) plen 4
> >> HCI Event: Disconn Complete (0x05) plen 4
> >>
> >> ------------------------------------------------------------------------
> >>
> >> #
> >> # HCI daemon configuration file.
> >> #
> >> # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
> >> #
> >>
> >> # HCId options
> >> options {
> >> 	# Automatically initialize new devices
> >> 	autoinit yes;
> >>
> >> 	# Security Manager mode
> >> 	#   none - Security manager disabled
> >> 	#   auto - Use local PIN for incoming connections
> >> 	#   user - Always ask user for a PIN
> >> 	#
> >> 	security auto;
> >>
> >> 	# Pairing mode
> >> 	#   none  - Pairing disabled
> >> 	#   multi - Allow pairing with already paired devices
> >> 	#   once  - Pair once and deny successive attempts
> >> 	pairing multi;
> >>
> >> 	# PIN helper
> >> 	# if you want a interactiv query of your pin use /usr/bin/bluepin
> >> 	# /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
> >> 	# pin_helper /usr/bin/bluepin;
> >> 	pin_helper /bin/bluepincat;
> >>
> >> 	# D-Bus PIN helper
> >> 	#dbus_pin_helper;
> >> }
> >>
> >> # Default settings for HCI devices
> >> device {
> >> 	# Local device name
> >> 	#   %d - device id
> >> 	#   %h - host name
> >> 	name "PC";
> >>
> >> 	# Local device class
> >> 	# e.g.
> >> 	#  0xsss100 = Computer
> >> 	#  0xsss104 = Computer Desktop
> >> 	#  0xsss108 = Computer Server
> >> 	#  0xsss10c = Computer Laptop
> >> 	# The 'sss' above defines the service-class (not quite, only the
> >> 	# first 11 bits, the next 11 define the device-class, than 2 format
> >> bits.) # See
> >> https://www.bluetooth.org/foundry/assignnumb/document/baseband # for
> >> more information.
> >> 	# 0x100bbb stands for "Object Transfer  (v-Inbox, v-Folder, ...)"
> >> 	# 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
> >> 	class 0xdb0100;
> >>
> >> 	# Default packet type
> >> 	#pkt_type DH1,DM1,HV1;
> >>
> >> 	# Inquiry and Page scan
> >> 	# valid parameters: enable | disable
> >> 	iscan enable;
> >> 	pscan enable;
> >>
> >> 	# Default link mode
> >> 	#   none   - no specific policy
> >> 	#   accept - always accept incoming connections
> >> 	#   master - become master on incoming connections,
> >> 	#            deny role switch on outgoing connections
> >> 	lm accept;
> >>
> >> 	# Default link policy
> >> 	#   none    - no specific policy
> >> 	#   rswitch - allow role switch
> >> 	#   hold    - allow hold mode
> >> 	#   sniff   - allow sniff mode
> >> 	#   park    - allow park mode
> >> 	lp rswitch,hold,sniff,park;
> >>
> >> 	# Authentication and Encryption (Security Mode 3)
> >> 	auth disable;
> >> 	encrypt disable;
> >> }
> >>
> >> ------------------------------------------------------------------------
> >>
> >> #
> >> # RFCOMM configuration file.
> >> #
> >> # $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
> >> #
> >>
> >> rfcomm0 {
> >> 	# Automatically bind the device at startup
> >> 	bind yes;
> >>
> >> 	# Bluetooth address of the device
> >> 	device 00:01:E3:58:23:EA;
> >>
> >> 	# RFCOMM channel for the connection
> >> 	channel	1;
> >>
> >> 	# Description of the connection
> >> 	comment "Mobil";
> >> }
> >>
> >> ------------------------------------------------------------------------
> >>
> >> ------------------------------------------------------------------------
> >>- Take Surveys. Earn Cash. Influence the Future of IT
> >> Join SourceForge.net's Techsay panel and you'll get the chance to share
> >> your opinions on IT & business topics through brief surveys -- and earn
> >> cash
> >> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
> >>V
> >> ------------------------------------------------------------------------
> >>
> >> _______________________________________________
> >> Bluez-users mailing list
> >> Bluez-users@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your opinions on IT & business topics through brief surveys -- and earn
> cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
