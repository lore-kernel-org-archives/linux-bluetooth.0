Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF418E7.9090900@theforce.com.au>
Date: Tue, 30 Nov 2010 08:19:35 +1100
From: Grahame Jordan <gbj@theforce.com.au>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: sdptool hanging remote
References: <4CEB532F.1070804@theforce.com.au>	<20101123175156.GA30860@eris.indt.org>	<4CED942E.8080204@theforce.com.au> <AANLkTi=Yzpo-CuhgdOuD1T8ByAV=4sse93XZt55eo+b7@mail.gmail.com>
In-Reply-To: <AANLkTi=Yzpo-CuhgdOuD1T8ByAV=4sse93XZt55eo+b7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 25/11/10 09:55, Vinicius Gomes wrote:
>>     handle 256 packets 1
>> 2000-01-02 07:35:12.430756>  ACL data: handle 256 flags 0x02 dlen 12
>>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
>> 2000-01-02 07:35:12.430979<  ACL data: handle 256 flags 0x02 dlen 12
>>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
>> 2000-01-02 07:35:12.440583>  HCI Event: Number of Completed Packets (0x13)
>> plen 5
>>     handle 256 packets 1
>> 2000-01-02 07:35:12.460651>  ACL data: ha
>> # Hang here
>>
>> # Resumed after about 10 seconds
>> ndle 256 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0042
>> 2000-01-02 07:35:12.460904<  ACL data: handle 256 flags 0x02 dlen 16
>>     L2CAP(s)i2c: error: timeout
>>
> This ("i2c: error: timeout") looks strange. But could be unrelated.

Mmmm? I have another problem that the whole thing locks up usually when 
BT disconnects.
There is a daemon that is using the I2C bus. When it is not running the 
lockup issue goes away?
Not sure if it is I2C causing the lockup or not. It just locks up 
silently and sometimes gets a dump from SOFT_LOCK.
Anyway weather the daemon is running or not we still get this ping of 
death from sdptool.

> Another thing that could be interesting to have is the hcidump of an
> attempt using Ubuntu 8.04 (that you said that had no problems).

Please see below

> The output of "sdptool browse local", from the gumstix would be also useful.

root@test:~# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Group Network Service
Service RecHandle: 0x10000
Service Class ID List:
    "PAN Group Network" (0x1117)
Protocol Descriptor List:
    "L2CAP" (0x0100)
      PSM: 15
    "BNEP" (0x000f)
      Version: 0x0100
Profile Descriptor List:
    "PAN Group Network" (0x1117)
      Version: 0x0100

Thanks
>> 2000-01-02 07:35:34.250696>  HCI Event: Number of Completed Packets (0x13)
>> plen 5
>>     handle 256 packets 1
>> 2000-01-02 07:35:34.250733>  ACL data: handle 256 flags 0x02 dlen 12
>>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
>> 2000-01-02 07:35:34.250962<  ACL data: handle 256 flags 0x02 dlen 12
>>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
>> 2000-01-02
>> # Hang here
>>
>> # Pressed CTL-C on remote "sdptool records 00:80:37:2F:5A:77"
>> 07:35:34.260581>  HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 256 packets 1
>> 2000-01-02 07:35:34.280679>  ACL data: handle 256 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0042
>> 2000-01-02 07:35:34.280930<  ACL data: handle 256 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
>>       Connection successful
>> 2000-01-02 07:35:34.300522>  HCI Event: Number of Completed Packets (0x13)
>> plen 5
>>     handle 256 packets 1
>>
>> ...
>>
>>
>> Thanks
>>
>> Grahame Jordan
>>
>>
>> On 24/11/10 04:51, Vinicius Costa Gomes wrote:
>>
>>> On 16:37 Tue 23 Nov     , Grahame Jordan wrote:
>>>
>>>
>>>> Hi,
>>>>
>>>> I am using bluez-4.77 on a Gumstix Verdex kernel 2.4.32 patch 21
>>>>
>>>> When I run:
>>>> sdptool records 00:80:37:2F:06:08"
>>>> from the Workstation Ubuntu 10.04 Bluez-4.6? to the Gumstix the Gumstix
>>>> hangs.
>>>> It does not hang completely but is very busy. It hangs for about 20
>>>> seconds and then releases for about 1 second
>>>> before it locks up again.
>>>>
>>>>
>>> I couldn't find anything that could solve this kind of problem in the logs
>>> between 4.6 and the git head. But anyway, could you give a try to 4.80, or
>>> better yet, the git head[1]? and see if the problem still happens?
>>>
>>>
>>>
>>>> I have tried this on several different Gumstix with the same issue.
>>>>
>>>> Changing workstations from Ubuntu 10.04 to Ubuntu 8.04 does make a
>>>> difference.
>>>>   From Ubuntu 8.04 there seems to be no problem. blue-utils 3.26?
>>>>
>>>>
>>>>
>>> A really helpful piece of information that you could provide is the
>>> hcidump[2]
>>> logs of both cases, just be sure to give hcidump the options "-V" (verbose
>>> output) and "-t" (timestamps, to see where the hang happens).
>>>
>>>
>>>
>>>> Appreciate help
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Grahame Jordan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> Cheers,
>>>
>>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Cheers,
>

# sdptool records from Ubuntu 8.04
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 229
     L2CAP(d): cid 0x0040 len 225 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
< ACL data: handle 256 flags 0x02 dlen 269
     L2CAP(d): cid 0x0040 len 265 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 4 status 0
       Connection refused - no resources available
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 229
     L2CAP(d): cid 0x0040 len 225 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 269
     L2CAP(d): cid 0x0040 len 265 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 4 status 0
       Connection refused - no resources available
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 229
     L2CAP(d): cid 0x0040 len 225 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 4 status 0
       Connection refused - no resources available
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 269
     L2CAP(d): cid 0x0040 len 265 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10000
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 98
     L2CAP(d): cid 0x0041 len 94 [psm 1]
         SDP SA Rsp: tid 0x0 len 0x59
           count 86
           aid 0x0000 (SrvRecHndl)
              uint 0x10000
           aid 0x0001 (SrvClassIDList)
              < uuid-16 0x1117 (GN) >
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) uint 0xf > <
              uuid-16 0x000f (BNEP) uint 0x100 > >
           aid 0x0005 (BrwGrpList)
              < uuid-16 0x1002 (PubBrwsGrp) >
           aid 0x0009 (BTProfileDescList)
              < < uuid-16 0x1117 (GN) uint 0x100 > >
           aid 0x0100 (SrvName)
              str "Group Network Service"
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10001
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10002
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
< ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 229
     L2CAP(d): cid 0x0040 len 225 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10003
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 269
     L2CAP(d): cid 0x0040 len 265 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10004
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10005
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10006
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10007
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10008
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10009
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000a
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000b
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000c
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000d
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo req: dlen 44
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 52
     L2CAP(s): Echo rsp: dlen 44
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000e
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
< ACL data: handle 256 flags 0x02 dlen 67
     L2CAP(d): cid 0x0040 len 63 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > ACL data: handle 256 flags 0x02 dlen 229
     L2CAP(d): cid 0x0040 len 225 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x1000f
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 256 flags 0x02 dlen 11
     L2CAP(d): cid 0x0042 len 7 [psm 1]
         SDP Error Rsp: tid 0x0 len 0x2
           code 0x2 info none
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
< ACL data: handle 256 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 256 flags 0x02 dlen 269
     L2CAP(d): cid 0x0040 len 265 [psm 0]
< ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 256 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 256 flags 0x02 dlen 59
     L2CAP(d): cid 0x0040 len 55 [psm 0]
 > ACL data: handle 256 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 256 flags 0x02 dlen 23
     L2CAP(d): cid 0x0041 len 19 [psm 1]
         SDP SA Req: tid 0x0 len 0xe
           handle 0x10010
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00


