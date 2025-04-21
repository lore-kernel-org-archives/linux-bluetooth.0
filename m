Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84213D279
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245149; cv=none; b=rHeOepfxBGjlT5RMYkaBIvoenc/1mFQtGbmHdZvf628qg1BRlK5vaYKr6o8EdaX9E+JR0gXDwmOUQzudKYWnpasikYzRukJIItYGOLiSsGyal/5937DvJmxRUIhHIFiz4Q+vVESj1dudX5A2O23yCA8VT1JoVIvSJANyUb+pfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245149; c=relaxed/simple;
	bh=pS0n0FUi8capciaGRZi1M6h7VDFUOycGHFbiiyEUEaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpbxGylGeWGXu+U3oJfV3FSjpqA5UL1Vflq0CsDmpu2mkQQCVPn3MyGVvhedg8Yx9RXQRyIvIqJ2fdrg2nMYjwOdDzrRh07E7hWxUJYUQ9cGtpxq0FxHb50DrEmQzQ/Q45/7sEPpMIVlyOLCLa0waRdNBB3NZ9w/1oXt4g83Uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqmS31Rl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqmS31Rl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so36095141fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745245146; x=1745849946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOWgaZm1p0rXaHm/Bpzd7RfLJHBZ97brK75IXcP4duk=;
        b=IqmS31RlThPr9NBgSxqDbP+SY/FJ/+bxNv1hL/bOq31Rm+cYo7rDKE8p+OlBnGoj+7
         nt7DS1fs3pwgPJ6h8N/qe9wowUaKbOtdNzHlp620wXXUdzMNZA+UhRhvTEeDEmtrsUtk
         ELMjnlr3JX2xQClXxZsiR6hrksN4wmz3AgIDQgjrGPk6PTcnrNQCBOglOqT7fz6ZE+gc
         1Jm8ArjUmeMPvmS2Gv+6nlbq2EDIh7YEyCQehOV5/imbLDr/WvbeKTkSoJOnWwEFyqtM
         +FstOzdvopGfs0sOkLXG5EK6kyMuKo46qTJQwGhEMZXT/vHIZF1IDa1IbpY0neeqEOmH
         UGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745245146; x=1745849946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOWgaZm1p0rXaHm/Bpzd7RfLJHBZ97brK75IXcP4duk=;
        b=GNli6AB4g4mdOwyGE2qSiLXkmE9iF/1SqhxtC2tqKxycnRPpo1SM8xsnw8Gwdlwr0J
         +Z8M7QMxfI6/GVlqp9MrshhpPAZ8WRlhtKn2EuOOBimCycXt59yF2XjxEaay90Pr3oHA
         eRVl8UD+sznl/DCVgZBwFHWtKvTCx0sNZ2o7Bp5pgy7bbduegqCH4LE/qg/IVvBzs8CB
         yTda1R9UusQgZr2Wo+wk2K6xVkHWj7HctSWGbKE6JYRy+t4UpuLifi4gmJ/n9UaJr31d
         DD+ZxctQWBiT0Q1kj7xcfsz082D7X5XJoBFN51Ji3ESB9cmCE4xusVO+3RopQvS+mJO+
         XFUg==
X-Gm-Message-State: AOJu0Yw02mn3Fl/qKTSnYolb1zt+3JE3l1rpZKP08Lv0vAa2iNeZBv6l
	KSDDyWA0/TXK77QL+5jpKKwNtpMWmpp+4SZsVamu7I2xMLtH5HFKW94t+D+m5pEFzqmUE/3LIgC
	JalBYsR8D4yg95VModk+gOwSfHLQ=
X-Gm-Gg: ASbGncvX0qLptrn7zvfGbZa2wa/iEwn46YRiJSeJO9YK54r4Mu3kKpVd2P6lXn6R3MM
	Kp3SZ0qDCTS2nf/ldFMOLl9yWLlrF6foz1lNFKL95D0j5Q64m5bz4urw/mhRIK6feLncnAYd81/
	DGyCSJWr6IkkOn0v046/DEPTvDGsXtCsU=
X-Google-Smtp-Source: AGHT+IE0ExsaBJVyweENvvbrbeCYVZaBmO16dqOrxAWy0N8YDeeQFU2dXkfmVmYSjZoygTOZaTkQAVUf1cl+gdmBYso=
X-Received: by 2002:a05:651c:30d5:b0:30c:50fd:9afe with SMTP id
 38308e7fff4ca-310904db007mr36424661fa.9.1745245145525; Mon, 21 Apr 2025
 07:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421111251.108943-1-ludovico.denittis@collabora.com> <20250421111251.108943-5-ludovico.denittis@collabora.com>
In-Reply-To: <20250421111251.108943-5-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 10:18:52 -0400
X-Gm-Features: ATxdqUHDRRrdz0vQvqa_VhJse7Fw0gIwMY5WKHO0ITC2xfmL6FmkN6O7jbsrM70
Message-ID: <CABBYNZ+QwX8r_8vU=piJ2AF6i_Us9opDNOe4r+9hM=9Jv0N0Bg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] input: Start the server with sec low and bump
 it when making the connection
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Mon, Apr 21, 2025 at 7:14=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> BT_IO_SEC_LOW is the only way to allow Sixaxis devices to establish
> a connection.
>
> When BlueZ has been compiled with Sixaxis support enabled, we start the
> listening input server with BT_IO_SEC_LOW to avoid breaking the Sixaxis
> support.
> Then, in `hidp_add_connection()`, we check if either
> `classic_bonded_only` was disabled or if this device is a Sixaxis. If
> neither are true, we bump the security back to BT_IO_SEC_MEDIUM, i.e.
> enforcing encryption.
>
> This allows supporting the Sixaxis gamepad without having to change the
> classic bonded only option.
> ---
>  profiles/input/device.c | 6 ++++--
>  profiles/input/server.c | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 3627573e7..eb2fb5c8e 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1088,8 +1088,10 @@ static int hidp_add_connection(struct input_device=
 *idev)
>         if (device_name_known(idev->device))
>                 device_get_name(idev->device, req->name, sizeof(req->name=
));
>
> +       sixaxis_cable_pairing =3D device_is_sixaxis_cable_pairing(idev->d=
evice);
> +
>         /* Make sure the device is bonded if required */
> -       if (classic_bonded_only && !input_device_bonded(idev)) {
> +       if (classic_bonded_only && !sixaxis_cable_pairing && !input_devic=
e_bonded(idev)) {
>                 error("Rejected connection from !bonded device %s", idev-=
>path);
>                 goto cleanup;
>         }
> @@ -1098,7 +1100,7 @@ static int hidp_add_connection(struct input_device =
*idev)
>         /* Some platforms may choose to require encryption for all device=
s */
>         /* Note that this only matters for pre 2.1 devices as otherwise t=
he */
>         /* device is encrypted by default by the lower layers */
> -       if (classic_bonded_only || idev->type =3D=3D BT_UHID_KEYBOARD) {
> +       if (!sixaxis_cable_pairing && (classic_bonded_only || idev->type =
=3D=3D BT_UHID_KEYBOARD)) {
>                 if (!bt_io_set(idev->intr_io, &gerr,
>                                         BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_ME=
DIUM,
>                                         BT_IO_OPT_INVALID)) {
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index 79cf08a66..73caeb076 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -273,6 +273,13 @@ int server_start(const bdaddr_t *src)
>         BtIOSecLevel sec_level =3D input_get_classic_bonded_only() ?
>                                         BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
>
> +#ifdef HAVE_SIXAXIS
> +       /* Lower security to allow the Sixaxis gamepad to connect. */
> +       /* Unless classic bonded only mode is disabled, the security leve=
l */
> +       /* will be bumped again for non sixaxis devices in hidp_add_conne=
ction() */
> +       sec_level =3D BT_IO_SEC_LOW;
> +#endif

This is not that great, even if we increase the level at a later stage
there is no reason to use low security while there are no input
devices that require such logic, so I'd keep medium and downgrade the
security only when required (which will probably need to restart the
listening socket.)

> +
>         server =3D g_new0(struct input_server, 1);
>         bacpy(&server->src, src);
>
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
