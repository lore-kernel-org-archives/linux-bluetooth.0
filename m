Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050331050155.47957.qmail@web8503.mail.in.yahoo.com>
From: mahabaleshwara k <mahabaleshwara_k@yahoo.co.in>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] file transfer from phone to PC
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
Date: Thu, 31 Mar 2005 06:01:55 +0100 (BST)

Mac address of phone(using hcitool scan) and channel
numbers(8 and 9) for OBEX PUSH and file transfer
respectively(using sdptool browse) were foundout. 

When using obexftp for getting files from cell
phone(put is successful, get/list fails):
[root@localhost root]# obexftp -b 00:0A:28:3E:52:B5 -B
9 -p testimgp.jpg
No custom transport
Connecting...bt: 1
done
Sending testimgp.jpg...\done
Disconnecting...done
[root@localhost root]# obexftp -b 00:0A:28:3E:52:B5 -B
9 -g testimgp.jpg
No custom transport
Connecting...bt: 1
done
Receiving testimgp.jpg... failed: testimgp.jpg
Disconnecting...done
(on cell phone it displays "operation no allowed
....cancelling". I could not find any permissions
settings on cell)
[root@localhost root]# obexftp -b 00:0A:28:3E:52:B5 -B
9 -l
No custom transport
Connecting...bt: 1
done
Disconnecting...done
(on cell phone it displays "
Failed...Disconnecting..")

When trying sending from cell phone to linux box:
on cell it gives "Could not connect"
hcidump log:HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  B5 52 3E 28 0A 00 04 22 52 01
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  B5 52 3E 28 0A 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  00 03 00 B5 52 3E 28 0A 00 01 00
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
  03 00 0F 00
> HCI Event: Max Slots Change (0x1b) plen 3
  03 00 05
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 03 00
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
  03 00 18 CC
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
  00 03 00 18 CC
> ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0003 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000
clen 4
    MTU 1024
< ACL data: handle 0x0003 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000
result 0 clen 0
< ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000
clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000
result 0 clen 0
> ACL data: handle 0x0003 flags 0x02 dlen 34
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x1 len 0x19
          pat uuid-16 0x1105 (OBEXObjPush)
          max 0x80
          aid(s) 0x0000 (SrvRecHndl) 0x0001
(SrvClassIDList) 0x0002 (SrvRecState) 0x0006
(LangBaseAttrIDList) 0x0009 (BTProfileDescList)
          cont 00
< ACL data: handle 0x0003 flags 0x02 dlen 45
    L2CAP(d): cid 0x0040 len 41 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x24
          cnt 0x21
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x804eba8
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1105 (OBEXObjPush) >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1105 (OBEXObjPush) uint
0x100 > >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x3 len 0xc
          hndl 0x804eba8
          max 0x80
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0003 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x1b
          cnt 0x18
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > <
             uuid-16 0x0008 (OBEX) > >

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 0x0003 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041
result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000
clen 4
    MTU 2053
< ACL data: handle 0x0003 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000
result 0 clen 0
< ACL data: handle 0x0003 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000
clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000
result 0 clen 4
    MTU 1024
> ACL data: handle 0x0003 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x1c
< ACL data: handle 0x0003 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 18
  L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 0
ack_timer 0
      frame_size 667 max_retrans 0 credits 0
< ACL data: handle 0x0003 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0003 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 03 00 01 00
> HCI Event: Disconn Complete (0x05) plen 4
  00 03 00 13 


>what have you done? what"s the error message? which
part >failed?

> Hi all,
> I am trying for file transfer between PC and
MOTOROLA
> mobile-E398 over bluetooth.I am having linux-2.4.20
> kernel with blueZ libs, utilis,openobex and obexftp
> compiled. I am able to transfer(put) images from PC
to
> mobile using obexftp but NOT FROM MOBILE TO PC. Can
> any one suggest me solution or where I went wrong?


________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
