Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Moritz Bunkus <moritz@bunkus.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040528201025.GA7737@bunkus.org>
References: <20040528154111.GD24083@bunkus.org>
	 <1085766449.3321.50.camel@pegasus> <20040528180635.GA20450@bunkus.org>
	 <1085770308.4516.3.camel@pegasus>  <20040528201025.GA7737@bunkus.org>
Content-Type: text/plain
Message-Id: <1085776595.4516.24.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 28 May 2004 22:36:35 +0200

Hi Moritz,

> > However I don't see any data communication on the RFCOMM channel and
> > that indicates that something is going wrong here. Please checkout the
> > CVS repository obex and try the btobex tool from there.
> 
> Ok, I've downloaded the CVS from openobex and bluez' obex module. At
> first 'btobex push ...' did not work at all because it does not parse
> the channel number and always uses 0. The mobile did turn off the
> screensaver (so it did receive something), but the question 'receive
> obex file transfer' did not appear.
> 
> After modifying main.c and changing the channel number for the push
> request to 9 I've got the same behaviour as before with the obextool
> app. I've attached the binary dump.

forget this, because I overlooked something in the hcidump. You will
never be able to transfer any data from or to your phone, because the
RFCOMM implementation of your phone is buggy.

	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
	> HCI Event: Number of Completed Packets(0x13) plen 5
	  01 29 00 01 00 
	> ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 

Establishing the control channel. Got an UA. Ok.

	< ACL data: handle 0x0029 flags 0x02 dlen 18
	    L2CAP(d): cid 0x40 len 14 [psm 3]
	      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
	      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 1019 max_retrans 0 credits 7
	> HCI Event: Number of Completed Packets(0x13) plen 5
	  01 29 00 01 00 
	> ACL data: handle 0x0029 flags 0x02 dlen 18
	    L2CAP(d): cid 0x40 len 14 [psm 3]
	      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
	      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 1019 max_retrans 0 credits 0

Parameter negotiation for channel 0. Ok.

	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32 
	> HCI Event: Number of Completed Packets(0x13) plen 5
	  01 29 00 01 00 
	> HCI Event: Link Key Request(0x17) plen 6
	  93 C1 BB 28 0A 00 
	< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
	  93 C1 BB 28 0A 00 7F 15 FC 68 8C A1 8F AA AB 68 67 9F 4D A2 
	  6C AF 
	> HCI Event: Command Complete(0x0e) plen 10
	  01 0B 04 00 93 C1 BB 28 0A 00 
	> HCI Event: Encrypt Change(0x08) plen 4
	  00 29 00 01 

Request channel 9. You need to authorize, which is also ok, but there is
no UA after it.

	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3 
	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 

Now we ran into the connect timeout and our RFCOMM disconnects. We miss
an UA here and this is why you can't transfer any data over RFCOMM.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
