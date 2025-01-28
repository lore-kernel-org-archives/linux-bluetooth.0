Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78186161310
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101595; cv=none; b=bL6xQ4S9cyyHYmfkkvQYYpt83Vm4Prv+MXavrIETpzF0TvOy5yXSwLnI68acaTSJJjlz+jmN77SBHZmUQfUXgIReS4hfcbzklNHB+kac2YVey/QpJUZo8HFUb+dSOZDK6KSVLQEaRGSdd1nJl/Z2UvuRZx86LQ5ACZWBE+gEaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101595; c=relaxed/simple;
	bh=v0fsShKzPXjay4BpxaXVQmbEp6M8sXvj2v42ASTA+uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFNYq+XyZ+SRznPdNJ5OvuCOZL7hbLnMTf02YTJJanYtV3Fn/8iflmLthVjYJckQkRs1FLnVzA5+TCW1ttTt3idk37M5LjRgOyddWp8Mj7B+BOgInnpsUaG3CXV6htcnzTPDvuWaniSWaMnxV4pAsWZnkt0BrF+Meo9MrbTxMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y48it9jF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y48it9jF"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-304e4562516so1159681fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 13:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738101591; x=1738706391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy/kp76vwFO5llB43NyD1fddDID2qWgLIFQKKRZddBU=;
        b=Y48it9jFCf3tpyB1f9ZWw3q0xuW7d6AhDG3W4TWSf0Y7K/NZ/CatlVQk3zGEeOizMv
         yrfGXJji3oSP13FCw30RYRNQK32zZCCx/oUIx8x0wo8oZqsJvXdlfV6G1wPzHZmr4sIU
         8asCG5QCCcZSTdkoenGP0vJ3TVLikF96T8kjXNY0bj2WvvzA75CDApFFD2jfGKN5XJH4
         oVszmTq53X+ZivPWl38Z4f/KEjl1RtamJJin8Pi3WmIM4w7xq1MeHJkFJmFFM0JRC2Kp
         zst+GBF/cH0iHbw67Cs2RetUQi5ykHmVaBMIeRudQxbi49LEVJ/l8kIUCNu33jMQWEm3
         3dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101591; x=1738706391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy/kp76vwFO5llB43NyD1fddDID2qWgLIFQKKRZddBU=;
        b=U3tx6s1tW/aEwcsHwk4SCs3KWl4OVZGQIclCmpWB5BCnkp5lhTMEaQ49qwKNsSfZJj
         20ScC1mAj/i1wlcl7+tNlHdHGFdOF1t/Z55pGYFAIczSSLgdIJUerBM7q9fjOn+aXmPE
         VPMn5+48f+5b/NrMMD48uOaqAVHpOylbFKSKl3zp08xEegDDDfATqzuK3zU7x/Bv5iTA
         slcKvj9ilZRZg1rm5yFngEhf8SwAlACgdBymRN5MU093oMYQjlIRG4y1OehihrJVAS0s
         PLc4/x5jFTw6/hGYBdXFb56D/ItfnKF3BCDfjeYIoeT0BVWwcSXiMvIm9lf6eNCoJ2Q+
         s0qw==
X-Gm-Message-State: AOJu0Yw2dmhW8Ks7spQRPyyZfzC72ptD626YNHXD+WNcxo0XFeNH8LRe
	H2xgYO/WPJNDWEony/8g6FqdEgfGKvPYWYbfJZpyECRqcBuXCvOvWd901dVXtMrqVAiWEJDdh5t
	HCxKsAeXsAjrBSeJBsk6s8FXURE0=
X-Gm-Gg: ASbGncuP3wiavSAtmF11RT32iWEIGcLm+oICGybeu+QJY6npmHZlUKv0qHMsk8UsZIT
	8zRe9bT6sNkNFZKLV/YtJKi+kx/70O0heMbBRF0jE66DGa0PtxkRP6/WvbKT8/sp2RX+wsMCcXg
	==
X-Google-Smtp-Source: AGHT+IGgDoDv85IvKVqprZDqoItbUw/3lv2fujPHrfSzVhGW8ArrqqeBsP0IRDBAoISYdDlb9ygYELyCPlUYXn8ua5Y=
X-Received: by 2002:a2e:bc0f:0:b0:300:31dc:8a4a with SMTP id
 38308e7fff4ca-3078dfeaeb6mr19918411fa.18.1738101591190; Tue, 28 Jan 2025
 13:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128210354.73732-1-pchelkin@ispras.ru>
In-Reply-To: <20250128210354.73732-1-pchelkin@ispras.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2025 16:59:39 -0500
X-Gm-Features: AWEUYZlXek8F9UjqYGMESMSZ7wdkkaUW2QYOYskhvDvr2bnxqN3dgdeLHq5kubM
Message-ID: <CABBYNZJD8YGRtS9tKUAmAYfoarGmEeXhMJChGOQG8jma-rCiKQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] audio: actually try to enable MTU auto-tuning
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fedor,

On Tue, Jan 28, 2025 at 4:04=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> A "0" for the input MTU passed to the underlying socket is supposed to
> indicate that its value should be determined by the L2CAP layer.
> However, the current code treats a zero imtu just as if there is
> nothing to change.
>
> Introduce an additional flag to indicate that the zero imtu is
> explicitly requested by the caller for the purpose of auto-tuning.
> Otherwise, the similar behavior remains.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: ae5be371a9f5 ("avdtp: Enable MTU auto tunning")
> ---
>  btio/btio.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 2d277e409..74a4003b6 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -66,6 +66,7 @@ struct set_opts {
>         uint16_t imtu;
>         uint16_t omtu;
>         int central;
> +       uint8_t auto_mtu;
>         uint8_t mode;
>         int flushable;
>         uint32_t priority;
> @@ -610,7 +611,7 @@ static uint8_t mode_l2mode(uint8_t mode)
>  }
>
>  static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> -                                               uint8_t mode, GError **er=
r)
> +                               uint8_t auto_mtu, uint8_t mode, GError **=
err)
>  {
>         struct l2cap_options l2o;
>         socklen_t len;
> @@ -622,7 +623,7 @@ static gboolean set_l2opts(int sock, uint16_t imtu, u=
int16_t omtu,
>                 return FALSE;
>         }
>
> -       if (imtu)
> +       if (imtu || auto_mtu)
>                 l2o.imtu =3D imtu;

We might need to do some more special handling for auto_mtu, so in
case it fail we retry with the default values instead.

>         if (omtu)
>                 l2o.omtu =3D omtu;
> @@ -666,17 +667,17 @@ static gboolean set_le_mode(int sock, uint8_t mode,=
 GError **err)
>  }
>
>  static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
> -                               uint16_t imtu, uint16_t omtu, uint8_t mod=
e,
> -                               int central, int flushable, uint32_t prio=
rity,
> -                               GError **err)
> +                               uint16_t imtu, uint16_t omtu, uint8_t aut=
o_mtu,
> +                               uint8_t mode, int central, int flushable,
> +                               uint32_t priority, GError **err)
>  {
> -       if (imtu || omtu || mode) {
> +       if (imtu || omtu || auto_mtu || mode) {
>                 gboolean ret =3D FALSE;
>
>                 if (src_type =3D=3D BDADDR_BREDR)
> -                       ret =3D set_l2opts(sock, imtu, omtu, mode, err);
> +                       ret =3D set_l2opts(sock, imtu, omtu, auto_mtu, mo=
de, err);

Perhaps here we do:

if (ret && auto_mtu)
  ret =3D set_l2opts(sock, imtu, omtu, false, mode, err);

Thoughts?

>                 else {
> -                       if (imtu)
> +                       if (imtu || auto_mtu)
>                                 ret =3D set_le_imtu(sock, imtu, err);
>
>                         if (ret && mode)
> @@ -986,6 +987,8 @@ static gboolean parse_set_opts(struct set_opts *opts,=
 GError **err,
>                         opts->imtu =3D va_arg(args, int);
>                         if (!opts->mtu)
>                                 opts->mtu =3D opts->imtu;
> +                       if (!opts->imtu)
> +                               opts->auto_mtu =3D 1;
>                         break;
>                 case BT_IO_OPT_CENTRAL:
>                         opts->central =3D va_arg(args, gboolean);
> @@ -1890,7 +1893,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, Bt=
IOOption opt1, ...)
>         switch (type) {
>         case BT_IO_L2CAP:
>                 return l2cap_set(sock, opts.src_type, opts.sec_level, opt=
s.imtu,
> -                                       opts.omtu, opts.mode, opts.centra=
l,
> +                                       opts.omtu, opts.auto_mtu, opts.mo=
de, opts.central,
>                                         opts.flushable, opts.priority, er=
r);
>         case BT_IO_RFCOMM:
>                 return rfcomm_set(sock, opts.sec_level, opts.central, err=
);
> @@ -1941,7 +1944,7 @@ static GIOChannel *create_io(gboolean server, struc=
t set_opts *opts,
>                                 server ? opts->psm : 0, opts->cid, err) <=
 0)
>                         goto failed;
>                 if (!l2cap_set(sock, opts->src_type, opts->sec_level,
> -                               opts->imtu, opts->omtu, opts->mode,
> +                               opts->imtu, opts->omtu, opts->auto_mtu, o=
pts->mode,
>                                 opts->central, opts->flushable, opts->pri=
ority,
>                                 err))
>                         goto failed;
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz
