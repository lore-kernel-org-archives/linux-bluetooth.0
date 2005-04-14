Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Magnus Larsson <magnus.larsson@callista.se>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] RFCOMM Connect problem, need help to understand HCIDUMP output
References: <200504100032.15053.magnus.larsson@callista.se>
In-Reply-To: <200504100032.15053.magnus.larsson@callista.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504140608.19450.magnus.larsson@callista.se>
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
Date: Thu, 14 Apr 2005 06:08:19 +0200

Can someone help me to describe what the HCIDUMP in the end of this message 
says is wrong?

Does anyone have a URL to some doc that explain the HCIDUMP output?

I think the following part is of interest (see below for the full hcidump - 
output):

> ACL data: handle 0x002e flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 0x002e flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd

Regards,
Magnus.

On Sunday 10 April 2005 00:32, Magnus Larsson wrote:
> I have tried to get Internet access working from my Dell LATITUDE D800
> (Suse 9.2) via "Dial Up Networking" over Bluetooth and GPRS (Sony Ericsson
> S700i).
>
> I have basically followed the instructions in the article "Linux : Net
> Access with Bluetooth and GPRS" at
> http://www.pcquest.com/content/linux/2004/104050807.asp.
>
> I actually got it working once but now I can't get it up and running again.
> See error messages from the "wvdial GPRS" command below.
>
> File transfer over Bluetooth works "out of the box" in both directions so
> basic setup seems to be ok.
>
> I have tried to get a clue by reading old postings to this maillist but I
> seem to miss something.
>
> Below I have added configuration information as I understand is of
> importance.
>
> Please advice me on what to change to get it up and running again!
> Thanks in advance!
>
>
> linux:~ # sdptool search --bdaddr 00:0F:DE:0B:A0:F5 DUN
>
> Searching for DUN on 00:0F:DE:0B:A0:F5 ...
> Service Name: Dial-up Networking
> Service RecHandle: 0x10000
> Service Class ID List:
>   "Dialup Networking" (0x1103)
>   "Generic Networking" (0x1201)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Profile Descriptor List:
>   "Dialup Networking" (0x1103)
>     Version: 0x0100
>
>
> linux:~ # rfcomm bind 0 00:0F:DE:0B:A0:F5 1
>
>
> linux:~ # more /etc/wvdial.conf
>
> [Modem0]
> Modem = /dev/rfcomm0
> Baud = 57600
> SetVolume = 0
> Dial Command = ATDT
> Init1 = ATZ
> Init3 = ATM0
> FlowControl = None
> [Dialer GPRS]
> Username = user
> Password = user
> Phone = ATD*99#
> Stupid Mode = 1
> Inherits = Modem0
>
>
> linux:~ # wvdial GPRS
>
> --> WvDial: Internet dialer version 1.54.0
> --> Cannot open /dev/rfcomm0: Connection refused
> --> Cannot open /dev/rfcomm0: Connection refused
> --> Cannot open /dev/rfcomm0: Connection refused
>
>
> linux:~ # hcidump
> (from the failing "wvdial GPRS" command)
>
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
>
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Command Complete (0x0e) plen 6
> > HCI Event: Max Slots Change (0x1b) plen 3
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
> < ACL data: handle 0x002e flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 4
>     MTU 1024
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 18
>
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 674
>
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 674
> < ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0048 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x002e flags 0x02 dlen 18
>     L2CAP(d): cid 0x0048 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
>       frame_size 669 max_retrans 0 credits 7
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 19
>
>     L2CAP(d): cid 0x0040 len 15 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
>       frame_size 330 max_retrans 0 credits 7
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0048 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Link Key Request (0x17) plen 6
>
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>
> > HCI Event: Command Complete (0x0e) plen 10
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0048 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0041
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>
> > ACL data: handle 0x002e flags 0x02 dlen 12
>
>     L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
>
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 0 status 0
> < ACL data: handle 0x002e flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0049 flags 0x0000 clen 4
>     MTU 1024
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 18
>
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
>     MTU 674
>
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
>     MTU 674
> < ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0049 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0049 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x002e flags 0x02 dlen 18
>     L2CAP(d): cid 0x0049 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
>       frame_size 669 max_retrans 0 credits 7
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 19
>
>     L2CAP(d): cid 0x0041 len 15 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
>       frame_size 330 max_retrans 0 credits 7
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0049 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x0049 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0049 scid 0x0041
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 12
>
>     L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0041
>
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 0 status 0
> < ACL data: handle 0x002e flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x004a flags 0x0000 clen 4
>     MTU 1024
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 18
>
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 674
>
> > ACL data: handle 0x002e flags 0x02 dlen 16
>
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 674
> < ACL data: handle 0x002e flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x004a flags 0x0000 result 0 clen 0
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x004a len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x002e flags 0x02 dlen 18
>     L2CAP(d): cid 0x004a len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
>       frame_size 669 max_retrans 0 credits 7
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 19
>
>     L2CAP(d): cid 0x0040 len 15 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
>       frame_size 330 max_retrans 0 credits 7
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x004a len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> < ACL data: handle 0x002e flags 0x02 dlen 8
>     L2CAP(d): cid 0x004a len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
> < ACL data: handle 0x002e flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x004a scid 0x0040
>
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x002e flags 0x02 dlen 8
>
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>
> > ACL data: handle 0x002e flags 0x02 dlen 12
>
>     L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Disconn Complete (0x05) plen 4

-- 
Magnus Larsson
Callista Enterprise AB
Phone: +46 733 51 91 72
http://www.callista.se/Enterprise/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
