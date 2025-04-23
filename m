Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0D27CCC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420225; cv=none; b=frZVN7ir8KRDm2e+CULfhV8w4ABh1Q2TlaiSBsOx2hVKi7gFMVIZr9CVIIHcuqRsLTNeGOPU9PvYGAvWcw04tQtww1uzsxKhHlZMFy6k/NSiXNhKFmg88qG0aPPKeX0TpzJ7sNlbWiJ6xYjSnEEra6bnN1kaFiPcaH7ocB+PljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420225; c=relaxed/simple;
	bh=isa7LrRm/EsTQaAERBg/W19ZZbcw/Lm2RaRRwmJK3bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc2MzV9Q57YPXT8HY4QCSnpnjPFN5GnmZRNImtAVnIIqNqH/7vyraIlPzbx7Qt46VzVx6khvX4EjJ2v93jVz89AF8hV42McN/gUOF/YqRacWb2UWbHZIHTnoxu60dxOShAJt3fbI2YUJg/Gtv635b/dKwVDsffdWTSMYOVegE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWDWaFB9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWDWaFB9"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso59744301fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745420222; x=1746025022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjtwVEdd+onpZ99Zi/rcvpS5kFsPXrZsDoMRvoQW8iA=;
        b=IWDWaFB9SGGwUX3r99u89lzz3vhqo55SrCrQVMFrgYs6AGJNCk5XByuGWqIUXWjjHZ
         MDV8Me2Cz9bDMETdaZEOu+dr2V62VwLRk6RVqjj/NYTY0nKOFDw7IqTg2gVJvtHnt8ku
         4r1fAXmEHN6nqfoH87Soah1D6bhmeBiTlk+zcC+e2HJGkyr0GWtek8oFftY3MauKhGOe
         4GccXL+afvKcQBW1oJnwWNRbK3RPQUxuTBskssw411X3cgoM5MKIEYeZW/BEHm65lIkI
         k/BbrDfSYewieZ78tbVNkWE0ul7H2oI1FtU77d/UfAmkkJD/jSvuyb9Ps3yeFnzPpJwM
         KY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420222; x=1746025022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjtwVEdd+onpZ99Zi/rcvpS5kFsPXrZsDoMRvoQW8iA=;
        b=ttNNJkSXVhmWIiOmDv13HGAn3xGkB36rBgiRyyA+m2dboQarVjL1aQRat10qST/czG
         3oxkX5SmaeXxfaWF51pXn6k6Oy+izP+zix/1BKPAmlAVgVJFMpMyxJ5nGz4+DNIzU21L
         ubp566/Enh7/ddfpWRfdSLrt8BR9E+yMsAjpHnbVgkU9tCrwnpx3Z7PYcfSwpPXxSE0V
         82K7TIQ2g5RVypuaJGGnTuc2IxpzJHm1Ac20fjBpwHsGVRWnrAakmbTW/iYd4idsQ/Cs
         thTjD2ThQTy+xDrMybiZDDcD/BHgDmEwGDIVaoZbGf1Cpkjd8NMVBahgX8yn6tGnXXr7
         R7WQ==
X-Gm-Message-State: AOJu0YzONCzua9RaooI32aeBffi/+P5eHvFytPQK5vam0V5Tzk7YPKIq
	JNYbEVYmd6UGrR1wtWeiXkJzErJJEJbkBu58QgbR+r/jclG1V7unbEcirb4C4Ars2V4D9zVwlXL
	Tbk4wxO3cOVbLIqyouP4wFrD406gFT4Q8s0I=
X-Gm-Gg: ASbGncurGWCfKKi2KgXjBqmEoJlqPVMS0OJeW5G53ar70FLylJ0ITKIt6fQtJqB9Dyb
	hf0xlf+J/M8FvLxFWn8eWPkxDQDCF4upainRyTrLttGZQlfmqQO4BnyoezVT57ONNJxg14akktr
	K+OE9tA4SSUkgyWtNyOuBI
X-Google-Smtp-Source: AGHT+IFSopVr5mnALdztNgQPAvCmx+vQcL+nCy2KHWb6jRiR7ypw68pUz8N9h8+SM4hDLKfdpr6mQz3kDnl2kIumFD4=
X-Received: by 2002:a05:651c:2127:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-310904c7dd0mr66475001fa.2.1745420221520; Wed, 23 Apr 2025
 07:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423144020.358828-1-ludovico.denittis@collabora.com> <20250423144020.358828-9-ludovico.denittis@collabora.com>
In-Reply-To: <20250423144020.358828-9-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Apr 2025 10:56:49 -0400
X-Gm-Features: ATxdqUHWc-Z6lNgMfnyykk28nU-wkHjZaGIHa85pKvAGcA1ZNFVsk8ekvvR5llw
Message-ID: <CABBYNZJ4+=zmArfh6bckzH-9z0HwV9besE1xM3OcjZbSh+b=1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 8/8] input: Validate the Sixaxis HID report descriptor
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Wed, Apr 23, 2025 at 10:41=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> Given that the Sixaxis devices can't work with encryption, i.e. they
> only work with BT_IO_SEC_LOW, this makes it harder to notice if the
> device we are talking to is the expected Sixaxis gamepad or an impostor.
>
> To reduce the possible attack surface, we ensure that the report
> descriptor that the device provided resembles what a real Sixaxis
> gamepad should have. E.g. it should only have Usages for `Joystick`,
> `Pointer` etc... and nothing unexpected like `Keyboard`.
> ---
>  profiles/input/device.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 9f05757a6..6f538759b 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1062,9 +1062,72 @@ static gboolean encrypt_notify(GIOChannel *io, GIO=
Condition condition,
>         return FALSE;
>  }
>
> +static bool validate_sixaxis_rd_data(const uint8_t *rd_data, uint16_t rd=
_size)
> +{
> +       uint16_t i;
> +       size_t data_size =3D 0;
> +
> +       for (i =3D 0; i < rd_size; i +=3D 1 + data_size) {
> +               uint8_t b =3D rd_data[i];
> +
> +               /* Long items are reserved for future use, HID 1.11 Secti=
on 6.2.2.3 */
> +               if (b =3D=3D 0xFE) {
> +                       DBG("The sixaxis HID report descriptor has an une=
xpected long item");
> +                       return false;
> +               }
> +
> +               /* Extract data following the HID 1.11 Section 6.2.2.2 */
> +               uint8_t bSize =3D b & 0x03;
> +               uint8_t bType =3D (b >> 2) & 0x03;
> +               uint8_t bTag =3D (b >> 4) & 0x0F;
> +               data_size =3D bSize =3D=3D 3 ? 4 : bSize;
> +
> +               if ((i + 1 + data_size) > rd_size)
> +                       break;
> +
> +               const uint8_t *data =3D &rd_data[i + 1];
> +
> +               if (bType =3D=3D 1 && bTag =3D=3D 0x0 && data_size >=3D 1=
) {
> +                       /* Usage Page (Generic Desktop) */
> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x01)
> +                               continue;
> +
> +                       /* Usage Page (Button) */
> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x09)
> +                               continue;
> +
> +                       /* Usage Page (Vendor Defined Page 1) */
> +                       if (data_size =3D=3D 2 && data[0] =3D=3D 0x00 && =
data[1] =3D=3D 0xFF)
> +                               continue;
> +
> +                       DBG("The sixaxis HID report descriptor has an une=
xpected Usage Page: 0x%02X", data[0]);
> +                       return false;
> +               }
> +
> +               if (bType =3D=3D 2 && bTag =3D=3D 0x0 && data_size >=3D 1=
) {
> +                       /* Usage (Joystick) */
> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x04)
> +                               continue;
> +
> +                       /* Usage (Pointer) */
> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x01)
> +                               continue;
> +
> +                       /* Axis usages, e.g. Usage (X) */
> +                       if (data_size =3D=3D 1 && data[0] >=3D 0x30 && da=
ta[0] <=3D 0x35)
> +                               continue;
> +
> +                       DBG("The sixaxis HID report descriptor has an une=
xpected Usage: 0x%02X", data[0]);
> +                       return false;
> +               }
> +       }
> +       return true;
> +}

The code above shall probably be placed in the sixaxis plugin, so it
checks if all the reports is proper and only then set cable pairing is
complete, so we don't have to check on every connection.

>  static int hidp_add_connection(struct input_device *idev)
>  {
>         struct hidp_connadd_req *req;
> +       bool sixaxis_cable_pairing;
>         GError *gerr =3D NULL;
>         int err;
>
> @@ -1090,6 +1153,14 @@ static int hidp_add_connection(struct input_device=
 *idev)
>
>         sixaxis_cable_pairing =3D device_is_sixaxis_cable_pairing(idev->d=
evice);
>
> +       /* The Sixaxis devices must use the security level BT_IO_SEC_LOW =
to work. */
> +       /* We reduce the attack surface by ensuring that the report descr=
iptor only */
> +       /* contains the expected Usages that a real Sixaxis gamepad has *=
/
> +       if (sixaxis_cable_pairing && !validate_sixaxis_rd_data(req->rd_da=
ta, req->rd_size)) {
> +               error("The sixaxis HID SDP record has unexpected entries,=
 rejecting the connection to %s", idev->path);
> +               goto cleanup;
> +       }
> +
>         /* Make sure the device is bonded if required */
>         if (!sixaxis_cable_pairing && classic_bonded_only && !input_devic=
e_bonded(idev)) {
>                 error("Rejected connection from !bonded device %s", idev-=
>path);
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
