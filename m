Return-Path: <rolft@daimi.au.dk>
Message-ID: <40FE3ACF.4030608@daimi.au.dk>
Date: Wed, 21 Jul 2004 11:43:43 +0200
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk>	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk> <1090345399.21683.2.camel@pegasus>
In-Reply-To: <1090345399.21683.2.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

>>>Try using 2.4.19-mh14 and show us the output of "hciconfig -a" on your
>>>Cerfcube. Is the Cerfcube a big endian machine?
>>
>>After compiling a new kernel and reflashing:
> 
> does this kernel work?

Yes (but I haven't tested much), although I get this error message when 
booting:

Calculating module dependencies... depmod: *** Unresolved symbols in 
/lib/modules/2.4.19-rmk6-pxa1-cerf1/kernel/drivers/bluetooth/bfusb.o

A couple of months ago when I first tried to get sdp to work, I also 
randomly tried the mh13- and mh15-patches but with the same outcome as 
with the mh14- and mh17-patches.

>>[root@xscale3 /root]# hciconfig -a
>>hci0:   Type: USB
>>         BD Address: 00:0A:94:00:20:2A ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:99 acl:0 sco:0 events:13 errors:0
>>         TX bytes:296 acl:0 sco:0 commands:12 errors:0
>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'xscale3'
>>         Class: 0x000100
>>         Service Classes: Unspecified
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1d3 LMP Ver: 1.1 (0x1) LMP 
>>Subver: 0x1d3
>>         Manufacturer: Cambridge Silicon Radio (10)
> 
> Please try another dongle with at least HCI 16.4 firmware.

Sorry for being a little bit puzzled now. How do I see what the firmware 
version is for my current dongle? I translate the HCI Rev hex number to 
469 in decimal so should I just put the decimal point after the 4?

At the moment I also have another USB dongle available and the output 
from "hciconfig hci0 version" is

[root@xscale3 /root]# hciconfig hci0 version
hci0:   Type: USB
         BD Address: 00:0C:76:B1:05:74 ACL MTU: 192:8  SCO MTU: 64:8
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

Which give HCI Rev number 525 in decimal. Are my dongles really that 
antique?

Final question. I'm curious about why I should try the mh14-patch? Do 
one experience subtle differences between the output from hciconfig?

>>With regards to endianess, good quiestion. After googling around I 
>>actually think it can be both. But I made a small program testing it and 
>>it said little endian.
> 
> Was only an idea. In general the BlueZ should now be endian safe, but
> you never know for sure ;)

Well that could definitely account for some very-hard-to-find bugs, so I 
hope that's not the case :-) Thanks for your help so far!

Regards, Rolf
