Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <497946.31108.qm@web52603.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>
	<1265156906.31341.106.camel@localhost.localdomain>
	<90704.85857.qm@web52601.mail.re2.yahoo.com>
	<1265209673.31341.116.camel@localhost.localdomain>
	<AANLkTikNH3_CC3OottoqMnZEwu4sbqvchFxZ2Q7-GlRZ@mail.gmail.com>
	<497946.31108.qm@web52603.mail.re2.yahoo.com>
Date: Wed, 16 Jun 2010 17:14:11 +0300
Message-ID: <AANLkTinH_43xjSTelpT3HhGAoxVoWp1HqUJQcg5vkF71@mail.gmail.com>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
	liejuntao001@gamail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 16, 2010 at 4:39 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> Anrel, =A0what kernel version are you using?
> Previously it was happening with a Blackberry on 2.6.31-17. I was plannin=
g to dig into it, then I upgraded my ubuntu with (2.6.32-22) and the proble=
m disappeared. I am guessing it might be a raising condition with certain p=
hone during certain circumstance. I think Liejun Tao <liejuntao001@gmail.co=
m> has investigate this one too.

I guess that new kernel have different timing. This condition is not
easy to get as several packets have milliseconds between each other
...

We are using kernel 2.6.32-xx and it is a bit different since several
patches which fixes kernel crashes are not yet in bluez ...

Regards,
Andrei Emeltchenko
MeeGo Devices

>
> Cheers,
> Ed
>
>
>
> ----- Original Message ----
> From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
> To: Marcel Holtmann <marcel@holtmann.org>
> Cc: Ed Tsang <netdesign_98@yahoo.com>; Bluettooth Linux <linux-bluetooth@=
vger.kernel.org>
> Sent: Wed, June 16, 2010 6:21:55 AM
> Subject: Re: double Connect req: psm 1 scid 0x0040 ?
>
> Hi,
>
> On Wed, Feb 3, 2010 at 6:07 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>>> >> In hcidump I seem to see a problem in #3. After the Encrypt Change t=
here seem to be 2 >con. req. psm 1 scid 0x0040
>>>
>>> >what kernel version is this? I think we fixed that already.
>>> It is a ubutunu distribution. 2.6.31-17-generic.
>>
>> can you test with a 2.6.33-rc6 vanilla kernel. I really thing this got
>> fixed and you might see a side effect or bad patch here.
>
> Marcel we are seeing "double L2CAP connect also" when connecting to
> some smartphones using contran profile. What about following patch
> proposal:
>
> The idea is to use existing flag L2CAP_CONF_CONNECT_PEND to mark that
> L2CAP request has been sent.
>
> Currently it is durty hack, I will send modified patch later today.
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index fc81acb..27bff6e 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -394,6 +394,12 @@ static void l2cap_do_start(struct sock *sk)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_pi(sk)->ident =3D l2=
cap_get_ident(conn);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->conf_stat=
e &
> L2CAP_CONF_CONNECT_PEND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_ERR "\n!!! %s: Connection
> pending !!!\n", __FUNCTION__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->conf_state |=
=3D L2CAP_CONF_CONNECT_PEND;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_cmd(conn, l2cap=
_pi(sk)->ident,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0L2CAP_CONN_REQ, sizeof(req), &req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -448,6 +454,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn=
)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_pi(s=
k)->ident =3D l2cap_get_ident(conn);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_p=
i(sk)->conf_state &
> L2CAP_CONF_CONNECT_PEND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 printk(KERN_ERR "\n!!! %s:
> Connection pending !!!\n", __FUNCTION__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bh_unlock_sock(sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk=
)->conf_state |=3D
> L2CAP_CONF_CONNECT_PEND;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send=
_cmd(conn, l2cap_pi(sk)->ident,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0L2CAP_CONN_REQ, sizeof(req), &req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -3809,6 +3822,7 @@ static int l2cap_security_cfm(struct hci_conn
> *hcon, u8 status, u8 encrypt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bh_lock_sock(sk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (l2cap_pi(sk)->conf_state & L2CAP_CONF_=
CONNECT_PEND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "\n!!! %s: =
Connection pending
> !!!\n", __FUNCTION__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bh_unlock_sock(sk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -3828,6 +3842,7 @@ static int l2cap_security_cfm(struct hci_conn
> *hcon, u8 status, u8 encrypt)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_pi(s=
k)->ident =3D l2cap_get_ident(conn);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk=
)->conf_state |=3D
> L2CAP_CONF_CONNECT_PEND;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send=
_cmd(conn, l2cap_pi(sk)->ident,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0L2CAP_CONN_REQ, sizeof(req), &req);
>
>
>
>>
>> Regards
>>
>> Marcel
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>
