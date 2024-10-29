Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36F192D73
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216220; cv=none; b=gaVdyFWKnlhpZ9N74W/IMhlgnj8Mfa0OxGC4rq0NWcHm1HX1l92sRT8HsPUW12PnCI0CRJltTAGw3yczADCmRADLiEbICivLpRiNKYRGQ5sHBRrilklM0BW4VWyxvaMzeNm62+ZVFyquZ986sPTgjoN8bMJW0iQdC0aleyW5FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216220; c=relaxed/simple;
	bh=DPTAjdoHbMKF2Px8VgLWA8f3SUFCoINMGUpmnszNtT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Moke6ih7KDmoTpfvYceDH5itO607Epa/DbsiBOxTN4fwiM0f9FmPHm+4rIgvbTrFCUlT7QpwE2CdjPNKIl6GRixvGFN8UX21IWEfLVkDDwYkzNEQ5UqPXuhrjcSEC5cxQ45uK4Gzgsyibu28EVgEa+Zjpgn3Gwo9G8kSsiHfD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAoaYBrK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAoaYBrK"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so59539791fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216217; x=1730821017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHG7OXI+IfpMlSxzp0jXeLhhhuwdvVE/tddntwUwZ8U=;
        b=MAoaYBrKgsYlKqeB4+2/reuSLHVf5MYhc3hnyFJedCVphiRgj2PtEbCVqq1444xa+L
         b0qX9q2x1d26CSr8AkUSnlCJ/xnGAlOBL8c1ll2esivCGLLJIkyZsK28yPqByF9BJI8k
         fV5477U9TKjMyKFB09GRr3RIeOIJOQeVBqbNQG+b9yNyDL9h4rSjYK2sYNhJanI+Sn5R
         n0yF2f4BbOQJFFmMeL2eqeNx+lk9RTubmgUR4y0ZVNshd7nXmAS05Qt3Ki6VcblZ4RKt
         ajKSZ7eTj2oQJPf3GujWp71QLVndQXZvAL1fxTzOig7iW6OEiqrMJ993MapZXkPFJ86S
         Mxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216217; x=1730821017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHG7OXI+IfpMlSxzp0jXeLhhhuwdvVE/tddntwUwZ8U=;
        b=t3/1N7RWsa0RU33Gsrd1aLapVB0bEqopd6fDVjeGDqBnofI5cEl+IIOxXrvFdItZTt
         KDGehD2nrxSgKQe0F8TR9r87v5d1W+Sf8+2EN7hmy0vmgs5dWuj+UPDkPAHBcMGDGd37
         IfT+GGfxpIdrQr61x6M/rPz/Ah5O9mupEKY5FIJxQ9xn7fWZSYctqsKLvKs8adSmQWrk
         BJIAP9d5iRsOcsYXIN/QDuYcDjUrSR9q1/MuEahmLRh7Xqc5+8AQ0Os4tvMQ49avaqGJ
         bt8+iHE6DgX6ZmZzy+QArz1tmf4lPurBmuvYzz5emWzu/u2r18NMP/wr33m1bi4XSUYC
         FO/g==
X-Gm-Message-State: AOJu0YwZvaQPPvantsn8mngh6HTvXMjgIHCNzhXckBsRM+RuPJTM1R6D
	c20Vv+apqqsSVgxexfscdS7vr6yTnsZMyA/Ec4cQ+Iawe+kHGqJOXRQuy+VBdqc8Qk3BWjouwO9
	C28dK4GnHpzP1fF4doVmWLjf+PHRZ/g==
X-Google-Smtp-Source: AGHT+IFQ5OUqqD+XVAH06ZFYLtqgutL5mcYud43h0nI0sNYvtioDmmWUTjj8jWrijUGW8nR9fLeRkmsGhdHllHJ3r5M=
X-Received: by 2002:a2e:be86:0:b0:2fb:597e:28f5 with SMTP id
 38308e7fff4ca-2fcdc760b08mr9237171fa.2.1730216216385; Tue, 29 Oct 2024
 08:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029151647.1282872-1-hadess@hadess.net>
In-Reply-To: <20241029151647.1282872-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 11:36:43 -0400
Message-ID: <CABBYNZJ9=2sahn9ELk9rm76fs4jY=ObxMEANN5NLghz4CWGy_A@mail.gmail.com>
Subject: Re: [BlueZ] device: Better "Connect" debug
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Oct 29, 2024 at 11:17=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> Output clearer debug information so that it's possible to follow the
> decisions made by the bluetoothd daemon when a client such as
> bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
> device.
> ---
>  src/device.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 7585184de50c..8756aef41aab 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2462,10 +2462,13 @@ static DBusMessage *connect_profiles(struct btd_d=
evice *dev, uint8_t bdaddr_type
>         DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
>                                                 dbus_message_get_sender(m=
sg));
>
> -       if (dev->pending || dev->connect || dev->browse)
> +       if (dev->pending || dev->connect || dev->browse) {
> +               DBG("Cannot connect, connection busy");
>                 return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY=
);

I think for this type of debug we are better off introducing directly
into our gdbus lib so we get the information of both method calls and
replies when debug is enabled, thoughts?

> +       }
>
>         if (!btd_adapter_get_powered(dev->adapter)) {
> +               DBG("Cannot connect, adapter is not powered");
>                 return btd_error_not_ready_str(msg,
>                                         ERR_BREDR_CONN_ADAPTER_NOT_POWERE=
D);
>         }
> @@ -2482,8 +2485,10 @@ static DBusMessage *connect_profiles(struct btd_de=
vice *dev, uint8_t bdaddr_type
>                                                         "Connect") &&
>                                 find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED)) {
> +                               DBG("Already connected to services");
>                                 return dbus_message_new_method_return(msg=
);
>                         } else {
> +                               DBG("Exhausted the list of BR/EDR profile=
s to connect to");
>                                 return btd_error_not_available_str(msg,
>                                         ERR_BREDR_CONN_PROFILE_UNAVAILABL=
E);
>                         }
> @@ -2494,8 +2499,10 @@ static DBusMessage *connect_profiles(struct btd_de=
vice *dev, uint8_t bdaddr_type
>
>         err =3D connect_next(dev);
>         if (err < 0) {
> -               if (err =3D=3D -EALREADY)
> +               if (err =3D=3D -EALREADY) {
> +                       DBG("Already connected");
>                         return dbus_message_new_method_return(msg);
> +               }
>                 return btd_error_failed(msg,
>                                         btd_error_bredr_conn_from_errno(e=
rr));
>         }
> @@ -2568,12 +2575,20 @@ static uint8_t select_conn_bearer(struct btd_devi=
ce *dev)
>         return dev->bdaddr_type;
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
> +       DBG("Calling \"Connect\" for device %s", dev->path);
> +
>         if (dev->bredr_state.connected) {
>                 /*
>                  * Check if services have been resolved and there is at l=
east
> @@ -2581,20 +2596,30 @@ static DBusMessage *dev_connect(DBusConnection *c=
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
> +       }
>
>         if (bdaddr_type !=3D BDADDR_BREDR) {
>                 int err;
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
> 2.47.0
>
>


--=20
Luiz Augusto von Dentz
