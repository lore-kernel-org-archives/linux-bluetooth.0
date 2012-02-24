Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
Date: Fri, 24 Feb 2012 15:39:51 -0200
Message-ID: <CAA37ikZRndo-Sk5r5Dfv64rB9ehdCJLVzYGuGfOCy+VmLX4c7Q@mail.gmail.com>
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
> This change affects data structures storing ERTM state and control
> fields, and adds new definitions for states and events. =A0An
> l2cap_seq_list structure is added for tracking ERTM sequence numbers
> without repeated memory allocations. =A0Control fields are carried in
> the bt_skb_cb struct rather than constantly doing shift and mask
> operations.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> =A0include/net/bluetooth/bluetooth.h | =A0 14 ++-
> =A0include/net/bluetooth/l2cap.h =A0 =A0 | =A0260 +++++++++--------------=
--------------
> =A02 files changed, 73 insertions(+), 201 deletions(-)

<snip>

> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index d6d8ec8..a499b60 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h

<snip>

> @@ -645,200 +664,43 @@ static inline bool l2cap_clear_timer(struct l2cap_=
chan *chan,
>
> =A0#define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
> =A0#define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)

Are these two still needed? I saw you moved others to l2cap_core.c
which is fine but what about these?

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
