Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245595707.15367.66.camel@violet>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
Date: Sun, 21 Jun 2009 13:30:15 -0300
Message-ID: <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 21, 2009 at 11:48 AM, Marcel Holtmann<marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
> so does this fixes it:
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 374536e..266c3b7 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1772,8 +1772,7 @@ static inline void rfcomm_process_dlcs(struct
> rfcomm_sessi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfcomm_dlc_clear_timer(d);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!d->out)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfcomm_sen=
d_dm(s, d->dlci);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d->state =
=3D BT_CLOSED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d->state =3D BT_CLOSED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__rfcomm_dlc_close(d, ECON=
NREFUSED);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>

Not really, rfcomm_dlc is being closed and freed properly, BT_CONNECT2
or BT_CLOSED doesn't make much difference to __rfcomm_dlc_close as
they both trigger default case. As I said the code works fine with
stacks that cope with DM response, when it doesn't you have to
manually trigger rfcomm_session_put to take care of the reference
created on rfcomm_accept_connection.


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
