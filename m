Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C427EC7C
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401384; cv=none; b=uoEaRbJ5YvJaaH9RyucJfc0Tcub5DlepW53JtcBgGz4eQ8TW2+CziPInP/KhjWEYItfytPuqGvr9PGVQVTqzMuLvF49fRHWXGdY8vMrh3PBv36twKGtbdt5mXLAuqMchd5KZ6tGZG3TBqz5Kw8vCHnDhCyOEj5908NEXs9EyqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401384; c=relaxed/simple;
	bh=glQzKgFLKyFVNTI1q+ZO22H5Nx58tW5g45a+5RUDgNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8fi4harqxy3Uls+F9PT0ihbgE5q48oMzk+PPwLVXcgV2OCCshyRpHuP5umGnRJo2LUfhA4lUbIVl+0GDLDQK3+VqkURw2M+HtXxHsWsV4BCBENKZ3aAtY2ougvdS5Q5M/Pjdo4cN2IwzN9LTfRi+3pvGA48juwwP+1OVS5rnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBWILM8e; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBWILM8e"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32addf54a00so31043841fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401380; x=1752006180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m91PITKK0vsDNS2ol7dWwKRKrj41CDyNYlrdjgnu2Yg=;
        b=fBWILM8ehnGc/dtay2KFu2dDUgmaE5NFyUl2i8dSctLUz8UU/7qFJTsYQvL9lPOVzp
         YQMVGNp5TEI6kC4v37QCiAdmj0QVZfhrC15dMBC59zInLlB1g05a9HtvUTGLbQ5WTRVd
         ZbkqwVRilt5Q+xQa7msE1BeGHl/pxX9CEFZDrO98cdCgYtiSmJABjlHbf2A9fLi8e448
         g2YFbE9WwBKFq8CurK6YlL1GnGkvy5UlwUfNYXZTMF1LMoZOeiYjTuGAKfA8fzhsHsDI
         oa/5WkHKmaQlORUKLCAxcvFUr6R92gePk8lgJBtqsFZTBVCxhK2m0qWdccqSfdbk3Z6H
         raKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401380; x=1752006180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m91PITKK0vsDNS2ol7dWwKRKrj41CDyNYlrdjgnu2Yg=;
        b=EDFbHocz8lX6FmTdGFD0ttmoTtGXbEwkgI11gAeCZVO21ayywT0ATXOjbzHUxa3kKa
         8qL65F2ePS2Qe2XMJ5cO2oEVl+HJAL8MQRtt5tPEYe6F6SUo1qnWe2UE/Fw0TSPqLV+H
         x8RQJL6rq21hNMZFqKWnEEfLzZHuS/2OwBdtueMkaf4ycT8yZa37RwXBnQqCqZRJAB/O
         iFgQXijStrekuXinHqHLHBdfoiAQqxjkuLJaWBvTb16xeJyWY1GWoVq3lcZ2tLKeHtoW
         hS0Fd1pAXZG9Tuhtw+XMywu41yjghWHUfh7ThPlZ9qgZLzAWpRALHSmaXT6opKClfhBD
         goCg==
X-Gm-Message-State: AOJu0Yw7BpqY4IJDZzXF1aXAq7AAZ0pomW0WWylJ30aDbt4HG2oyHWUZ
	71LMWHHBN9SULeJo958tXv08ocowI3EqnMvh+fJsmqfYv8RBRgqJTXnw/6Q7++6IRSc1M2gCxnG
	C76pgyXaqUwJd1qghXjxmyuoskkh+e3lrfOtw
X-Gm-Gg: ASbGncvT3vzjM4h25DUx79X3qSlELesKzD4CazyWcCr5U6yNeC/Za8rr48YmeTKmndO
	sIXrpY36JlINF/mGd9mmtrjaMPTnrQs/Cuwt+PHiaL487lVQGhaVRsJzdS16DgdGbgczV4O40EB
	e9UKvITmfL19R1iYunzHvVWwVmDSLlnq/xf7V0v0Z+lw==
X-Google-Smtp-Source: AGHT+IF012x9RZVi4N1LXmBocDkB4DmBHtW9DKefIyw4c9zU922ICO8EmDmJTIGHiUe07baEysKuJLeBRd8awJddMEo=
X-Received: by 2002:a05:651c:227:b0:32a:7750:a0e1 with SMTP id
 38308e7fff4ca-32e00059a40mr1259011fa.26.1751401380354; Tue, 01 Jul 2025
 13:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701101520.459452-1-hadess@hadess.net> <20250701101520.459452-8-hadess@hadess.net>
In-Reply-To: <20250701101520.459452-8-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Jul 2025 16:22:47 -0400
X-Gm-Features: Ac12FXzYJ-_3x3S44ca4uw3CeH0i8q65mwuAyW7kZCJCRVKVSlAj304A29gXk8Y
Message-ID: <CABBYNZJfv--kkRv3w-2xqLcTKCvHgv+EUo0++UorVdkx6jv_gA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 7/8] device: Better error when the link key is missing
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jul 1, 2025 at 6:20=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Add a more precise error when the link key is missing for a
> profile or device we're trying to connect to.
> ---
>  doc/org.bluez.Device.rst |  2 ++
>  src/device.c             | 12 ++++++------
>  src/error.c              | 27 ++++++++++++++++++++++-----
>  src/error.h              |  3 +--
>  4 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index b36a49eabdd5..d4de78a47239 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -50,6 +50,8 @@ Possible errors:
>  :org.bluez.Error.InProgress:
>  :org.bluez.Error.AlreadyConnected:
>  :org.bluez.Error.ProfileUnavailable:
> +:org.bluez.Error.BrConnectionKeyMissing:
> +:org.bluez.Error.LeConnectionKeyMissing:

Id go with org.bluez.Error.BREDR.KeyMissing and org.bluez.Error.LE.KeyMissi=
ng

>
>  void Disconnect()
>  `````````````````
> diff --git a/src/device.c b/src/device.c
> index d7a859f9df3f..3bad7fb2c77c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1982,14 +1982,14 @@ void device_request_disconnect(struct btd_device =
*device, DBusMessage *msg)
>         }
>
>         if (device->connect) {
> -               const char *err_str;
>                 DBusMessage *reply;
>
> -               if (device->bonding_status =3D=3D MGMT_STATUS_AUTH_FAILED=
)
> -                       err_str =3D ERR_BREDR_CONN_KEY_MISSING;
> -               else
> -                       err_str =3D ERR_BREDR_CONN_CANCELED;
> -               reply =3D btd_error_failed(device->connect, err_str);
> +               if (device->bonding_status =3D=3D MGMT_STATUS_AUTH_FAILED=
) {
> +                       reply =3D btd_error_br_connection_key_missing(dev=
ice->connect);
> +               } else {
> +                       reply =3D btd_error_failed(device->connect,
> +                                               ERR_BREDR_CONN_CANCELED);
> +               }
>                 g_dbus_send_message(dbus_conn, reply);
>                 dbus_message_unref(device->connect);
>                 device->bonding_status =3D 0;
> diff --git a/src/error.c b/src/error.c
> index 8070bc6107ae..596ea4280991 100644
> --- a/src/error.c
> +++ b/src/error.c
> @@ -136,6 +136,20 @@ DBusMessage *btd_error_profile_unavailable(DBusMessa=
ge *msg)
>                                         "profiles to connect to");
>  }
>
> +DBusMessage *btd_error_br_connection_key_missing(DBusMessage *msg)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE
> +                                       ".BrConnectionKeyMissing",
> +                                       "BR/EDR Link Key missing");
> +}
> +
> +static DBusMessage *btd_error_le_connection_key_missing(DBusMessage *msg=
)
> +{
> +       return g_dbus_create_error(msg, ERROR_INTERFACE
> +                                       ".LeConnectionKeyMissing",
> +                                       "LE Link Key missing");
> +}
> +
>  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE
> @@ -177,8 +191,6 @@ static const char *btd_error_str_bredr_conn_from_errn=
o(int errno_code)
>                 return ERR_BREDR_CONN_ABORT_BY_LOCAL;
>         case EPROTO:
>                 return ERR_BREDR_CONN_LMP_PROTO_ERROR;
> -       case EBADE:
> -               return ERR_BREDR_CONN_KEY_MISSING;
>         default:
>                 return ERR_BREDR_CONN_UNKNOWN;
>         }
> @@ -217,8 +229,6 @@ static const char *btd_error_str_le_conn_from_errno(i=
nt errno_code)
>                 return ERR_LE_CONN_ABORT_BY_LOCAL;
>         case EPROTO:
>                 return ERR_LE_CONN_LL_PROTO_ERROR;
> -       case EBADE:
> -               return ERR_LE_CONN_KEY_MISSING;
>         default:
>                 return ERR_LE_CONN_UNKNOWN;
>         }
> @@ -227,6 +237,8 @@ static const char *btd_error_str_le_conn_from_errno(i=
nt errno_code)
>  DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno=
_code)
>  {
>         switch (-errno_code) {
> +       case EBADE:
> +               return btd_error_br_connection_key_missing(msg);
>         case ENOPROTOOPT:
>                 return btd_error_profile_unavailable(msg);
>         default:
> @@ -237,6 +249,11 @@ DBusMessage *btd_error_bredr_conn_from_errno(DBusMes=
sage *msg, int errno_code)
>
>  DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_co=
de)
>  {
> -       return btd_error_failed(msg,
> +       switch (-errno_code) {
> +       case EBADE:
> +               return btd_error_le_connection_key_missing(msg);
> +       default:
> +               return btd_error_failed(msg,
>                                 btd_error_str_le_conn_from_errno(errno_co=
de));
> +       }
>  }
> diff --git a/src/error.h b/src/error.h
> index f4ad81e5daa5..96b7a7122457 100644
> --- a/src/error.h
> +++ b/src/error.h
> @@ -41,7 +41,6 @@
>  #define ERR_BREDR_CONN_LMP_PROTO_ERROR         "br-connection-lmp-protoc=
ol-"\
>                                                 "error"
>  #define ERR_BREDR_CONN_CANCELED                        "br-connection-ca=
nceled"
> -#define ERR_BREDR_CONN_KEY_MISSING             "br-connection-key-missin=
g"
>  #define ERR_BREDR_CONN_UNKNOWN                 "br-connection-unknown"
>
>  /* LE connection failure reasons */
> @@ -62,7 +61,6 @@
>  #define ERR_LE_CONN_LL_PROTO_ERROR     "le-connection-link-layer-protoco=
l-"\
>                                         "error"
>  #define ERR_LE_CONN_GATT_BROWSE                "le-connection-gatt-brows=
ing"
> -#define ERR_LE_CONN_KEY_MISSING                "le-connection-key-missin=
g"
>  #define ERR_LE_CONN_UNKNOWN            "le-connection-unknown"
>
>  DBusMessage *btd_error_invalid_args(DBusMessage *msg);
> @@ -84,6 +82,7 @@ DBusMessage *btd_error_agent_not_available(DBusMessage =
*msg);
>  DBusMessage *btd_error_not_ready(DBusMessage *msg);
>  DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str);
>  DBusMessage *btd_error_profile_unavailable(DBusMessage *msg);
> +DBusMessage *btd_error_br_connection_key_missing(DBusMessage *msg);
>  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
>  DBusMessage *btd_error_bredr_conn_from_errno(DBusMessage *msg, int errno=
_code);
>  DBusMessage *btd_error_le_conn_from_errno(DBusMessage *msg, int errno_co=
de);
> --
> 2.50.0
>
>


--=20
Luiz Augusto von Dentz
