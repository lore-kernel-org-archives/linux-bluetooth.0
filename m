Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4CED942E.8080204@theforce.com.au>
References: <4CEB532F.1070804@theforce.com.au>
	<20101123175156.GA30860@eris.indt.org>
	<4CED942E.8080204@theforce.com.au>
Date: Wed, 24 Nov 2010 19:55:53 -0300
Message-ID: <AANLkTi=Yzpo-CuhgdOuD1T8ByAV=4sse93XZt55eo+b7@mail.gmail.com>
Subject: Re: sdptool hanging remote
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Grahame Jordan <gbj@theforce.com.au>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 24, 2010 at 7:39 PM, Grahame Jordan <gbj@theforce.com.au> wrote:
> Hi,
>
> I have tested 4.77 4.80 and git. All appear to have the same issue.
>
>
> 2000-01-02 07:35:12.360814 < ACL data: handle 256 flags 0x02 dlen 18
>    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
>      MTU 672
> 2000-01-02 07:35:12.360884 < ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> 2000-01-02 07:35:12.370559 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:12.380596 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:12.380628 > ACL data: handle 256 flags 0x02 dlen 18
>    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
>      MTU 672
> 2000-01-02 07:35:12.410670 > ACL data: handle 256 flags 0x02 dlen 23
>    L2CAP(d): cid 0x0041 len 19 [psm 1]
>        SDP SA Req: tid 0x0 len 0xe
>          handle 0x1001e
>          max 65535
>          aid(s) 0x0000 - 0xffff
>          cont 00
> 2000-01-02 07:35:12.412008 < ACL data: handle 256 flags 0x02 dlen 11
>    L2CAP(d): cid 0x0041 len 7 [psm 1]
>        SDP Error Rsp: tid 0x0 len 0x2
>          code 0x2 info none
> 2000-01-02 07:35:12.430720 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:12.430756 > ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> 2000-01-02 07:35:12.430979 < ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> 2000-01-02 07:35:12.440583 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:12.460651 > ACL data: ha
> # Hang here
>
> # Resumed after about 10 seconds
> ndle 256 flags 0x02 dlen 12
>    L2CAP(s): Connect req: psm 1 scid 0x0042
> 2000-01-02 07:35:12.460904 < ACL data: handle 256 flags 0x02 dlen 16
>    L2CAP(s)i2c: error: timeout

This ("i2c: error: timeout") looks strange. But could be unrelated.

Another thing that could be interesting to have is the hcidump of an
attempt using Ubuntu 8.04 (that you said that had no problems).

The output of "sdptool browse local", from the gumstix would be also useful.

> : Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
>      i2c: msg_num: 0 msg_idx: 1 msg_ptr: 0
> Connection successful
> 2000-01-02 07:35:12.480629 > HCI Event: Ni2c: ICR: 000097e0 ISR: 00000000
> umber of Completed Packets (0x13) plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:12.510724 > ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> 2000-01-02 07:35:12.510946 < ACL data: handle 256 flags 0x02 dlen 18
>    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
>      MTU 672
> ....
>
> 2000-01-02 07:35:34.220696 > ACL data: handle 256 flags 0x02 dlen 23
>    L2CAP(d): cid 0x0041 len 19 [psm 1]
>        SDP SA Req: tid 0x0 len 0xe
>          handle 0x1030a
>          max 65535
>          aid(s) 0x0000 - 0xffff
>          cont 00
> 2000-01-02 07:35:34.222038 < ACL data: handle 256 flags 0x02 dlen 11
>    L2CAP(d): cid 0x0041 len 7 [psm 1]
>        SDP Error Rsp: tid 0x0 len 0x2
>          code 0x2 info none
> 2000-01-02 07:35:34.250696 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:34.250733 > ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> 2000-01-02 07:35:34.250962 < ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> 2000-01-02
> # Hang here
>
> # Pressed CTL-C on remote "sdptool records 00:80:37:2F:5A:77"
> 07:35:34.260581 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 256 packets 1
> 2000-01-02 07:35:34.280679 > ACL data: handle 256 flags 0x02 dlen 12
>    L2CAP(s): Connect req: psm 1 scid 0x0042
> 2000-01-02 07:35:34.280930 < ACL data: handle 256 flags 0x02 dlen 16
>    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
>      Connection successful
> 2000-01-02 07:35:34.300522 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 256 packets 1
>
> ...
>
>
> Thanks
>
> Grahame Jordan
>
>
> On 24/11/10 04:51, Vinicius Costa Gomes wrote:
>>
>> On 16:37 Tue 23 Nov     , Grahame Jordan wrote:
>>
>>> Hi,
>>>
>>> I am using bluez-4.77 on a Gumstix Verdex kernel 2.4.32 patch 21
>>>
>>> When I run:
>>> sdptool records 00:80:37:2F:06:08"
>>> from the Workstation Ubuntu 10.04 Bluez-4.6? to the Gumstix the Gumstix
>>> hangs.
>>> It does not hang completely but is very busy. It hangs for about 20
>>> seconds and then releases for about 1 second
>>> before it locks up again.
>>>
>> I couldn't find anything that could solve this kind of problem in the logs
>> between 4.6 and the git head. But anyway, could you give a try to 4.80, or
>> better yet, the git head[1]? and see if the problem still happens?
>>
>>
>>> I have tried this on several different Gumstix with the same issue.
>>>
>>> Changing workstations from Ubuntu 10.04 to Ubuntu 8.04 does make a
>>> difference.
>>>  From Ubuntu 8.04 there seems to be no problem. blue-utils 3.26?
>>>
>>>
>> A really helpful piece of information that you could provide is the
>> hcidump[2]
>> logs of both cases, just be sure to give hcidump the options "-V" (verbose
>> output) and "-t" (timestamps, to see where the hang happens).
>>
>>
>>> Appreciate help
>>>
>>>
>>> Thanks
>>>
>>> Grahame Jordan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Cheers,
>>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius
