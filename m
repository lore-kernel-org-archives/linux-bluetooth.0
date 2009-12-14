Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
References: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
Date: Mon, 14 Dec 2009 12:13:29 -0200
Message-ID: <6b53b1990912140613j2b251615y3e3b3fc9ffd74a3@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add locking scheme to timeout callbacks.
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 14, 2009 at 8:36 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi,
>
> On Mon, Aug 24, 2009 at 5:45 AM, Gustavo F. Padovan
> <gustavo@las.ic.unicamp.br> wrote:
>> Avoid race conditions when acessing the sock.
>>
>> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
>> ---
>> =A0net/bluetooth/l2cap.c | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index c04526f..efac637 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -1192,6 +1192,7 @@ static void l2cap_monitor_timeout(unsigned long ar=
g)
>> =A0 =A0 =A0 =A0struct sock *sk =3D (void *) arg;
>> =A0 =A0 =A0 =A0u16 control;
>>
>> + =A0 =A0 =A0 bh_lock_sock(sk);
>> =A0 =A0 =A0 =A0if (l2cap_pi(sk)->retry_count >=3D l2cap_pi(sk)->remote_m=
ax_tx) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_disconn_req(l2cap_pi(sk)->conn=
, sk);
>
> missing unlock ?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> @@ -1203,6 +1204,7 @@ static void l2cap_monitor_timeout(unsigned long ar=
g)
>> =A0 =A0 =A0 =A0control =3D L2CAP_CTRL_POLL;
>> =A0 =A0 =A0 =A0control |=3D L2CAP_SUPER_RCV_READY;
>> =A0 =A0 =A0 =A0l2cap_send_sframe(l2cap_pi(sk), control);
>> + =A0 =A0 =A0 bh_unlock_sock(sk);
>> =A0}
>
> Please consider following patch:
>
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1208,6 +1208,7 @@ static void l2cap_monitor_timeout(unsigned long arg=
)
> =A0 =A0 =A0 =A0bh_lock_sock(sk);
> =A0 =A0 =A0 =A0if (l2cap_pi(sk)->retry_count >=3D l2cap_pi(sk)->remote_ma=
x_tx) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_disconn_req(l2cap_pi(sk)->conn,=
 sk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
>
> Also see complete patch attached.

Acked-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

>
> Regards,
> Andrei Emeltchenko
>



--=20
Gustavo F. Padovan
http://padovan.org
