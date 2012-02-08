Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
References: <1328678855.28848.6.camel@aeonflux>
	<20120208090945.GB5917@aemeltch-MOBL1>
	<CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
Date: Wed, 8 Feb 2012 09:16:00 -0200
Message-ID: <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
Subject: Re: Getting L2CAP ERTM support into better upstream state
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

On Wed, Feb 8, 2012 at 7:32 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrei,
>
> On Wed, Feb 8, 2012 at 11:09 AM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
>>
>> I think this would be good to send as patch series so that people can
>> comment. What comes to my mind is that the patch might be reduced if it
>> does not change order of functions and defines like:
>>
>> <------8<---------------------------------------------------------------=
--
>> | =A0-#define L2CAP_EXT_CTRL_TXSEQ =A0 =A0 =A0 =A0 =A0 0xFFFC0000
>> | =A0 #define L2CAP_EXT_CTRL_SAR =A0 =A0 =A0 =A0 =A0 =A0 0x00030000
>> | =A0-#define L2CAP_EXT_CTRL_SUPERVISE =A0 =A0 =A0 0x00030000
>> | =A0 #define L2CAP_EXT_CTRL_REQSEQ =A0 =A0 =A0 =A0 =A00x0000FFFC
>> | =A0-
>> | =A0-#define L2CAP_EXT_CTRL_POLL =A0 =A0 =A0 =A0 =A0 =A00x00040000
>> | =A0+#define L2CAP_EXT_CTRL_TXSEQ =A0 =A0 =A0 =A0 0xFFFC0000
>> | =A0 #define L2CAP_EXT_CTRL_FINAL =A0 =A0 =A0 =A0 =A0 0x00000002
>> | =A0+#define L2CAP_EXT_CTRL_POLL =A0 =A0 =A0 =A0 =A00x00040000
>> | =A0+#define L2CAP_EXT_CTRL_SUPERVISE =A0 =A0 0x00030000
>> | =A0 #define L2CAP_EXT_CTRL_FRAME_TYPE =A0 =A0 =A00x00000001 /* I- or S=
-Frame */
>> <------8<---------------------------------------------------------------=
--
>>
>> and I don't like this kind of change:
>>
>> <------8<---------------------------------------------------------------=
-----
>> | =A0- =A0 =A0 =A0 if (__is_sar_start(chan, control) && !__is_sframe(cha=
n, control))
>> | =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D L2CAP_SDULEN_SIZE;
>> | =A0+ =A0 =A0 =A0 if ((control->frame_type =3D=3D 'i') &&
>> | =A0+ =A0 =A0 =A0 =A0 =A0 (control->sar =3D=3D L2CAP_SAR_START))
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D 2;
>> |
>> | =A0 =A0 =A0 =A0 =A0if (chan->fcs =3D=3D L2CAP_FCS_CRC16)
>> | =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D L2CAP_FCS_SIZE;
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D 2;
>> <------8<---------------------------------------------------------------=
-----
>>
>> why not to use macros and defines for magic numbers?
>>
>> the same below:
>>
>> <------8<---------------------------------------------------------------=
-
>> | =A0+ =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_extended_control(get_unaligned_=
le32(skb->data),
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0control);
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 4);
>> | =A0+ =A0 =A0 =A0 } else {
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_enhanced_control(get_unaligned_=
le16(skb->data),
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0control);
>> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 2);
>> | =A0+ =A0 =A0 =A0 }
>> |
>> | =A0- =A0 =A0 =A0 control =3D __get_control(chan, skb->data);
>> | =A0- =A0 =A0 =A0 skb_pull(skb, __ctrl_size(chan));
>> <------8<---------------------------------------------------------------=
-
>>
>> those magic number does not look nice IMO and the code is not looking an=
y
>> better.
>
> In this aspect perhaps, but we don't need to take the code as it is,
> but the point here is following the states defined by the spec and
> that is IMO much better.

I've taken a quick look last week at their code and indeed it looks
better regarding following the states. In particular they track
rx_state and tx_state and then decide what to do based on that and
what happened. I like it because it's explicit about that instead of
demanding us to reason a lot on what state we are and what we should
do. I'm all for changing our ERTM to that so it'll be more
maintainable.

Marcel mentioned the separation of L2CAP channel and socket. That is a
work in progress by Andrei and judging by what you said, Marcel, you
want that merged before we change ERTM, is that it?

Mat, thanks a lot for doing this. I have just a few questions. Have
you tested the stack with this patch? How was it? Quickly looking
through the code I feel it's almost there. I agree with Andrei
regarding constants and control field handling but apart from that it
looks good, in general.

Regarding delayed work handling, are you sure about usage of
__cancel_delayed_work()? I do think it's safer to use
cancel_delayed_work() instead as it'll just spin on a lock if the
timer to queue the work is running on another CPU.

I saw a comment about channel ref counting and kind of audit that
would be great. It'd be good to see a patch for that after transition
to new state handling.

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
