Return-Path: <cyrus@holtmann.org>
Message-ID: <4F482C0F.8000305@codeaurora.org>
Date: Fri, 24 Feb 2012 16:32:15 -0800
From: Mat Martineau <mathewm@codeaurora.org>
MIME-Version: 1.0
To: Ulisses Furquim <ulisses@profusion.mobi>
CC: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org> <1330029469-8565-2-git-send-email-mathewm@codeaurora.org> <CAA37ikZRndo-Sk5r5Dfv64rB9ehdCJLVzYGuGfOCy+VmLX4c7Q@mail.gmail.com>
In-Reply-To: <CAA37ikZRndo-Sk5r5Dfv64rB9ehdCJLVzYGuGfOCy+VmLX4c7Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ulisses -

On 2/24/2012 9:39 AM, Ulisses Furquim wrote:
> Hi Mat,
>
> On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau<mathewm@codeaurora.org>  wrote:
>> This change affects data structures storing ERTM state and control
>> fields, and adds new definitions for states and events.  An
>> l2cap_seq_list structure is added for tracking ERTM sequence numbers
>> without repeated memory allocations.  Control fields are carried in
>> the bt_skb_cb struct rather than constantly doing shift and mask
>> operations.
>>
>> Signed-off-by: Mat Martineau<mathewm@codeaurora.org>
>> ---
>>   include/net/bluetooth/bluetooth.h |   14 ++-
>>   include/net/bluetooth/l2cap.h     |  260 +++++++++----------------------------
>>   2 files changed, 73 insertions(+), 201 deletions(-)
>
> <snip>
>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index d6d8ec8..a499b60 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>
> <snip>
>
>> @@ -645,200 +664,43 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>>
>>   #define __set_chan_timer(c, t) l2cap_set_timer(c,&c->chan_timer, (t))
>>   #define __clear_chan_timer(c) l2cap_clear_timer(c,&c->chan_timer)
>
> Are these two still needed? I saw you moved others to l2cap_core.c
> which is fine but what about these?

Since these macros are unrelated to ERTM, that would be a separate patch.

I think all the macros traditionally land in the header files because 
there are no #defines in the l2cap*.c files.  However, I see that many 
other .c files in net/bluetooth do have #defines.

It's not that I "moved" the other macros, as much as my ported code had 
static functions instead.  I tried to minimize changes to the ported 
code rather than minimize changes to the upstream code.

-- 
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
