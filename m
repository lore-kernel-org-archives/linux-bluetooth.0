Return-Path: <rolft@daimi.au.dk>
Message-ID: <40FE4BC9.3050509@daimi.au.dk>
Date: Wed, 21 Jul 2004 12:56:09 +0200
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk>	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>	 <1090345399.21683.2.camel@pegasus>  <40FE3ACF.4030608@daimi.au.dk> <1090404291.21683.81.camel@pegasus>
In-Reply-To: <1090404291.21683.81.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

>>>>>Try using 2.4.19-mh14 and show us the output of "hciconfig -a" on your
>>>>>Cerfcube. Is the Cerfcube a big endian machine?
>>>>
>>>>After compiling a new kernel and reflashing:
>>>
>>>does this kernel work?
>>
>>Yes (but I haven't tested much), although I get this error message when 
>>booting:
> 
> I meant, if the SDP browsing works with that kernel patch?

Uups, guess I'm not using my brain for thinking right know.

No the mh14 kernel patch does not fix the SDP browsing problem.

>>Calculating module dependencies... depmod: *** Unresolved symbols in 
>>/lib/modules/2.4.19-rmk6-pxa1-cerf1/kernel/drivers/bluetooth/bfusb.o
> 
> This can happen. You won't need the bfusb.o driver. Try a clean compile.

OK

>>A couple of months ago when I first tried to get sdp to work, I also 
>>randomly tried the mh13- and mh15-patches but with the same outcome as 
>>with the mh14- and mh17-patches.
> 
> So is the mh14 working for you or not? I don't get the correct point
> here.

Well I can understand that. When rereading my post I can see I have 
expressed myself rather vague.

I meant:
Two months ago I initially tried the mh17-patch (as this was the 
newest). SDP browsing did not work. I also tried the mh13- and 
mh15-patch but that did not help. SDP browsing still non-working. I then 
went on with other projects.

This time (this week) I decided to try again. Again using the mh17 
kernel patch, but now with the bluez-libs-2.8 and bluez-utils-2.8. Still 
SDP browsing is not working on the device.

>>>Please try another dongle with at least HCI 16.4 firmware.
>>
>>Sorry for being a little bit puzzled now. How do I see what the firmware 
>>version is for my current dongle? I translate the HCI Rev hex number to 
>>469 in decimal so should I just put the decimal point after the 4?
> 
> You can use "hciconfig hci0 revision" or look it up on my CSR page.

:-) (should have read the manual better)

The other dongle I have available has HCI 16.4 firmware. If it is of any 
help here's the output from "hcidump -x -t" from the laptop (browsing 
the Cerfcube using the HCI 16.4 firmware dongle). I'm still using the 
mh14 kernel patch.

[root@tux012 root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090406635.327140 < HCI Command: Disconnect (0x01|0x0006) plen 3
   29 00 13
1090406635.330194 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1090406635.351311 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 16
1090406641.710495 < HCI Command: Create Connection (0x01|0x0005) plen 13
   74 05 B1 76 0C 00 18 CC 00 00 00 00 01
1090406641.718445 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1090406642.741000 > HCI Event: Connect Complete (0x03) plen 11
   00 2A 00 74 05 B1 76 0C 00 01 00
1090406642.741449 < ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090406642.741498 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   2A 00 0F 00
1090406642.750211 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090406642.753669 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 2A 00
1090406642.758444 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   74 05 B1 76 0C 00 01
1090406642.768054 > HCI Event: Max Slots Change (0x1b) plen 3
   2A 00 05
1090406642.808248 > ACL data: handle 0x002a flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090406642.808678 < ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090406642.820222 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090406642.840205 > ACL data: handle 0x002a flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090406681.707145 < ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090406681.778420 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090406681.778443 > ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090406683.707143 < HCI Command: Disconnect (0x01|0x0006) plen 3
   2A 00 13
1090406683.709542 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1090406683.727697 > HCI Event: Disconn Complete (0x05) plen 4
   00 2A 00 16

and the output from the Cerfcube:

[root@xscale3 /root]# hcidump -x -t
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
1090407057.032402 > HCI Event: Connect Request (0x04) plen 10
   2A 20 00 94 0A 00 00 01 00 01
1090407057.033734 < HCI Command: Accept Connection Request (0x01|0x0009) 
plen 7
   2A 20 00 94 0A 00 01
1090407057.046380 > HCI Event: Command Status (0x0f) plen 4
   00 01 09 04
1090407057.066400 > HCI Event: Connect Complete (0x03) plen 11
   00 2A 00 2A 20 00 94 0A 00 01 00
1090407057.067605 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
   2A 00 0F 00
1090407057.070420 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
   2A 20 00 94 0A 00 01
1090407057.086372 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 2A 00
1090407057.087517 < HCI Command: Change Connection Packet Type 
(0x01|0x000f) plen 4
   2A 00 18 CC
1090407057.106368 > HCI Event: Max Slots Change (0x1b) plen 3
   2A 00 05
1090407057.110395 > HCI Event: Command Status (0x0f) plen 4
   00 01 0F 04
1090407057.114393 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   00 2A 00 18 CC
1090407057.119404 > ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
1090407057.120697 < ACL data: handle 0x002a flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1090407057.138384 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090407057.145395 > ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090407057.146610 < ACL data: handle 0x002a flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1090407057.146722 < ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1090407057.168377 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090407096.075987 > ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1090407096.076215 < ACL data: handle 0x002a flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1090407096.246939 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2A 00 01 00
1090407098.124586 > HCI Event: Disconn Complete (0x05) plen 4
   00 2A 00 13

Thanks again.

Rolf
