Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508e92ca0912220529q56d0ca1clef1cd5916edf4aac@mail.gmail.com>
References: <508e92ca0912220529q56d0ca1clef1cd5916edf4aac@mail.gmail.com>
Date: Tue, 22 Dec 2009 15:34:25 +0200
Message-ID: <508e92ca0912220534h15a04daax5d2d231db82cf2b0@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove double free of skb pointer
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I will resend it shortly. Sorry.

On Tue, Dec 22, 2009 at 3:29 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> Trivial fix for double free of skb pointer with kfree_skb to
> make code simplier and cleaner.
>
> skb is already freed within l2cap_data_channel_iframe function.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 1120cf1..9584b97 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3574,9 +3574,7 @@ static inline int l2cap_data_channel(struct
> l2cap_conn *conn, u16 cid, struct sk
>                else
>                        err = l2cap_data_channel_sframe(sk, control, skb);
>
> -               if (!err)
> -                       goto done;
> -               break;
> +               goto done;
>
>        case L2CAP_MODE_STREAMING:
>                control = get_unaligned_le16(skb->data);
> --
> 1.6.0.4
>
