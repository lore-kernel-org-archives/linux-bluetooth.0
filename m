Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508e92ca0912220656j6913ef64w4bd6c1557079d0b5@mail.gmail.com>
References: <508e92ca0912220656j6913ef64w4bd6c1557079d0b5@mail.gmail.com>
Date: Tue, 5 Jan 2010 20:33:07 -0200
Message-ID: <6b53b1991001051433x19c97c3elbe0edbd5ed8df3b7@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove double free of skb pointer
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 22, 2009 at 12:56 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Trivial fix for double free of skb pointer with kfree_skb to
> make code simplier and cleaner. Remove unused variable err.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 1120cf1..8acc19e 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3518,7 +3518,6 @@ static inline int l2cap_data_channel(struct
> l2cap_conn *conn, u16 cid, struct sk
>        struct l2cap_pinfo *pi;
>        u16 control, len;
>        u8 tx_seq;
> -       int err;
>
>        sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
>        if (!sk) {
> @@ -3570,13 +3569,11 @@ static inline int l2cap_data_channel(struct
> l2cap_conn *conn, u16 cid, struct sk
>                        goto drop;
>
>                if (__is_iframe(control))
> -                       err = l2cap_data_channel_iframe(sk, control, skb);
> +                       l2cap_data_channel_iframe(sk, control, skb);
>                else
> -                       err = l2cap_data_channel_sframe(sk, control, skb);
> +                       l2cap_data_channel_sframe(sk, control, skb);
>
> -               if (!err)
> -                       goto done;
> -               break;
> +               goto done;
>
>        case L2CAP_MODE_STREAMING:
>                control = get_unaligned_le16(skb->data);
> @@ -3602,7 +3599,7 @@ static inline int l2cap_data_channel(struct
> l2cap_conn *conn, u16 cid, struct sk
>                else
>                        pi->expected_tx_seq = tx_seq + 1;
>
> -               err = l2cap_sar_reassembly_sdu(sk, skb, control);
> +               l2cap_sar_reassembly_sdu(sk, skb, control);
>
>                goto done;
>
> --
> 1.6.0.4
>


Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>



-- 
Gustavo F. Padovan
http://padovan.org
