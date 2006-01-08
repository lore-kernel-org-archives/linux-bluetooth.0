Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jukka Laurila <jplauril@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] sdptool browse fails with ISSC dongle and Nokia 6630 in Ubuntu Breezy
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
Date: Sun, 8 Jan 2006 22:29:05 +0200 (EET)

When I do "sdptool browse 00:11:9F:C8:D9:36" (that's the 
address of my Nokia 6630) sdptool gives the error:

   Service Search failed: Connection timed out

The following error appears in syslog:

   sdptool: sdp_read_rsp: Client timed out

"hcidump -X -V" done during the "sdptool browse" says the 
following. There is a pause of about 20 seconds in the 
indicated place:

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:11:9F:C8:D9:36 ptype 0xcc18 rswitch 0x01 
clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 1 bdaddr 00:11:9F:C8:D9:36 type ACL 
encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 
4
     handle 1 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
     status 0x00 handle 1 ptype 0xcc18
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 1 
status 2
       Connection pending - Authorization pending
> ACL data: handle 1 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 0 
status 0
       Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0
> ACL data: handle 1 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1691
< ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 
clen 0
       Success
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 
clen 0
       Success
< ACL data: handle 1 flags 0x02 dlen 24
     L2CAP(d): cid 0x0053 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1002 (PubBrwsGrp)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 959
     L2CAP(d): cid 0x0040 len 955 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x3b6
           count 947
           record #0
               aid 0x0000 (SrvRecHndl)
                  uint 0x10000
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x1103 (DUN) >
               aid 0x0002 (SrvRecState)
                  uint 0x6
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x1103 (DUN) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Dial-Up Networking"
           record #1
               aid 0x0000 (SrvRecHndl)
                  uint 0x10001
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
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 
> >
               aid 0x0100 (SrvName)
                  str "OBEX Object Push"
               aid 0x0303 (SuppFormatsList)
                  < uint 0xff >
           record #2
               aid 0x0000 (SrvRecHndl)
                  uint 0x10002
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x111b (ImagingResp) >
               aid 0x0002 (SrvRecState)
                  uint 0xa
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xf > <
                  uuid-16 0x0008 (OBEX) > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x111a (Imaging) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Imaging"
               aid 0x0310 (unknown)
                  uint 0x1
               aid 0x0311 (unknown)
                  uint 0x1
               aid 0x0312 (unknown)
                  uint 0xb
               aid 0x0313 (unknown)
                  uint 0x400000400000000
           record #3
               aid 0x0000 (SrvRecHndl)
                  uint 0x10003
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x111f (Handsfree AG) uuid-16 
0x1203 (Audio) >
               aid 0x0002 (SrvRecState)
                  uint 0x8
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x2 > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x111f (Handsfree AG) uint 
0x101 > >
               aid 0x0100 (SrvName)
                  str "Hands-Free Audio Gateway"
               aid 0x0301 (SuppDataStoresList)
                  uint 0x1
               aid 0x0311 (unknown)
                  uint 0xf
           record #4
               aid 0x0000 (SrvRecHndl)
                  uint 0x10004
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x1112 (Headset AG) uuid-16 
0x1203 (Audio) >
               aid 0x0002 (SrvRecState)
                  uint 0x6
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x3 > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x1108 (Headset) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Headset Audio Gateway"
           record #5
               aid 0x0000 (SrvRecHndl)
                  uint 0x10005
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
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x1106 (OBEXObjTrnsf) uint 
0x100 > >
               aid 0x0100 (SrvName)
                  str "OBEX File Transfer"
           record #6
               aid 0x0000 (SrvRecHndl)
                  uint 0x10006
               aid 0x0001 (SrvClassIDList)
                  < uuid-128 
00000002-0000-1000-8000-0002ee000002 >
               aid 0x0002 (SrvRecState)
                  uint 0x6
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xb > <
                  uuid-16 0x0008 (OBEX) > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
       006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-128 
00000002-0000-1000-8000-0002ee000002 uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "SyncMLClient"
           record #7
               aid 0x0000 (SrvRecHndl)
                  uint 0x10007
               aid 0x0001 (SrvClassIDList)
                  < uuid-128 
00005005-0000-1000-8000-0002ee000001 >
               aid 0x0002 (SrvRecState)
                  uint 0x6
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xc > <
                  uuid-16 0x0008 (OBEX) > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0006 (LangBaseAttrIDList)
                  < uint 0x454e uint 0x6a uint 0x100 >
               aid 0x0009 (BTProfileDescList)
                  < < uuid-128 
00005005-0000-1000-8000-0002ee000001 uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Nokia OBEX PC Suite Services"
           cont 00
---NOTE: here's a 20 second pause---
< ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0053 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0053 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 1 reason 0x13
     Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 1 reason 0x16
     Reason: Connection Terminated by Local Host

If I try "sdptool browse 00:20:E0:76:C3:52" (that's an IBM 
T41 laptop running XP and WIDCOMM 1.4 drivers) right after 
plugging in the dongle it works just fine. If I try to 
browse the phone, then browsing the laptop for the first 
time after that fails with the error:

Failed to connect to SDP server on 00:20:E0:76:C3:52: 
Connection reset by peer

and this appears in syslog:

kernel: [4902823.224000] hci_acldata_packet: hci0 ACL 
packet 
for unknown connection handle 259

After that failure browsing the laptop works again.

System: Ubuntu 5.10 "Breezy Badger"
Kernel: 2.6.12-10-386
Bluez software versions are those from Ubuntu Breezy:
ii  bluez-cups                             2.20-0ubuntu3 
ii  bluez-hcidump                          1.23-0ubuntu1 
ii  bluez-pcmcia-support                   2.20-0ubuntu3 
ii  bluez-pin                              0.25-1ubuntu1 
ii  bluez-utils                            2.20-0ubuntu3

The USB dongle is a cheapo model branded "Prodigi". lsusb 
says:
Bus 001 Device 017: ID 1131:1001 Integrated System Solution 
Corp.

The phone is a Nokia 6630, firmware V4.03.36, 08-04-05. I 
have set the desktop machine as paired and authorized in the 
phone.

Any ideas on what might be wrong? Do you need more 
information?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
