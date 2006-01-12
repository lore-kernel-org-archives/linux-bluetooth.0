Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <37f261b0601120320n516e7466ld95aa0b2d1ac9f83@mail.gmail.com>
From: Hugo van der Merwe <hugovdm@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <37f261b0601090736w6d7157d6x6ea876ecafb3572e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_72237_26983724.1137064823206"
References: <37f261b0601090736w6d7157d6x6ea876ecafb3572e@mail.gmail.com>
Subject: [Bluez-users] Re: Two "identical" laptops, same phone, one works, one doesn't
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
Date: Thu, 12 Jan 2006 13:20:23 +0200

------=_Part_72237_26983724.1137064823206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/9/06, Hugo van der Merwe <hugovdm@gmail.com> wrote:
> This is driving me nuts. I have two Compaq nx6110 laptops here, I've got =
one
> working fine, the other isn't working. I try:
>
>  rfcomm connect 0 00:12:47:1E:90:AE 3
>
>  For the one it works great, the other I get
>
>  Can't connect RFCOMM socket: Connection refused

Attached is the output from "hcidump -V -X" for both machines. Oh,
btw, I can copy files to/from both, iirc. (Uh, should I have gzipped
them?)

Any tips or more ways to help debugging this would be more than welcome. Th=
anks!

Hugo

------=_Part_72237_26983724.1137064823206
Content-Type: application/octet-stream; name=bluetooth.fail
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bluetooth.fail"

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:47:1E:90:AE ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:12:47:1E:90:AE type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 336 
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 336 
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 331 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:12:47:1E:90:AE
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:12:47:1E:90:AE key 78720B178478C64A5110C0A3654ED0F1
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:12:47:1E:90:AE
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xf9 
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x16
    Reason: Connection Terminated by Local Host

------=_Part_72237_26983724.1137064823206
Content-Type: application/octet-stream; name=bluetooth.work
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bluetooth.work"

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:47:1E:90:AE ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:12:47:1E:90:AE type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 336 
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 336 
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 331 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:12:47:1E:90:AE
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:12:47:1E:90:AE key 711910DC7331EA86005D2FB81E8812DE
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:12:47:1E:90:AE
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x01
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18 
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 11
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x00
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:12:47:1E:90:AE role 0x01
    Role: Slave
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 6 encrypt 0x01
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 11
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 11
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 11
< ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18 
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 3
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x13
    Reason: Remote User Terminated Connection

------=_Part_72237_26983724.1137064823206--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
