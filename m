Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120224094842.GA4013@aemeltch-MOBL1>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
	<20120224094842.GA4013@aemeltch-MOBL1>
Date: Fri, 24 Feb 2012 15:42:32 -0200
Message-ID: <CAA37ikYYGoYcOg5PD98QZt04NjzUWhi6AQVgh2eGYy94vWPQ=g@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi, pkrystad@codeaurora.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, ulisses@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 24, 2012 at 7:48 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Mat,
>
> It is better to have normal patches for a better review.
> I think that we can minimize amount of changes by redefining defines
> when they cannot be used.
>
> I also think think that patches shall be logically split like:
> - change control field handling
> - working with FCS, etc which do not affect state machine
> - adding states
>
> Also check some comments below: (I copied some code from the link you sen=
t)
>
> On Thu, Feb 23, 2012 at 12:37:48PM -0800, Mat Martineau wrote:
>> This change affects data structures storing ERTM state and control
>> fields, and adds new definitions for states and events. =A0An
>> l2cap_seq_list structure is added for tracking ERTM sequence numbers
>> without repeated memory allocations. =A0Control fields are carried in
>> the bt_skb_cb struct rather than constantly doing shift and mask
>> operations.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>> =A0include/net/bluetooth/bluetooth.h | =A0 14 ++-
>> =A0include/net/bluetooth/l2cap.h =A0 =A0 | =A0260 +++++++++-------------=
---------------
>> =A02 files changed, 73 insertions(+), 201 deletions(-)
>
> ...
>
>> -static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
>> -{
>> - =A0 =A0 int sub;
>> -
>> - =A0 =A0 sub =3D (ch->next_tx_seq - ch->expected_ack_seq) % 64;
>> -
>> - =A0 =A0 if (sub < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 sub +=3D 64;
>> -
>> - =A0 =A0 return sub =3D=3D ch->remote_tx_win;
>> -}
>
> BTW: was it already changed? What is the status with Luiz's patch?
>
> ...
>
>> -static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
>> -{
>> - =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return get_unaligned_le32(p);
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 return get_unaligned_le16(p);
>> -}
>
> Cannot it still be used?
>
> + =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_extended_control(get_unaligned_le32(s=
kb->data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0control);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, L2CAP_EXT_CTRL_SIZE);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_enhanced_control(get_unaligned_le16(s=
kb->data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0control);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, L2CAP_ENH_CTRL_SIZE);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 control =3D __get_control(chan, skb->data);
> - =A0 =A0 =A0 skb_pull(skb, __ctrl_size(chan));
>
> ...
>
>> -static inline void __put_control(struct l2cap_chan *chan, __u32 control=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *p)
>> -{
>> - =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return put_unaligned_le32(control, p);
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 return put_unaligned_le16(control, p);
>> -}
>
> Can it be used in the code below:
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags)) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le32(__pack_e=
xtended_control(control),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 skb->data + L2CAP_HDR_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(__pack_e=
nhanced_control(control),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 skb->data + L2CAP_HDR_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> and for example here:
>
> - =A0 =A0 =A0 __put_control(chan, control, skb_put(skb, __ctrl_size(chan)=
));
> + =A0 =A0 =A0 /* Control header is populated later */
> + =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le32(0, skb_put(skb, 4));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(0, skb_put(skb, 2));
>
>
>> -
>> -static inline __u8 __ctrl_size(struct l2cap_chan *chan)
>> -{
>> - =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
>> -}

Do we have that many places with this test in Mat's code? If not, then
we might not need to bother having all of these helpers, I think. And
if we add them, I do think it makes sense to add them to l2cap_core.c
than in l2cap.h, right?

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
