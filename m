Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <508e92ca0912230317t3e5ff05ep9f51ef326e5e9de7@mail.gmail.com>
References: <508e92ca0912230317t3e5ff05ep9f51ef326e5e9de7@mail.gmail.com>
Date: Tue, 5 Jan 2010 20:33:35 -0200
Message-ID: <6b53b1991001051433u3cfc8171w1aed9dc015391c2@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix memory leak in l2cap
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 23, 2009 at 9:17 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi, Please check following patch (also attached)
>
> Move skb_clone after error confition check so it is not going
> potentially out of the scope.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
> =A0net/bluetooth/l2cap.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 1120cf1..b927045 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1368,7 +1368,6 @@ static int l2cap_ertm_send(struct sock *sk)
>
> =A0 =A0 =A0 =A0while ((skb =3D sk->sk_send_head) && (!l2cap_tx_window_ful=
l(sk)) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_skb =3D skb_clone(skb, GFP_ATOMIC);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pi->remote_max_tx &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bt_cb(skb)=
->retries =3D=3D pi->remote_max_tx) {
> @@ -1376,6 +1375,8 @@ static int l2cap_ertm_send(struct sock *sk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_skb =3D skb_clone(skb, GFP_ATOMIC);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bt_cb(skb)->retries++;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0control =3D get_unaligned_le16(tx_skb->dat=
a + L2CAP_HDR_SIZE);
> --
> 1.6.0.4
>


Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>



--=20
Gustavo F. Padovan
http://padovan.org
