Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <024FA95B-C70F-42ED-BDBF-69D09AA58203@holtmann.org>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
	<CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com>
	<CADDKRnCsTgDfAZ+rbzKvEXh2ut2=sMKBfS7a7YR+5Rxi02557g@mail.gmail.com>
	<CADDKRnBiB+z2iMc+04ZzntRkGhVW5isNQ+sLt-UVPg3mo+Q7jg@mail.gmail.com>
	<300602D8-9DB7-4F8D-AC97-B60924554093@holtmann.org>
	<CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com>
	<38429B86-0E46-4C6A-9954-3260D864B10C@holtmann.org>
	<CA+55aFx+NrXEtd4bveFbZqw0r9UHxkrQ7rzdZBbfBiGdvEX3zw@mail.gmail.com>
	<024FA95B-C70F-42ED-BDBF-69D09AA58203@holtmann.org>
Date: Sat, 18 Apr 2015 12:18:55 +0200
Message-ID: <CADDKRnDJM4ObYxq0_16cD_sB7+oNu6GCD4Q-=sn1Du1XHLNghQ@mail.gmail.com>
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

What this patch tried to do is to limit it to what userspace is
currently actually using. My mistake was to look only at BlueZ 5.x
userspace and not at BlueZ 4.x userspace. The fix to not break
existing userspace is essentially this:
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index a05b9dbf14c9..9070dfd6b4ad 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -1313,7 +1313,8 @@ int hidp_connection_add(struct hidp_connadd_req *re=
q,
>                         struct socket *ctrl_sock,
>                         struct socket *intr_sock)
>  {
> -       u32 valid_flags =3D 0;
> +       u32 valid_flags =3D BIT(HIDP_VIRTUAL_CABLE_UNPLUG) |
> +                         BIT(HIDP_BOOT_PROTOCOL_MODE);
>
> I ask Joerg to test this patch, but looking at old userspace is that is w=
hat is happening there.
>

I think the last 3 lines are missing, the complete patch is:

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a05b9db..02298bc 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1313,7 +1313,8 @@ int hidp_connection_add(struct hidp_connadd_req *req,
  struct socket *ctrl_sock,
  struct socket *intr_sock)
 {
- u32 valid_flags =3D 0;
+ u32 valid_flags =3D BIT(HIDP_VIRTUAL_CABLE_UNPLUG) |
+                         BIT(HIDP_BOOT_PROTOCOL_MODE);
  struct hidp_session *session;
  struct l2cap_conn *conn;
  struct l2cap_chan *chan;

that patch works for me.

Thanks, J=C3=B6rg
