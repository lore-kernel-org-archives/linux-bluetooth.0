Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273633558-10576-6-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
	<1273633558-10576-1-git-send-email-padovan@profusion.mobi>
	<1273633558-10576-2-git-send-email-padovan@profusion.mobi>
	<1273633558-10576-3-git-send-email-padovan@profusion.mobi>
	<1273633558-10576-4-git-send-email-padovan@profusion.mobi>
	<1273633558-10576-5-git-send-email-padovan@profusion.mobi>
	<1273633558-10576-6-git-send-email-padovan@profusion.mobi>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Wed, 12 May 2010 15:36:48 -0300
Message-ID: <AANLkTilYb-ZtPFbEI9xVd0yUjiXsD6az7nhvhef5Gfyk@mail.gmail.com>
Subject: Re: [l2cap 6/6] Bluetooth: Only check SAR bits if frame is I-frame
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 12, 2010 at 00:05, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
> =C2=A0net/bluetooth/l2cap.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index dbd43d1..2192b9c 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -4123,7 +4123,7 @@ static inline int l2cap_data_channel(struct l2cap_c=
onn *conn, u16 cid, struct sk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (l2cap_check_fc=
s(pi, skb))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto drop;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (__is_sar_start(con=
trol))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (__is_sar_start(con=
trol) && __is_iframe(control))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0len -=3D 2;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pi->fcs =3D=3D=
 L2CAP_FCS_CRC16)
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

The whole series looks good to me.

--=20
Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/
