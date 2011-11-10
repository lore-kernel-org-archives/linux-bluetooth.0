Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Nov 2011 10:03:53 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Szymon Janc <szymon.janc@tieto.com>,
    Gustavo Padovan <padovan@profusion.mobi>,
    "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
    "ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>,
    "kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add ability to force local busy condition
 on L2CAP ERTM
In-Reply-To: <1320850111.15441.342.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1111100957310.13134@mathewm-linux>
References: <1320332745-21750-1-git-send-email-szymon.janc@tieto.com>  <1320441040.15441.303.camel@aeonflux>  <alpine.DEB.2.02.1111041513330.11981@mathewm-linux>  <201111091446.28192.szymon.janc@tieto.com> <1320850111.15441.342.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 9 Nov 2011, Marcel Holtmann wrote:

> Hi Syzmon,
>
>>>>> NACK on this. I don't wanna move code with the specific purpose of pass a PTS
>>>>> test into the tree. This kinda of thing can survive outside of the tree.
>>>>
>>>> actually it can not life outside the tree. We need to be able to pass
>>>> the PTS test cases with an upstream source.
>>>>
>>>> However instead of hacking this in, what is the actual test case details
>>>> here that we need to have support for?
>>>
>>> ERTM will send an RNR when the socket receive buffer fills up.  For
>>> this test case, it works to just set the SO_RCVBUF sockopt to
>>> a small enough value that the recv buffer fills before the transmit
>>> window does - no kernel changes required.
>>
>> @Marcel
>> This test case is to "Verify the IUT will send an S-Frame [RNR] when it detects a Local Busy condition."
>>
>> "Pass verdict:
>> - ALT 1: The IUT immediately sends an S-Frame with function RNR after the Local
>> Busy condition is set by the Upper Tester.
>> - ALT 2: The IUT sends an S-Frame with function RNR after receiving I-Frame(s) from
>> the Tester when the Local Busy condition is set by the Upper Tester."
>>
>>
>> I was trying to pass ALT2 with Mat's suggestions but couldn't trigger local busy.
>> Minimum possible value for SO_RCVBUF (at least here on 3.0 kernel) is 2224 bytes and this is
>> still too high to allow PTS to trigger local busy (PTS tries to send txwin i-frames with 4 bytes of
>> data only).
>> [If it would possible to force PTS to send larger i-frames than it should work as well but I wasn't
>> able to find any option that would do that... please correct me if it is possible]
>>
>> With forcing local busy on channels it is possible to pass ALT1 scenario: PTS ask IUT to enter
>> local busy condition and just waits for RNR to be send.
>>
>> @Gustavo
>> If you prefer not to temper with normal code path I could just get rid of force_local_busy variable
>> and not hold channels in local busy state. This should be enough to pass test.
>
> so I like the idea to make this work with standard socket options. That
> is how we should be doing this. So lets figure out on how to make Mat's
> suggestion work for us.

Even with only 4 bytes of data, the buffer size limits also include 
sk_buff overhead of several hundred bytes per packet, so 2224 is small 
enough.  You also have to slow down (or stop) the reader of the data 
in userspace - otherwise, the reader pulls data out of the socket 
rcvbuf as soon as it arrives, and the buffer stays nearly empty.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
