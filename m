Return-Path: <rolft@daimi.au.dk>
Message-ID: <40FE61F2.3080407@daimi.au.dk>
Date: Wed, 21 Jul 2004 14:30:42 +0200
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk>	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>	 <1090345399.21683.2.camel@pegasus>  <40FE3ACF.4030608@daimi.au.dk>	 <1090404291.21683.81.camel@pegasus>  <40FE4BC9.3050509@daimi.au.dk> <1090412310.21683.87.camel@pegasus>
In-Reply-To: <1090412310.21683.87.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

>>The other dongle I have available has HCI 16.4 firmware. If it is of any 
>>help here's the output from "hcidump -x -t" from the laptop (browsing 
>>the Cerfcube using the HCI 16.4 firmware dongle). I'm still using the 
>>mh14 kernel patch.
> 
> and it is still the same problem. One side sends the config request, but
> the other don't receives it. Try to browse from the Cerfcube a service
> on your laptop's SDP database.

Cerfcube searching for SP on laptop.

[root@xscale3 /root]# sdptool search --bdaddr 00:0A:94:00:20:2A SP
Searching for SP on 00:0A:94:00:20:2A ...
Service Search failed: Connection timed out

[root@xscale3 /root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090413342.564243 < HCI Command: Create Connection (0x01|0x0005) plen 13
   2A 20 00 94 0A 00 18 CC 02 00 00 00 01
1090413342.574362 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1090413345.877738 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 2A 20 00 94 0A 00 01 00
1090413345.878922 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090413345.879079 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1090413345.885720 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090413345.889737 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1090413345.897742 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   2A 20 00 94 0A 00 01
1090413345.905741 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1090413345.944735 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090413345.945942 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090413345.953719 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090413345.973735 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090413345.975736 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090413345.975970 < ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090413345.977202 < ACL data: handle 0x0029 flags 0x02 dlen 24
     L2CAP(d): cid 0x40 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1101 (SP)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 00
1090413345.983741 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090413365.970806 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090413365.987893 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090413366.010892 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090413368.008993 < HCI Command: Disconnect (0x01|0x0006) plen 3
   29 00 13
1090413368.015481 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1090413368.039499 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 16
	

Laptop's hcidump:

[root@tux012 root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090412930.648961 > HCI Event: Connect Request (0x04) plen 10
   74 05 B1 76 0C 00 00 01 00 01
1090412930.657137 < HCI Command: Accept Connection Request (0x01|0x0009) 
plen 7
   74 05 B1 76 0C 00 01
1090412930.670802 > HCI Event: Command Status (0x0f) plen 4
   00 01 09 04
1090412930.688229 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 74 05 B1 76 0C 00 01 00
1090412930.688562 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   29 00 0F 00
1090412930.689859 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   74 05 B1 76 0C 00 01
1090412930.714781 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
1090412930.715032 < HCI Command: Change Connection Packet Type 
(0x01|0x000f) plen 4
   29 00 18 CC
1090412930.732785 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
1090412930.733440 > HCI Event: Command Status (0x0f) plen 4
   00 01 0F 04
1090412930.737560 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   00 29 00 18 CC
1090412930.757320 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090412930.757744 < ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090412930.769604 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090412930.776498 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090412930.776791 < ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090412930.776816 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090412930.800513 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090412930.802459 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090412930.806407 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090412950.810971 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090412950.811536 < ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090412950.857907 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
1090412952.930571 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 13


I'm going away for an extended weekend right now, so I won't be back to 
continue this thread until Monday next week.

Regards

Rolf
