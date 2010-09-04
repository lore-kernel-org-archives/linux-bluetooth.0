Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1283591900-31504-2-git-send-email-gustavo@padovan.org>
References: <1283591900-31504-1-git-send-email-gustavo@padovan.org>
	<1283591900-31504-2-git-send-email-gustavo@padovan.org>
Date: Sat, 4 Sep 2010 09:14:56 -0400
Message-ID: <AANLkTinHsLbqaoFh_XXceb-aY0weOoDrRcbU1QLi3dfU@mail.gmail.com>
Subject: Re: [PATCH bluetooth-next-2.6 2/2] Bluetooth: Initial move of L2CAP
 socket to l2cap_sock.c
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Sep 4, 2010 at 5:18 AM, Gustavo F. Padovan <gustavo@padovan.org> wr=
ote:
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f2062aa..1f6d448 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -57,24 +57,21 @@
>
> =A0#define VERSION "2.15"
>
> -static int disable_ertm =3D 0;
> +int disable_ertm =3D 0;
>
> =A0static u32 l2cap_feat_mask =3D L2CAP_FEAT_FIXED_CHAN;
> =A0static u8 l2cap_fixed_chan[8] =3D { 0x02, };
>
> -static const struct proto_ops l2cap_sock_ops;
> -
> =A0static struct workqueue_struct *_busy_wq;
>
> -static struct bt_sock_list l2cap_sk_list =3D {
> +struct bt_sock_list l2cap_sk_list =3D {
> =A0 =A0 =A0 =A0.lock =3D __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
> =A0};
>
> =A0static void l2cap_busy_work(struct work_struct *work);
>
> -static void __l2cap_sock_close(struct sock *sk, int reason);
> =A0static void l2cap_sock_close(struct sock *sk);
> -static void l2cap_sock_kill(struct sock *sk);
> +void l2cap_sock_kill(struct sock *sk);

If l2cap_core.c includes net/bluetooth/l2cap.h, you don't need the
declaration above.

Regards,
--=20
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
