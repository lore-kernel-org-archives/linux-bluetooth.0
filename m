Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1512E611E
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401172; cv=none; b=FUE74CtxmVMZznFOt3s7s4PxSkUlwb11h68Qkcy+PVpQp2mfw3TuVpYEJTHEKiTN0KOP3HDR6h0gEUs5pWU/STkyEuV8GYjYUkHV3n9bgfzusB0HOp44v8uyc5M58AGsmFPEqUPRGlXyS3u9OFfRHthbOeO0bDSgxIRV7cxRnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401172; c=relaxed/simple;
	bh=FuyM8KVRBqbRhRhsFnr148PLbXKBaebtvp5Om6vrQb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgt+WF8zxHc1+pk2rUeTXmkL3KPplnY1nMOzBN4Go7oJivOF8Qi0BMp8A12X/AK8XpMk7Y96IwMOt1r4Z0mdWBN5NrqaloznEyYEFI3ZJSTcOLQEEBbjqH4IJHllPKh35xMKbm6/er6tCBjGhACk7XKDRBIKNeW0TS7RMub9Rgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIdciWql; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIdciWql"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so34301911fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751401168; x=1752005968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0aE0O2/2xOdWTSN5JeE2ypPwLen7yJfiXzhJDysxRE=;
        b=bIdciWql7KKeT0ecfQQL+wwYOGbJvrGskldiSeprm+XknOfhJuGk772QqSbR6jd4Dc
         mIXn5x/WF9ogz803MCCc1LiRwhZjxkabliLp+K/XNjjZSdZpzMrjGU8a/5HTSvdZhL6/
         apfgjr5/BriiOr7f3m1aWIuLk3V2VruhA1ghj1qRpSiAO1BGvRrTAMmILtR5v75XpPX+
         WQRZozqUM7TOESAamXfgzcqw9z5Km3/cPsoHKPJ2d08qhnRcWqJtEVhbg0/04xg45j8m
         6mMvikWVJXPu/Ae8h6IfIwG99HDoFVgFU5OuiAWqFI9Uk8oTkAh5nfvbpm/xukHaAKJT
         5ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401168; x=1752005968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0aE0O2/2xOdWTSN5JeE2ypPwLen7yJfiXzhJDysxRE=;
        b=oMgd2TJxQjN4PGY4zdx97b5EYUGEho/u7y81RAmMgdxlla0HYLUJU1v/OkCx7Ei0rB
         dhdaWEaBTqKlWNUXZzP9OclEJn7lD2zbRg3hUjfNHVuwCHu9Zb8phXM7EJYIGw0AJSKM
         WBR2MwHD8xRJ9Vb24ql4wyKBs4qvh0QzaHe63GOOwmGFiuX71HM+JGbZw2NbjDe1OJnE
         Ema4uQnjhwmJYGewPAQ8PLG7BGJUtt+PAQQmCimkA7TW5tDenmwduWARhM5NXqPGtV8W
         pTS/0k7HRKN5oYOiuKqdOCJA4QmcPUwTFBCX520Z4j70IVCy2h+VXj0UNDlg+/+hhUr5
         2OVg==
X-Gm-Message-State: AOJu0YzNzwvDxlQWxB8+/Hpxb0CwFMzUYmWC0/OfXIG61aFQUxOga60P
	YD5foo4vi51hHC4Pm1UGqKrHFqgLrAHZkDCK6KfFarTzPOCErhGPP/uUoaaefliNzIIYOABir17
	N/F/9D8C/71E/GjwyQfSbAoTo4l1izVfOwYTVO60=
X-Gm-Gg: ASbGncvwc86m2GeL82NI4hGwgZfDfwPwFaAc25RX3EzcXaKKU7ilfTkjPhtS6ZgQzoI
	IFXpReu1F0QSsWkyVlitYpYWCO91Wdyl2n8Ko6FGj7DZOPMbV2ha35kkh5Ipzn3B+l7nBqnk/rv
	Z8a+6nrvLkIGLNG6x1kKlzWZkxBs5gOHFFwyYP660hsw==
X-Google-Smtp-Source: AGHT+IGnXO+jDLYK5biM+GlarI7lkFLD6YjPgwbUS74Se8OwTtBRCk+7qGQ197axNQqk7ScMJFaDqk7nwHBtBYbkR6M=
X-Received: by 2002:a2e:9b86:0:b0:32b:76fe:134e with SMTP id
 38308e7fff4ca-32e000693cdmr1094651fa.23.1751401167982; Tue, 01 Jul 2025
 13:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701101520.459452-1-hadess@hadess.net> <20250701101520.459452-7-hadess@hadess.net>
In-Reply-To: <20250701101520.459452-7-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Jul 2025 16:19:15 -0400
X-Gm-Features: Ac12FXxDMRpGxrJ9LBlPTXlZI3_xA8s96DaXNmFApYoK_I1dGMNEylXBp7-77zY
Message-ID: <CABBYNZLZLDmERYGxr1+z1t5p9gesVRF5KwOVSbp6nVvKe2VY_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 6/8] device: Better "Connect" debug
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jul 1, 2025 at 6:20=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Output clearer debug information so that it's possible to follow the
> decisions made by the bluetoothd daemon when a client such as
> bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
> device.

Well this will only output to syslog though, so the client won't
necessarily see any of this, and this actually requires the daemon to
be running with debug enabled.

> ---
>  src/device.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 99c0aa67ec0c..d7a859f9df3f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2683,6 +2683,7 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>                                                         "Connect") &&
>                                 find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED)) {
> +                               DBG("Already connected to services");
>                                 return dbus_message_new_method_return(msg=
);
>                         } else {
>                                 return btd_error_profile_unavailable(msg)=
;
> @@ -2694,8 +2695,10 @@ static DBusMessage *connect_profiles(struct btd_de=
vice *dev, uint8_t bdaddr_type
>
>         err =3D connect_next(dev);
>         if (err < 0) {
> -               if (err =3D=3D -EALREADY)
> +               if (err =3D=3D -EALREADY) {
> +                       DBG("Already connected");
>                         return dbus_message_new_method_return(msg);
> +               }
>                 return btd_error_bredr_conn_from_errno(msg, err);
>         }
>
> @@ -2718,14 +2721,24 @@ resolve_services:
>         return NULL;
>  }
>
> +static const char *bdaddr_type_strs[] =3D {
> +       "BR/EDR",
> +       "LE public",
> +       "LE random"
> +};
> +
>  static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>                                                         void *user_data)
>  {
>         struct btd_device *dev =3D user_data;
>         uint8_t bdaddr_type;
>
> -       if (dev->bonding)
> +       DBG("Calling \"Connect\" for device %s", dev->path);

We do have D-Bus message logging so this seems excessive to me.

> +
> +       if (dev->bonding) {
> +               DBG("Bonding in progress");
>                 return btd_error_in_progress(msg);
> +       }
>
>         if (dev->bredr_state.connected) {
>                 /*
> @@ -2734,23 +2747,35 @@ static DBusMessage *dev_connect(DBusConnection *c=
onn, DBusMessage *msg,
>                  */
>                 if (dev->bredr_state.svc_resolved &&
>                         find_service_with_state(dev->services,
> -                                               BTD_SERVICE_STATE_CONNECT=
ED))
> +                                               BTD_SERVICE_STATE_CONNECT=
ED)) {
>                         bdaddr_type =3D dev->bdaddr_type;
> -               else
> +                       DBG("Selecting address type %s, as BR/EDR service=
s are resolved "
> +                           " and connected", bdaddr_type_strs[dev->bdadd=
r_type]);
> +               } else {
>                         bdaddr_type =3D BDADDR_BREDR;
> -       } else if (dev->le_state.connected && dev->bredr)
> +                       DBG("Selecting address type BR/EDR, as services n=
ot resolved "
> +                           "or not connected");
> +               }
> +       } else if (dev->le_state.connected && dev->bredr) {
>                 bdaddr_type =3D BDADDR_BREDR;
> -       else
> +               DBG("Selecting address type BR/EDR, as LE already connect=
ed");
> +       } else {
>                 bdaddr_type =3D select_conn_bearer(dev);
> +               DBG("Selecting address type %s", bdaddr_type_strs[dev->bd=
addr_type]);

Don't really like this many calls for something so simple, beside we
now have the likes of PreferredBearer for the client to indicate what
bearer it wants to connect, otherwise if we have to explain every
decision we make we basically need to log the entire code, so we
better log what not why.

> +       }
>
>         if (bdaddr_type !=3D BDADDR_BREDR) {
>                 int err;
>
> -               if (dev->connect)
> +               if (dev->connect) {
> +                       DBG("Device already connecting");
>                         return btd_error_in_progress(msg);
> +               }
>
> -               if (dev->le_state.connected)
> +               if (dev->le_state.connected) {
> +                       DBG("Device already connected through LE");
>                         return dbus_message_new_method_return(msg);
> +               }
>
>                 btd_device_set_temporary(dev, false);
>
> --
> 2.50.0
>
>


--=20
Luiz Augusto von Dentz
