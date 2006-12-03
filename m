Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061130141202.GA6381@163.com>
References: <20061130141202.GA6381@163.com>
Date: Sun, 03 Dec 2006 14:44:30 +0100
Message-Id: <1165153470.19590.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez RFCOMM connect fail on arm platform
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

Hi,

> I'm working on a project on arm platform (Cirrus EP9312 Board, Arm9)
> which utilized bluez. And I now encountered a problem: the rfcomm
> connection can't be established. Only occasionally can the rfcomm
> connection be established. I'm using a USB dongle with Broadcom
> bluetooth chip inside of hci version 2.0. This dongle works well on
> my Laptop with linux-iamge-2.6.18. So I don't think the problem lies
> in the bluetooth dongle.
> 
> My embeded arm platform runs the kernel 2.6.8-1 patched with patch
> from www.cirrus.com. But I don't think the patch file does anything
> related to bluetooth.

first of all. The 2.6.8 kernel is ancient and you should switch to a
2.6.19 and make Cirrus provide their patch for it. Not following the
upstream kernel releases is a bad behavior of embedded system providers
and they should be punished for that by not buying their systems.

> Is there any way to use the lastest bluetooth kernel source on a arm
> platform with kernel 2.6.8-1 ?
> 
> The typical output of hcidump is as following:
> 
> 	~ # hcidump -x -V
> 	HCI sniffer - Bluetooth packet analyzer ver 1.30
> 	device: hci0 snap_len: 1028 filter: 0xffffffff
> 	< HCI Command: Create Connection (0x01|0x0005) plen 13
> 	    bdaddr 00:17:B0:B1:B2:CC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> 	    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> 	> HCI Event: Command Status (0x0f) plen 4
> 	    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> 	> HCI Event: Connect Complete (0x03) plen 11
> 	    status 0x00 handle 12 bdaddr 00:17:B0:B1:B2:CC type ACL encrypt 0x00
> 	< ACL data: handle 12 flags 0x02 dlen 12
> 	    L2CAP(s): Connect req: psm 3 scid 0x0040
> 	> HCI Event: Max Slots Change (0x1b) plen 3
> 	    handle 12 slots 5
> 	> ACL data: handle 12 flags 0x02 dlen 16
> 	    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> 	      Connection successful
> 	< ACL data: handle 12 flags 0x02 dlen 16
> 	    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> 	      MTU 1024
> 	> ACL data: handle 12 flags 0x02 dlen 16
> 	    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> 	      MTU 32772
> 	< ACL data: handle 12 flags 0x02 dlen 14
> 	    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> 	      Success
> 	> ACL data: handle 12 flags 0x02 dlen 17
> 	> ACL data: handle 12 flags 0x01 dlen 1
> 	    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
> 	      Success
> 	      MTU 1024
> 	< ACL data: handle 12 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x0040 len 4 [psm 3]
> 	      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> 	> HCI Event: Number of Completed Packets (0x13) plen 5
> 	    handle 12 packets 4
> 	> ACL data: handle 12 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x0040 len 4 [psm 3]
> 	      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> 	< ACL data: handle 12 flags 0x02 dlen 18
> 	    L2CAP(d): cid 0x0040 len 14 [psm 3]
> 	      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
> 	      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
> 	      frame_size 1019 max_retrans 0 credits 7
> 	> ACL data: handle 12 flags 0x02 dlen 18
> 	    L2CAP(d): cid 0x0040 len 14 [psm 3]
> 	      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
> 	      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
> 	      frame_size 1019 max_retrans 0 credits 0
> 	< ACL data: handle 12 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x0040 len 4 [psm 3]
> 	      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
> 	> HCI Event: Number of Completed Packets (0x13) plen 5
> 	    handle 12 packets 2
> 	
> 	
> 	
> 	/* it takes seconds here outputing nothing */
> 	
> 	
> 	
> 	
> 	< ACL data: handle 12 flags 0x02 dlen 8
> 	    L2CAP(d): cid 0x0040 len 4 [psm 3]
> 	      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3

I am sorry, but that is not BlueZ fault. You are connection to RFCOMM
channel 9 and the other side doesn't answer. We can only terminate the
connection attempt after a timeout.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
