Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1278540518-18620-4-git-send-email-ingas@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
	<1278540518-18620-4-git-send-email-ingas@codeaurora.org>
Date: Thu, 8 Jul 2010 14:36:34 +0300
Message-ID: <AANLkTinzhNe3-U_wTH3TJIANn6JNgnd7yOp07Ex3axeU@mail.gmail.com>
Subject: Re: [PATCH 3/3] Extended support for generating dictionary value of
	service UUIDs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, rshaffer@codeaurora.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 8, 2010 at 1:08 AM, Inga Stotland <ingas@codeaurora.org> wrote:
> ---
> =A0src/adapter.c =A0| =A0103 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++--
> =A0src/adapter.h =A0| =A0 =A04 +-
> =A0src/dbus-hci.c | =A0 =A07 ++--
> =A0src/sdpd.h =A0 =A0 | =A0 =A02 +
> =A04 files changed, 107 insertions(+), 9 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 8a05356..9be12e7 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2716,6 +2716,7 @@ static void append_dict_valist(DBusMessageIter *ite=
r,
> =A0 =A0 =A0 =A0DBusMessageIter dict;
> =A0 =A0 =A0 =A0const char *key;
> =A0 =A0 =A0 =A0int type;
> + =A0 =A0 =A0 int n_elements;
> =A0 =A0 =A0 =A0void *val;
>
> =A0 =A0 =A0 =A0dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> @@ -2727,7 +2728,12 @@ static void append_dict_valist(DBusMessageIter *it=
er,
> =A0 =A0 =A0 =A0while (key) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D va_arg(var_args, int);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D va_arg(var_args, void *);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dict_append_entry(&dict, key, type, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D DBUS_TYPE_ARRAY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_elements =3D va_arg(var_a=
rgs, int);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (n_elements > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dict_append=
_array(&dict, key, DBUS_TYPE_STRING, val, n_elements);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dict_append_entry(&dict, ke=
y, type, val);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0key =3D va_arg(var_args, char *);
> =A0 =A0 =A0 =A0}

Maybe you should separate this from the rest since they will probably
be more use of arrays in dictionaries in the future.

--=20
Luiz Augusto von Dentz
Computer Engineer
