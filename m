Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Richard Worwood <mlists@tdbnetworks.org>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-+vkRabJfNX3b0thfrrLd"
Message-Id: <1092718810.3163.76.camel@hellontoast>
Mime-Version: 1.0
Subject: [Bluez-users] BlueZ Newbie
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
Date: Tue, 17 Aug 2004 06:00:10 +0100


--=-+vkRabJfNX3b0thfrrLd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Firstly apologies in advance if I ask any stupid questions but I'm a
complete newbie to BlueZ and am trying to use it to enable me to dial-up
to the net using gprs.

Any way to the problem I've got all the way to the point that rfcomm
associations happen automatically and then I try to access the device
using minicom and it starts fine but doesn't appear to be completing the
connection process and then drops.

I've included extracts from the /var/log/messages output my config files
and an hcidump for your review.

Thanks in advance

Richard

/var/log/messages extract:

Aug 17 05:26:52 hellontoast hcid[4513]: HCI dev 0 registered
Aug 17 05:26:53 hellontoast hcid[4513]: HCI dev 0 up
Aug 17 05:26:53 hellontoast hcid[4513]: Starting security manager 0
^[[AAug 17 05:28:22 hellontoast hcid[4513]: link_key_request
(sba=00:10:60:A4:75:55, dba=00:0E:07:CA:15:AE)
Aug 17 05:34:13 hellontoast hcid[4513]: link_key_request
(sba=00:10:60:A4:75:55, dba=00:0E:07:CA:15:AE)
Aug 17 05:34:23 hellontoast hcid[4513]: link_key_request
(sba=00:10:60:A4:75:55, dba=00:0E:07:CA:15:AE)



-- 
Richard

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=hcid.conf
Content-Type: text/plain; name=hcid.conf; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk Exp $
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
	pin_helper /etc/bluetooth/bluepin
	#pin_helper /usr/bin/bluepin;
	#dbus_pin_helper;

	# A dbus PIN daemon can be found at
	# ftp://ftp.handhelds.org/pub/projects/gpe/source/bluez-pin-0.20.tar.gz
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x120104;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept,master;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp hold,sniff,park;

	# Authentication and Encryption
	auth enable;
	encrypt enable;
}

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=hcidump.log
Content-Type: text/x-log; name=hcidump.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0084 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0084 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0084 flags 0x0000 clen 4
    MTU 1024 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0084 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x84 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0084
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0084
> HCI Event: Number of Completed Packets(0x13) plen 5
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0085 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0085 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0085 flags 0x0000 clen 4
    MTU 1024 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0085 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672 
> HCI Event: Number of Completed Packets(0x13) plen 5
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x85 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x85 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 3
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x85 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x85 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 3
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 3
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x85 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 3
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x85 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x85 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0085 scid 0x0040
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 3
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0085 scid 0x0040
> HCI Event: Disconn Complete(0x05) plen 4
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0086
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0086 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0086 flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0086 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x1101 (SP)
          max 0x14
          cont 00 
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(d): cid 0x86 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          cur 0x0 tot 0x0
          cont 00 
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0086
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0086
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=rfcomm.conf
Content-Type: text/plain; name=rfcomm.conf; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

#
# Example:
#
rfcomm0 {
#	# Automatically bind the device at startup
	bind yes;
#
#	# Bluetooth address of the device
	device 00:0E:07:CA:15:AE;
#
#	# RFCOMM channel for the connection
	channel	1;
#
#	# Description of the connection
	comment "Example Bluetooth device";
}

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=bluepin
Content-Type: application/x-shellscript; name=bluepin
Content-Transfer-Encoding: 7bit

#!/bin/bash
echo "PIN:3497"

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=link_key
Content-Type: application/octet-stream; name=link_key
Content-Transfer-Encoding: base64

VXWkYBAArhXKBw4AC3lKHkqyDqKeMr85DerkOADNBAiviCFB

--=-+vkRabJfNX3b0thfrrLd
Content-Disposition: attachment; filename=pin
Content-Type: text/plain; name=pin; charset=UTF-8
Content-Transfer-Encoding: 7bit

3497

--=-+vkRabJfNX3b0thfrrLd--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
