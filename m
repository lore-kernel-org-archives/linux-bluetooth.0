Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4107B29E.3030909@daimi.au.dk>
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk>	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>	 <1090345399.21683.2.camel@pegasus>  <40FE3ACF.4030608@daimi.au.dk>	 <1090404291.21683.81.camel@pegasus>  <40FE4BC9.3050509@daimi.au.dk> <1090412310.21683.87.camel@pegasus> <40FE61F2.3080407@daimi.au.dk>
In-Reply-To: <40FE61F2.3080407@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 28 Jul 2004 16:05:18 +0200

Hi again

>>> The other dongle I have available has HCI 16.4 firmware. If it is of 
>>> any help here's the output from "hcidump -x -t" from the laptop 
>>> (browsing the Cerfcube using the HCI 16.4 firmware dongle). I'm still 
>>> using the mh14 kernel patch.
>>
>> and it is still the same problem. One side sends the config request, but
>> the other don't receives it. Try to browse from the Cerfcube a service
>> on your laptop's SDP database.

Just tried on more time, and I was able to discover the SP service of 
the laptop.

Dumps:

[root@xscale3 /root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1091019423.563293 < HCI Command: Create Connection (0x01|0x0005) plen 13
   2A 20 00 94 0A 00 18 CC 02 00 00 00 01
1091019423.571986 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1091019426.567410 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 2A 20 00 94 0A 00 01 00
1091019426.568601 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1091019426.568732 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1091019426.575391 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019426.581389 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1091019426.587410 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   2A 20 00 94 0A 00 01
1091019426.601407 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1091019426.663399 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1091019426.664413 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1091019426.671392 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019426.691400 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1091019426.693398 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1091019426.693619 < ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1091019426.697110 < ACL data: handle 0x0029 flags 0x02 dlen 24
     L2CAP(d): cid 0x40 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1101 (SP)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 00
1091019426.701415 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019426.705386 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019426.723394 > ACL data: handle 0x0029 flags 0x02 dlen 86
     L2CAP(d): cid 0x40 len 82 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x4d
           cnt 0x4a
           srv rec #0
             aid 0x0000 (SrvRecHndl)
                uint 0x804d170
             aid 0x0001 (SrvClassIDList)
                < uuid-16 0x1101 (SP) >
             aid 0x0004 (ProtocolDescList)
                < < uuid-16 0x0100 (L2CAP) > <
                uuid-16 0x0003 (RFCOMM) uint 0x4 > >
             aid 0x0005 (BrwGrpList)
                < uuid-16 0x1002 (PubBrwsGrp) >
             aid 0x0009 (BTProfileDescList)
                < < uuid-16 0x1101 (SP) uint 0x100 > >
             aid 0x0100 (SrvName)
                str "Serial Port"

           cont 00
1091019426.745942 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1091019426.753392 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019426.773376 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1091019428.764390 < HCI Command: Disconnect (0x01|0x0006) plen 3
   29 00 13
1091019428.772949 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1091019428.788976 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 16


Laptop dump:

[root@tux012 root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1091019016.391632 > HCI Event: Connect Request (0x04) plen 10
   74 05 B1 76 0C 00 00 01 00 01
1091019016.392644 < HCI Command: Accept Connection Request (0x01|0x0009) 
plen 7
   74 05 B1 76 0C 00 01
1091019016.404625 > HCI Event: Command Status (0x0f) plen 4
   00 01 09 04
1091019016.428621 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 74 05 B1 76 0C 00 01 00
1091019016.429633 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1091019016.430618 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   74 05 B1 76 0C 00 01
1091019016.446617 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1091019016.447345 < HCI Command: Change Connection Packet Type 
(0x01|0x000f) plen 4
   29 00 18 CC
1091019016.462620 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1091019016.464614 > HCI Event: Command Status (0x0f) plen 4
   00 01 0F 04
1091019016.466613 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   00 29 00 18 CC
1091019016.487620 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1091019016.497351 < ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1091019016.520608 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019016.526610 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1091019016.527354 < ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1091019016.527391 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1091019016.549602 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019016.552596 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019016.556599 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1091019016.558596 > ACL data: handle 0x0029 flags 0x02 dlen 24
     L2CAP(d): cid 0x40 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1101 (SP)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 00
1091019016.560314 < ACL data: handle 0x0029 flags 0x02 dlen 86
     L2CAP(d): cid 0x40 len 82 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x4d
           cnt 0x4a
           srv rec #0
             aid 0x0000 (SrvRecHndl)
                uint 0x804d170
             aid 0x0001 (SrvClassIDList)
                < uuid-16 0x1101 (SP) >
             aid 0x0004 (ProtocolDescList)
                < < uuid-16 0x0100 (L2CAP) > <
                uuid-16 0x0003 (RFCOMM) uint 0x4 > >
             aid 0x0005 (BrwGrpList)
                < uuid-16 0x1002 (PubBrwsGrp) >
             aid 0x0009 (BTProfileDescList)
                < < uuid-16 0x1101 (SP) uint 0x100 > >
             aid 0x0100 (SrvName)
                str "Serial Port"

           cont 00
1091019016.582596 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019016.607599 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1091019016.607863 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1091019016.630588 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1091019018.714208 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 13

I have tried a couple of more times from the Cerfcube to search for SP 
on the laptop and also on my Sony Ericsson T610. Approx. 4 out of 5 
times the search will succeed and otherwise I'll get the error message:

"Service Search failed: Connection timed out".

Searching for SP on the Cerfcube from the laptop does (still) not work.

Regards, Rolf


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
