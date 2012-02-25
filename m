Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F482993.4030104@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
	<20120224094842.GA4013@aemeltch-MOBL1>
	<CAA37ikYYGoYcOg5PD98QZt04NjzUWhi6AQVgh2eGYy94vWPQ=g@mail.gmail.com>
	<4F482993.4030104@codeaurora.org>
Date: Sat, 25 Feb 2012 12:37:02 -0300
Message-ID: <CAA37ikZmmS_WbWMYAnhfD_Tap-vTU55t3qc-oUvZ0D=r+-BPeg@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi, pkrystad@codeaurora.org, marcel@holtmann.org,
	luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Feb 24, 2012 at 9:21 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
> Andrei and Ulisses -
>
>
> On 2/24/2012 9:42 AM, Ulisses Furquim wrote:
>>
>> Hi Andrei,
>>
>> On Fri, Feb 24, 2012 at 7:48 AM, Andrei Emeltchenko
>> <andrei.emeltchenko.news@gmail.com> =A0wrote:
>>>
>>> Hi Mat,

<snip>

>>> and for example here:
>>>
>>> - =A0 =A0 =A0 __put_control(chan, control, skb_put(skb, __ctrl_size(cha=
n)));
>>> + =A0 =A0 =A0 /* Control header is populated later */
>>> + =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le32(0, skb_put(skb, 4));
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(0, skb_put(skb, 2));
>
>
> This is the only place the macro would drop in cleanly - but it seems lik=
e a
> macro should be used in more than one place unless it's hiding some reall=
y
> distracting syntax. =A0In this case, I think it's clearer to see what's g=
oing
> on.

If we don't have a lot of places then I'd rather see what's going on as wel=
l.

> And - I forgot to fix some magic numbers in those skb_puts.

This would be good to fix.

>>>> -
>>>> -static inline __u8 __ctrl_size(struct l2cap_chan *chan)
>>>> -{
>>>> - =A0 =A0 if (test_bit(FLAG_EXT_CTRL,&chan->flags))
>>>>
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
>>>> - =A0 =A0 else
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
>>>> -}
>>
>> Do we have that many places with this test in Mat's code? If not, then
>> we might not need to bother having all of these helpers, I think. And
>> if we add them, I do think it makes sense to add them to l2cap_core.c
>> than in l2cap.h, right?
>
> Not too many places with the FLAG_EXT_CTRL test, with use of struct
> bt_control in most of the code. =A0I would rather have helpers in l2cap_c=
ore.c
> if they're needed.

Agreed.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
