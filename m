Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Eduardo Moreno A <emoreno@dim.uchile.cl>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_acldata_packet error in a Palm connection.
In-Reply-To: <20040610130139.GA7833@gmx.net>
Message-ID: <Pine.LNX.4.60.0406101556500.10156@cain.borelian.dns2go.com>
References: <40C85761.4060201@dim.uchile.cl> <20040610130139.GA7833@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Thu, 10 Jun 2004 16:01:39 +0200 (CEST)

First of all, thanks for this help.

> Post a hcidump of the connection, while this appears. You are not so
> clear about, how dund behaves. Does it exit? What does it show if you
> don't detach the daemon.
Here it goes:

> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5

# In this step, it's stay 1-2 minutes...
# then, the connection fails at the palm.
# and this is the hcidump continuation

> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 17
     L2CAP(d): cid 0x40 len 13 [psm 1]
         SDP SS Req: tid 0x0 len 0x8
           pat uuid-16 0x1103 (DUN)
           max 0x1
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(d): cid 0x40 len 10 [psm 1]
         SDP SS Rsp: tid 0x0 len 0x5
           tot 0x0 cur 0x0
           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 21
     L2CAP(d): cid 0x40 len 17 [psm 1]
         SDP SA Req: tid 0x1 len 0xc
           hndl 0x0
           max 0xffff
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 30
     L2CAP(d): cid 0x40 len 26 [psm 1]
         SDP SA Rsp: tid 0x1 len 0x15
           cnt 0x12
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) uint 0x1 uint 0x1 > >

           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 21
     L2CAP(d): cid 0x40 len 17 [psm 1]
         SDP SA Req: tid 0x2 len 0xc
           hndl 0x0
           max 0xffff
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 30
     L2CAP(d): cid 0x40 len 26 [psm 1]
         SDP SA Rsp: tid 0x2 len 0x15
           cnt 0x12
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) uint 0x1 uint 0x1 > >

           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 17
     L2CAP(d): cid 0x40 len 13 [psm 1]
         SDP SS Req: tid 0x3 len 0x8
           pat uuid-16 0x1101 (SP)
           max 0x1
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(d): cid 0x40 len 10 [psm 1]
         SDP SS Rsp: tid 0x3 len 0x5
           tot 0x0 cur 0x0
           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 21
     L2CAP(d): cid 0x40 len 17 [psm 1]
         SDP SA Req: tid 0x4 len 0xc
           hndl 0x0
           max 0xffff
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 30
     L2CAP(d): cid 0x40 len 26 [psm 1]
         SDP SA Rsp: tid 0x4 len 0x15
           cnt 0x12
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) uint 0x1 uint 0x1 > >

           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 21
     L2CAP(d): cid 0x40 len 17 [psm 1]
         SDP SA Req: tid 0x5 len 0xc
           hndl 0x0
           max 0xffff
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 30
     L2CAP(d): cid 0x40 len 26 [psm 1]
         SDP SA Rsp: tid 0x5 len 0x15
           cnt 0x12
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) uint 0x1 uint 0x1 > >

           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Disconn Complete(0x05) plen 4



THANKS!



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
