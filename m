Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42A71363.9050003@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------030907010507090706040207"
Subject: [Bluez-users] Protocol errors
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
Date: Wed, 08 Jun 2005 17:48:51 +0200

This is a multi-part message in MIME format.
--------------030907010507090706040207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all:

I am running an application on a computer that has many handheld devices 
withing range. Obviously, these devices all have bluetooth enabled and 
the communication is done using bluetooth protocols. From time to time I 
get some strange errors. I have run hcidump and I have attached the 
results. These are only fragments, as the application is running 
continuously.

    * In hcidump1.txt, there is a response to an SDP query. Everything
      goes well until "srv rec #5", when another SDP query is sent to
      (apparently) a different device. At this point, the communication
      aborts and the ERROR line is shown. Has anybody any idea why is
      this happening? Has anybody seen this before?
    * In hcidump2.txt, there is a line with "ERROR: Unknown PDU ID:
      0x4b". As I understand it, this means that a device has sent an
      illegal L2CAP message. If this is correct, then it means that the
      device has a broken bluetooth implementation. Another possibility
      would be that BlueZ does not handle all messages. Any ideas?

Thank you and regards,

Pedro

--------------030907010507090706040207
Content-Type: text/plain;
 name="hcidump1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump1.txt"

> ACL data: handle 0x0029 flags 0x01 dlen 164
    L2CAP(d): cid 0x0040 len 672 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x29b
          cnt 0x28e
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1111 (Fax) uuid-16 0x1204 (Telephony) >
            aid 0x0002 (SrvRecState)
               uint 0x6
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x1 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1111 (Fax) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "Fax"

          srv rec #1
            aid 0x0000 (SrvRecHndl)
               uint 0x10001
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
            aid 0x0002 (SrvRecState)
               uint 0x6
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x1 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1103 (DUN) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "Dial-up Networking"

          srv rec #2
            aid 0x0000 (SrvRecHndl)
               uint 0x10002
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1101 (SP) >
            aid 0x0002 (SrvRecState)
               uint 0x9
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x2 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0007 (SrvInfoTimeToLive)
               uint 0x4b0
            aid 0x0008 (SrvAvail)
               uint 0xff
            aid 0x0100 (SrvName)
               str "Bluetooth Serial Port"
            aid 0x0101 (SrvDesc)
               str "Bluetooth Serial Port"
            aid 0x0102 (ProviderName)
               str "Symbian Ltd."

          srv rec #3
            aid 0x0000 (SrvRecHndl)
               uint 0x10003
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1106 (OBEXObjTrnsf) >
            aid 0x0002 (SrvRecState)
               uint 0x6
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0xa > <
               uuid-16 0x0008 (OBEX) > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "OBEX File Transfer"

          srv rec #4
            aid 0x0000 (SrvRecHndl)
               uint 0x10004
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1105 (OBEXObjPush) >
            aid 0x0002 (SrvRecState)
               uint 0x7
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x9 > <
               uuid-16 0x0008 (OBEX) > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "OBEX Object Push"
            aid 0x0303 (SuppFormatsList)
               < uint 0xff >

          srv rec #5
            aid 0x0000 (SrvRecHndl)
               uint 0x10005
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x111f uuid-16 0x1203 (Audio) >
            aid 0x0002 (SrvRecState)
               uint 0x8
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x3 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x111e uint 0x101 > >
            aid 0x0100 (SrvName)
               str "Handsfre
"

          cont 
< ACL data: handle 0x0029 flags 0x02 dlen 34
    L2CAP(d): cid 0x0042 len 30 [psm 1]
        SDP SSA Req: tid 0x1 len 0x19
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 0A 00 00 02 8E 00 00 02 A8 00 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1d
          cnt 0x1a

ERROR: Unexpected syntax
          cont 41 75 64 69 6F 20 47 61 74 65 77 61 79 09 03 01 08 01 09 03 11 09 00 0F 00 

--------------030907010507090706040207
Content-Type: text/plain;
 name="hcidump2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump2.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
  9B CF 82 3E 04 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
< ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 0]
      4B 53 01 D3
< ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 0]
      03 53 01 FD
< ACL data: handle 0x002f flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0068 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2F 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2F 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2F 00 01 00
> HCI Event: Mode Change (0x14) plen 6
  00 2F 00 00 00 00
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 9B CF 82 3E 04 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> ACL data: handle 0x002f flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 1]
        ERROR: Unknown PDU ID: 0x4b
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00

--------------030907010507090706040207--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
