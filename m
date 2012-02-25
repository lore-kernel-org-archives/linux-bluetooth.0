Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F482C0F.8000305@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
	<CAA37ikZRndo-Sk5r5Dfv64rB9ehdCJLVzYGuGfOCy+VmLX4c7Q@mail.gmail.com>
	<4F482C0F.8000305@codeaurora.org>
Date: Sat, 25 Feb 2012 12:32:56 -0300
Message-ID: <CAA37ikYDRk5Bp4Gk39GVMenzmCk-=SGQtSL2H1dmaqWS451C-w@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Feb 24, 2012 at 9:32 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
> Ulisses -
>
>
> On 2/24/2012 9:39 AM, Ulisses Furquim wrote:
>>
>> Hi Mat,
>>
>> On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau<mathewm@codeaurora.org>
>> =A0wrote:
>>>
>>> This change affects data structures storing ERTM state and control
>>> fields, and adds new definitions for states and events. =A0An
>>> l2cap_seq_list structure is added for tracking ERTM sequence numbers
>>> without repeated memory allocations. =A0Control fields are carried in
>>> the bt_skb_cb struct rather than constantly doing shift and mask
>>> operations.
>>>
>>> Signed-off-by: Mat Martineau<mathewm@codeaurora.org>
>>> ---
>>> =A0include/net/bluetooth/bluetooth.h | =A0 14 ++-
>>> =A0include/net/bluetooth/l2cap.h =A0 =A0 | =A0260
>>> +++++++++----------------------------
>>> =A02 files changed, 73 insertions(+), 201 deletions(-)
>>
>>
>> <snip>
>>
>>> diff --git a/include/net/bluetooth/l2cap.h
>>> b/include/net/bluetooth/l2cap.h
>>> index d6d8ec8..a499b60 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>
>>
>> <snip>
>>
>>> @@ -645,200 +664,43 @@ static inline bool l2cap_clear_timer(struct
>>> l2cap_chan *chan,
>>>
>>> =A0#define __set_chan_timer(c, t) l2cap_set_timer(c,&c->chan_timer, (t)=
)
>>> =A0#define __clear_chan_timer(c) l2cap_clear_timer(c,&c->chan_timer)
>>
>>
>> Are these two still needed? I saw you moved others to l2cap_core.c
>> which is fine but what about these?
>
>
> Since these macros are unrelated to ERTM, that would be a separate patch.

You're right, sorry.

> I think all the macros traditionally land in the header files because the=
re
> are no #defines in the l2cap*.c files. =A0However, I see that many other =
.c
> files in net/bluetooth do have #defines.
>
> It's not that I "moved" the other macros, as much as my ported code had
> static functions instead. =A0I tried to minimize changes to the ported co=
de
> rather than minimize changes to the upstream code.

Yes, I saw the static functions there and I like it better there than
in l2cap.h, really.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
