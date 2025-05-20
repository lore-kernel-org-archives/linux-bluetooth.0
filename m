Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF51DC99C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751807; cv=none; b=XC890gHsjAqL/bi4lgSLFn34zAuRRiIL1lFwXdWa6lw8zMVclWdoFUHkZDJ1u5KuBJD20SAR0mzHI5bNOOH08/cL2ovBJbWetzUBXlDe9QSnnVTzgeg5K5YdgaN2C4watppDtV+pdN0Cc8985HVuO9V9x98JMVGpp/eD8xBXZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751807; c=relaxed/simple;
	bh=Hy4WqnzdpDcDNXmAGC8stcUaH0KDjtH8zfQiotsKSxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N04pQa9WzdFQ42uqKxLYo/NJG05teYBg5hlCFdu5pZPuCNtK5tDHoufogAAx/nVNsSsliV+EWNipiENpPBIExiyJZXH1UO103gLW0ZshQ4xjMA/tdbuqOcTon/CUCl2xbgRl/xZJ0GfzNXhuQ59sG+ZKc1gA/Ft993GK3ddGqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVpzZHk7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVpzZHk7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-327fcd87a3cso47480971fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751804; x=1748356604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxaB0RkYUK3T59x0bU0rPL1W81ofUbBaAQs6iW0ALIg=;
        b=UVpzZHk7peXRSQPGDKlnv/yF3kTaKjEifaeCLDGuQ+vkMsjWcZIIhKJlVxpuSdMsyU
         sT31Tfk1RbfdO3QZnKZIVEdnegzJ52n8DnXCbZpVakuGZYjNg5F+EOvr44bxqZri9bNN
         sqyoeNNfpOktviIg6YbnQfTLbNdcB0mJUj+qPVpHvSs0yso4cwpD/5jLDszAzpsuBwYO
         TMACNkMYSj6lVVl4JbeR+4vWTWNQbjpN2ba9Oc4Cc6VSU4wv6h4+qZzeY1xfPKIvxygK
         yJs24ld1MSjVH8nhEwr8UyPSFInBc7TqFRo6tlwx+cuKG1KHixYRm88rmJt5evBPUV7E
         fMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751804; x=1748356604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxaB0RkYUK3T59x0bU0rPL1W81ofUbBaAQs6iW0ALIg=;
        b=GbhSOqnBeLE3ZkFWZZSyqRtpTjpnHzDsgpWxk9AqL3KVonbEQJF4rqPwNPFQiua+Od
         go85zbtib/FqgwU1WWQl2J1QTsn7t5/+47VJ59tUb342OFzKfOYOWV6B+LNvFAUKUCzz
         CLi6+8vW+yyjywbIDNLxFT+LBMMHtOkgoqdSBCY243w5WMp3dpPRIfGt7qk9Iy9kdc/R
         uOas+sO0wAguFdvdRdBCkypLG7xPtt+JJjKz3nhLk2hs+YXDQqg7n/XIQWYBluHSc/2h
         4hAKdMPKeJO2Ia1PkR1w+LMsjbHSFeW5lhQpWHGl1Z2XZQ4YjIdfyTEy2beZ/+BLJk1F
         UPcw==
X-Gm-Message-State: AOJu0YyagKu84rp5YG3AlcKCgGkFQpg1XqIUO0QaaFkBnKVYblW0LJPK
	dcvWK1ryW8lh8zsSlqWMi2YfCDy15x8cTdhG0Qtc8NHiHBWzomCg6nZqErkeleQLlzfK5Nt6twv
	oiGTWrecnDlECrqwUczvoawZ02cfLUjco5MjM6k4O/w==
X-Gm-Gg: ASbGncuUnh5Q9H+Db4LrVQsA6gOEC26SkvSuP3swyQEI9H6T06RgNd/P4b++vhbroPw
	J0EOlhjVEfIqdHrvR2ga+QjzZ/5Jsn6Uhe10439Mo9e7IGCWdOC5084qD6NKJ+Tk7yxSYG6ep+T
	Xkck1GSRu/i6Ok1W2FAoVks3MK6xrRjR5FfuIOzMfq0g==
X-Google-Smtp-Source: AGHT+IEcPsnuuAsUaDBmN0mxYzWUfMsomAV79eIuaK4Fun1BPHVq9HUllGNSf3ameFoZwlPkj87BQw/F15AClCTVXG8=
X-Received: by 2002:a2e:bc0f:0:b0:329:3192:4428 with SMTP id
 38308e7fff4ca-329319250d1mr2565931fa.21.1747751803762; Tue, 20 May 2025
 07:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520132733.1746996-1-hadess@hadess.net> <20250520132733.1746996-4-hadess@hadess.net>
In-Reply-To: <20250520132733.1746996-4-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 May 2025 10:36:30 -0400
X-Gm-Features: AX0GCFuMKKAQCF3W6iXdH_Oym06yfRZ94waMYQu2-N1eT7sOqKUTBONwI-Bjbgc
Message-ID: <CABBYNZ+MRhSyLokT6e=EykokK0S=Sy+hxoC3sqoPp3maUtZ6rA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/4] device: Add user-readable messages for a
 number of errors
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, May 20, 2025 at 9:27=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> ---
>  src/device.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 0797e5ff5bb8..d1023f762474 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1922,9 +1922,9 @@ void device_request_disconnect(struct btd_device *d=
evice, DBusMessage *msg)
>                 DBusMessage *reply;
>
>                 if (device->bonding_status =3D=3D MGMT_STATUS_AUTH_FAILED=
)
> -                       err_str =3D ERR_BREDR_CONN_KEY_MISSING;
> +                       err_str =3D ":" ERR_BREDR_CONN_KEY_MISSING ":Link=
 key missing";
>                 else
> -                       err_str =3D ERR_BREDR_CONN_CANCELED;
> +                       err_str =3D ":" ERR_BREDR_CONN_CANCELED ":Connect=
ion canceled";
>                 reply =3D btd_error_failed(device->connect, err_str);
>                 g_dbus_send_message(dbus_conn, reply);
>                 dbus_message_unref(device->connect);
> @@ -2545,7 +2545,8 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>
>         if (!btd_adapter_get_powered(dev->adapter)) {
>                 return btd_error_not_ready_str(msg,
> -                                       ERR_BREDR_CONN_ADAPTER_NOT_POWERE=
D);
> +                                       ":" ERR_BREDR_CONN_ADAPTER_NOT_PO=
WERED
> +                                       ":Adapter not powered");
>         }
>
>         btd_device_set_temporary(dev, false);
> @@ -2564,7 +2565,8 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>                                 return dbus_message_new_method_return(msg=
);
>                         } else {
>                                 return btd_error_not_available_str(msg,
> -                                       ERR_BREDR_CONN_PROFILE_UNAVAILABL=
E);
> +                                       ":" ERR_BREDR_CONN_PROFILE_UNAVAI=
LABLE ":"
> +                                       "Exhausted the list of BR/EDR pro=
files to connect to");
>                         }
>                 }
>
> --
> 2.49.0

I was afraid we would need to change these string again, also if we
need to encode more than human readable errors on on the message
something is already quite wrong, so I wonder if we shall instead
expand the error code itself e.g.:

DBusMessage *btd_error_profile_unavailable_str(DBusMessage *msg, const
char *str)
{
    return g_dbus_create_error(msg, ERROR_INTERFACE ".ProfileUnavailable", =
str);
}

That in my opinion uses the error reply better since we can isolate
what is considered a fixed string, and therefore part of the stable
API, and what could be considered a free format which is the error
message.

>


--=20
Luiz Augusto von Dentz
