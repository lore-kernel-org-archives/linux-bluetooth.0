Return-Path: <rolft@daimi.au.dk>
Message-ID: <40FD5217.3060705@daimi.au.dk>
Date: Tue, 20 Jul 2004 19:10:47 +0200
From: "Rolf E. Thorup" <rolft@daimi.au.dk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
References: <40FC2322.4060204@daimi.au.dk>	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk> <1090334863.4400.124.camel@pegasus>
In-Reply-To: <1090334863.4400.124.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

[SNIP, some "hcidump -t -x" output]

>>
>>and here's the output from the Cerfcube:
>>
>>HCIDump - HCI packet analyzer ver 1.9
>>device: hci0 snap_len: 1028 filter: 0xffffffff
>>1090319478.496750 > HCI Event: Connect Request (0x04) plen 10
>>   74 05 B1 76 0C 00 00 01 00 01
>>1090319478.497886 < HCI Command: Accept Connection Request (0x01|0x0009) 
>>plen 7
>>   74 05 B1 76 0C 00 01
>>1090319478.512733 > HCI Event: Command Status (0x0f) plen 4
>>   00 01 09 04
>>1090319478.546741 > HCI Event: Connect Complete (0x03) plen 11
>>   00 29 00 74 05 B1 76 0C 00 01 00
>>1090319478.547821 < HCI Command: Write Link Policy Settings 
>>(0x02|0x000d) plen 4
>>   29 00 0F 00
>>1090319478.550769 > HCI Event: Page Scan Repetition Mode Change (0x20) 
>>plen 7
>>   74 05 B1 76 0C 00 01
>>1090319478.564746 > HCI Event: Command Complete (0x0e) plen 6
>>   01 0D 08 00 29 00
>>1090319478.565797 < HCI Command: Change Connection Packet Type 
>>(0x01|0x000f) plen 4
>>   29 00 18 CC
>>1090319478.584718 > HCI Event: Max Slots Change (0x1b) plen 3
>>   29 00 05
>>1090319478.588740 > HCI Event: Command Status (0x0f) plen 4
>>   00 01 0F 04
>>1090319478.592739 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>>   00 29 00 18 CC
>>1090319478.602746 > ACL data: handle 0x0029 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0040
>>1090319478.604041 < ACL data: handle 0x0029 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>>1090319478.612733 > HCI Event: Number of Completed Packets (0x13) plen 5
>>   01 29 00 01 00
>>1090319478.618741 > ACL data: handle 0x0029 flags 0x02 dlen 12
>>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
>>1090319478.619937 < ACL data: handle 0x0029 flags 0x02 dlen 14
>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>>1090319478.620053 < ACL data: handle 0x0029 flags 0x02 dlen 12
>>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> 
> 
> the problem is that this "Config req" request never reaches the other
> side. And because of that the laptop sides sends a "Disonn req" after
> some time.
> 
> 
>>1090319478.642724 > HCI Event: Number of Completed Packets (0x13) plen 5
>>   01 29 00 01 00
>>1090319517.746003 > ACL data: handle 0x0029 flags 0x02 dlen 12
>>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>>1090319517.746236 < ACL data: handle 0x0029 flags 0x02 dlen 12
>>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
>>1090319517.768987 > HCI Event: Number of Completed Packets (0x13) plen 5
>>   01 29 00 01 00
>>1090319519.848575 > HCI Event: Disconn Complete (0x05) plen 4
>>   00 29 00 13
> 
> 
> Try using 2.4.19-mh14 and show us the output of "hciconfig -a" on your
> Cerfcube. Is the Cerfcube a big endian machine?

After compiling a new kernel and reflashing:

[root@xscale3 /root]# hciconfig -a
hci0:   Type: USB
         BD Address: 00:0A:94:00:20:2A ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:99 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'xscale3'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x1d3 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x1d3
         Manufacturer: Cambridge Silicon Radio (10)

With regards to endianess, good quiestion. After googling around I 
actually think it can be both. But I made a small program testing it and 
it said little endian.

Regards, Rolf
