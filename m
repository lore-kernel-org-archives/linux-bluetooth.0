Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: A blue chamaleon to be
References: <op.s1tgc9j9xabado@portatilegio> <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost> <op.s1t0xmg8xabado@portatilegio> <op.s1t2ws0rxabado@portatilegio> <op.s1t63hh3xabado@portatilegio> <20051215211716.GB12373@elmicha.333200002251-0001.dialin.t-online.de>
Message-ID: <op.s1uu2mo1xabado@portatilegio>
From: "zio tom" <zio.tom@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <20051215211716.GB12373@elmicha.333200002251-0001.dialin.t-online.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 16 Dec 2005 03:41:00 +0100

In data Thu, 15 Dec 2005 22:17:16 +0100, Michael Mauch  
<michael.mauch@gmx.de> ha scritto:

> "rfcomm" should show rfcomm0 with the device address and the channel.
> If not, run "rfcomm bind 0".
>
> If that works, you could change the "bind no" to "bind yes" in
> rfcomm.conf and restart the bluez/bluetooth init script (hopefully it
> contains a "rfcomm bind all").

Thanks a lot for aswerin on such a newbie issue!
So, here my GPRS/Bluetooth situation. I start kde, I open the shell, I  
type su and the password, then wvdial, my mobile show a pin request, I  
insert it, the pc pops up with a small window asking the pin, I insert it,  
the phone says "the pin has been verified and saved"

and here what I get:

linux:/home/giovanni # wvdial
--> WvDial: Internet dialer version 1.54.0
--> Cannot open /dev/rfcomm0: Cannot get information for serial port.
--> Cannot open /dev/rfcomm0: Input/output error
--> Cannot open /dev/rfcomm0: Cannot get information for serial port.
linux:/home/giovanni #


(Two new files appeared in my home folder, after the quantity of attempts  
of configuration of wvdial.conf and /etc/bluetooth I made: ttys1 and  
ttys10: the devices I tried to link to rfcomm0.
for a gprs connection, shall I use wvdial on the shell, and wvdial.conf  
for my provider's settings, right?)

My configuration now is:

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
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
	security user;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	# if you want a interactiv query of your pin use /usr/bin/bluepin
	# /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
	# pin_helper /usr/bin/bluepin;
	pin_helper /bin/bluepincat;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "BlueZ %h (%d)";

	# Local device class
	# e.g.
	#  0xsss100 = Computer
	#  0xsss104 = Computer Desktop
	#  0xsss108 = Computer Server
	#  0xsss10c = Computer Laptop
	# The 'sss' above defines the service-class (not quite, only the
	# first 11 bits, the next 11 define the device-class, than 2 format bits.)
	# See https://www.bluetooth.org/foundry/assignnumb/document/baseband
	# for more information.
	# 0x100bbb stands for "Object Transfer  (v-Inbox, v-Folder, ...)"
	# 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
	class 0x000100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	# valid parameters: enable | disable
	iscan enable;
	pscan enable;

	# Default link mode
	#   none   - no specific policy
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption (Security Mode 3)
	auth disable;
	encrypt disable;
}



#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
	# Automatically bind the device at startup
	bind yes;

	# Bluetooth address of the device
	device 00:0A:28:0C:D4:EF;

	# RFCOMM channel for the connection
	channel	1;

	# Description of the connection
	comment "V600";
}

pairing works. When I get the error

Another issue is that I can't use the mobile twice for a connection in the  
need of pairing (for example ftp obex): I always need to erase the pairing  
 from the phone e re-enter the pin on both devices.. Please help me, it's  
the third night I'm spending on this... :(

here is the result of hcidump -X -V while I'm trying to do this:


Password:
linux:/home/giovanni # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.24
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0A:28:0C:D4:EF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 5 bdaddr 00:0A:28:0C:D4:EF type ACL encrypt 0x00
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 5 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 5
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1024
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1506
< ACL data: handle 5 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 2
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       Success
       MTU 1024
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 0
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:0A:28:0C:D4:EF
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
     bdaddr 00:0A:28:0C:D4:EF len 6 pin '123456'
> HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Reply (0x01|0x000d) ncmd 1
     status 0x00 bdaddr 00:0A:28:0C:D4:EF
> HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:0A:28:0C:D4:EF key 41EE651CF109EE6943EF895DFD9C993B type 0
> HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 5 encrypt 0x01
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 15
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
> ACL data: handle 5 flags 0x02 dlen 13
     L2CAP(d): cid 0x0040 len 9 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 5 fcs 0xaa mcc_len 3
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 1 b3 1 len 15
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 1 b3 1 len 15
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 3
> ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 15
< ACL data: handle 5 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x36
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 4
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1024
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1506
< ACL data: handle 5 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 2
> ACL data: handle 5 flags 0x02 dlen 17
> ACL data: handle 5 flags 0x01 dlen 1
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       Success
       MTU 1024
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
