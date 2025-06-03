Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854332C325E
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966485; cv=none; b=ZtLX1Hqu3I3PXVLfZSfds5rOKlkP2S4FNZ0RiBF4erjlyJ8ercpLAwJUIMTrtGUm+wcZgqr2G0q13Vxd3bGjU+cYqzQMikd8pMntNz0US+IB2NWnYymlyVsBChYZAfmgSHjV7E40TABUzpUM83CMknLCpwi9eszFBNswvsTLDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966485; c=relaxed/simple;
	bh=qYJZAasVWKPC1hiBO0Gf2AAdFXRGkmrsMp1car4CKg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEe+4KDaz5oqG+YwnfeB+pSvWQgu4zQfjS6FAbsre+PhwATmbYpzTjKXi+Arn29w3zt/rEbW9VTbj0s/F5QU79513wXtqG+wtbRbccZ4TQ5ELCG9LcXOsMYWjtHQR+Srk824m+TwDZn3qBMSw5zphdOqgaQiYrA1QI9Wj0szV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvOGl9At; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvOGl9At"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32a7a5ab797so49883041fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748966481; x=1749571281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh4MAzP2kKoXG5e6+vC1rtk61loH3TMmdXt1aY/bFW0=;
        b=AvOGl9AtEzoNOH4kOsy6FLexXbMhJmWfJJErOXHW1CV0+EanNHNd0kA2ABlRV8IltJ
         6nFqV549CuTc9c99F/4tOjoBUKT5xy6H53YdKc3XgrE5s1GBkoYcnHG8OiO2M/RtbMRK
         9fwUHU93b+1bRYZM1jUqk3B+1rFItulBHuinvOV5XlaEE4a0I9QFMHBAIs+ybodxnmQV
         aK+CP0qJ2v9zh0sckVfXlsB/ibF59mgcmM9DW6aURXgn1fP8suwCn4Z4f4KFBTgU3sci
         7FVvx7Q1QCVR6QjXnJwqLOyFeR53fPFacgowEKyx2gLkBUDI+pECFid7I4iev8BqnQHy
         205g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966481; x=1749571281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh4MAzP2kKoXG5e6+vC1rtk61loH3TMmdXt1aY/bFW0=;
        b=V4xHcX3/nP0Ca5TFKRS8TNPKXaFXPuOYI9g6sqJkEVmZPMyW3VZoBLUSuO1gIRiIBP
         qa4OBepod10d337ABgmL4dOnCBgRRCEHFzv4OBZNGCiuS2Ke86s3xi/K6Fe/lW7PEuwg
         tjShdHt/djHTIAs+AGp7OqEfohT9CLQSDgqzI8NmnSBsIRkjZiWDHt6wFG2IAah/Gd6s
         V6GKDTy8NC9HBuWajXuy93eRaXwjKBsV5Mx1gWVv0WTzp9oANsSx9fNdC7XKL4Abt85v
         RCRdMooRUEwUySwvvVosiDOlu04uKpDEvI3uaZlFpvCx7AUPs3s/iCb0iKT/7S6csa8X
         ZH+Q==
X-Gm-Message-State: AOJu0YwyibaJOFsbqDwjcMh10FKgw6LRsMepTvB6QxUCUNJRRod+NizO
	u4A/x5w3uQ/Kto2xIKkMVoRyW3o4stV0x34QKMnBcP2VePx0gFBxoKurWmRIa7UeLJZlpp+6byD
	HzgUkIbovBIgspd2x6AQCarZUgRRdw4E=
X-Gm-Gg: ASbGncsfmLxg9KQXk70B/vvxe8LgC6d3mbJjgD6WAxc32y7xlzQKNRBO1X1hxTKABDp
	D6YBnchvNzbFHDFthStxKhUcr/0oT8lN6PaoVqCDHE7GEsFobFlNtgphctoqpNoAOff8Pjrd1eR
	UAw0hoN4aHat9aChuL2pnWC+vxsJZhD/8=
X-Google-Smtp-Source: AGHT+IGoarH8DBOJDU2o14Um9Qst6XK+QOnfVjdBkicbtzdW2W43uOg/7eJvJp7r+cU+835P0Act/ex4n822xnF9D+U=
X-Received: by 2002:a2e:a584:0:b0:32a:6c39:8938 with SMTP id
 38308e7fff4ca-32a906893f8mr47806131fa.13.1748966481107; Tue, 03 Jun 2025
 09:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org> <20250603151651.1080923-2-kernel.org@pileofstuff.org>
In-Reply-To: <20250603151651.1080923-2-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Jun 2025 12:01:08 -0400
X-Gm-Features: AX0GCFvAKe8iLYAE0wVGi-HvrkITGjymkSo_wFXCE8jSUU8VRK63USyVXcEnDb4
Message-ID: <CABBYNZ+FgroEZmbj1SoBGfJrMscMeAkC-Z9==h0H30mrFVk0GQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] obexd: Pass at_(un)register value to logind callbacks
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi, frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Jun 3, 2025 at 11:17=E2=80=AFAM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> Logind (un)registers callbacks that it calls when the user's state change=
s.
> Callbacks may also be called during (un)registration.
> Clients may need to handle those initial/final calls specially.
>
> Pass an argument indicating whether this is being called during
> (un)registration, and modify existing callbacks to ignore that argument.
>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  obexd/client/pbap.c       |  6 ++++--
>  obexd/plugins/bluetooth.c |  6 ++++--
>  obexd/src/logind.c        | 14 +++++++-------
>  obexd/src/logind.h        |  8 ++++----
>  4 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 51b523592..64bb8ff72 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1455,8 +1455,9 @@ static struct obc_driver pbap =3D {
>         .remove =3D pbap_remove
>  };
>
> -static int pbap_init_cb(void)
> +static int pbap_init_cb(gboolean at_register)
>  {
> +       (void)at_register;
>         int err;
>
>         DBG("");
> @@ -1482,8 +1483,9 @@ static int pbap_init_cb(void)
>         return 0;
>  }
>
> -static void pbap_exit_cb(void)
> +static void pbap_exit_cb(gboolean at_unregister)
>  {
> +       (void)at_unregister;
>         DBG("");
>
>         g_dbus_remove_watch(system_conn, listener_id);
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index 7ff27a8a8..ad37e636d 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -427,8 +427,9 @@ static const struct obex_transport_driver driver =3D =
{
>
>  static unsigned int listener_id =3D 0;
>
> -static int bluetooth_init_cb(void)
> +static int bluetooth_init_cb(gboolean at_register)
>  {
> +       (void)at_register;
>         connection =3D g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
>         if (connection =3D=3D NULL)
>                 return -EPERM;
> @@ -439,8 +440,9 @@ static int bluetooth_init_cb(void)
>         return obex_transport_driver_register(&driver);
>  }
>
> -static void bluetooth_exit_cb(void)
> +static void bluetooth_exit_cb(gboolean at_unregister)
>  {
> +       (void)at_unregister;
>         GSList *l;
>
>         g_dbus_remove_watch(connection, listener_id);
> diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> index a0eb62b1e..b4279b209 100644
> --- a/obexd/src/logind.c
> +++ b/obexd/src/logind.c
> @@ -43,13 +43,13 @@ static void call_init_cb(gpointer data, gpointer user=
_data)
>  {
>         int res;
>
> -       res =3D ((struct callback_pair *)data)->init_cb();
> +       res =3D ((struct callback_pair *)data)->init_cb(FALSE);
>         if (res)
>                 *(int *)user_data =3D res;
>  }
>  static void call_exit_cb(gpointer data, gpointer user_data)
>  {
> -       ((struct callback_pair *)data)->exit_cb();
> +       ((struct callback_pair *)data)->exit_cb(FALSE);
>  }
>
>  static int update(void)
> @@ -229,7 +229,7 @@ int logind_register(logind_init_cb init_cb, logind_ex=
it_cb exit_cb)
>         struct callback_pair *cbs;
>
>         if (!monitoring_enabled)
> -               return init_cb();
> +               return init_cb(TRUE);
>         if (callbacks =3D=3D NULL) {
>                 int res;
>
> @@ -237,23 +237,23 @@ int logind_register(logind_init_cb init_cb, logind_=
exit_cb exit_cb)
>                 if (res) {
>                         error("logind_init(): %s - login detection disabl=
ed",
>                                 strerror(-res));
> -                       return init_cb();
> +                       return init_cb(TRUE);
>                 }
>         }
>         cbs =3D g_new(struct callback_pair, 1);
>         cbs->init_cb =3D init_cb;
>         cbs->exit_cb =3D exit_cb;
>         callbacks =3D g_slist_prepend(callbacks, cbs);
> -       return active ? init_cb() : 0;
> +       return active ? init_cb(TRUE) : 0;
>  }
>  void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
>  {
>         GSList *cb_node;
>
>         if (!monitoring_enabled)
> -               return exit_cb();
> +               return exit_cb(TRUE);
>         if (active)
> -               exit_cb();
> +               exit_cb(TRUE);
>         cb_node =3D g_slist_find_custom(callbacks, init_cb, find_cb);
>         if (cb_node !=3D NULL)
>                 callbacks =3D g_slist_delete_link(callbacks, cb_node);
> diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> index eb3ff8d7b..3cdb03338 100644
> --- a/obexd/src/logind.h
> +++ b/obexd/src/logind.h
> @@ -8,8 +8,8 @@
>   *
>   */
>
> -typedef int (*logind_init_cb)(void);
> -typedef void (*logind_exit_cb)(void);
> +typedef int (*logind_init_cb)(gboolean at_register);
> +typedef void (*logind_exit_cb)(gboolean at_unregister);
>
>  #ifdef SYSTEMD
>
> @@ -22,12 +22,12 @@ int logind_set(gboolean enabled);
>  static inline int logind_register(logind_init_cb init_cb,
>                                         logind_exit_cb exit_cb)
>  {
> -       return init_cb();
> +       return init_cb(TRUE);
>  }
>  static inline void logind_unregister(logind_init_cb init_cb,
>                                         logind_exit_cb exit_cb)
>  {
> -       return exit_cb();
> +       return exit_cb(TRUE);
>  }
>  static inline int logind_set(gboolean enabled)
>  {
> --
> 2.49.0

This is not going very well in my opinion, it looks like we missed the
opportunity to integrate the logind directly into obc_driver so we
don't have to duplicate code for each coded, so we keep just doing
plugin_init->obc_driver_register/plugin_exit->obc_driver_unregister
and that internally can detect when it shall be registered with the
Bluetoothd, etc, plugin_exit->obc_driver_unregister can actually be
assumed to be exit rather than just D-Bus unregister which happens
when seat is not longer active.

--=20
Luiz Augusto von Dentz
