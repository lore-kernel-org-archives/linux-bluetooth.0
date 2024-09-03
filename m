Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFF18BC11
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381215; cv=none; b=NMcPczWVZqHc6rCB033lQFvsFj6B0e0GVid6sm2Mj127MiEDuZ62+oKGRSefyxFPjcVDrcT4p83MDEjyE3tGcxtKnWboffdZF1sttigRgilfGFfZbligfndqMFO80SliM+fGCJJ07OQ88FSCO6ssoPHJTizOdOfiP8V3bzdpJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381215; c=relaxed/simple;
	bh=WrAVEzq5/pCHgvGre0DiZa7AcpwKVK4FWrWUQd6JtoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQx3oF7aQHWgsqgZSrUgHG0wXD+JXamoY2v8kioUBFWZuBuhL40T0wSY5c7ZeFMvJShiraB02LlKNCR4tpbay6fpy6aw3tTz8GqVstllUjfa4JI12Wew97GiG7Zmg7xfvRswE02JrztmoaImhA8x8vz++D9devWUcT35DIJtjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEbCSZEu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEbCSZEu"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f40a1a2c1aso53076731fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Sep 2024 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725381212; x=1725986012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtSls+O1UrkWhVgMXxSGEMvM8ffXYVMX97Q6z3Rnu8k=;
        b=mEbCSZEuT+NSPQxa9Wen8sIX1k2TsOLCD441mSyXIEn8iVc6OPvkbHi/RTnwVY5Jkn
         UsBN6Dnonk2O1lxsC6kdnQJjgQoXiK/cjbLOAZ4C2fThd/+Phv7rCi8P0D1JoHwcDnBG
         xL3OZ1qaFMKciLzS0Syq3dOPjbMNrkq11CLHfBRYfu3KGqLmmyGK81B8LUX0EHNbReFY
         9jxaSw1ZjoKF5ewRgJPiHpIKQ5hJGtgllzRNscNaX7c/o65N3Wz6C7OA2t4UwhECoNB2
         GP+r7Ipqod1VnjhixfhW6m0JOcPa6b8MBXJtvpH9qSAyfvWmbeN4ZBLfNt+PS6KGm6/m
         25dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381212; x=1725986012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtSls+O1UrkWhVgMXxSGEMvM8ffXYVMX97Q6z3Rnu8k=;
        b=VJJzHqRcLKHB5u9IzTjuv2jBzBt2+mZvKeUdHvocOWDkM7n07qRYXFwbrJYkAX+yuJ
         Yt2nBFYDVnW6GXCvZoi+26qTurugLT2oc+hqSOYgir25qjpSckLNQyRTKDPRZvpyFYoA
         QyYJQnyOUqPAfUYLFPPHl6pE015aeJMvzsgzEQzje82pqbw8Bn4nzwxG9M//taiTrp/V
         4EwBDbe/t38EaNk/9eg0Mc7dApv7dX06XItE7OrbYHkwwj8gUXp1kqvqC3IdkXRofX8r
         ZcBEw2Nhm1lWYIteKYP6P34Xkxl96/N18qbQGh8aFXKkn1B0evzxw+aEgawoK2HsbuND
         Qccw==
X-Gm-Message-State: AOJu0YyhKH1+yL1Nz5af2h7Bi6YyN6Kg9C002wOtwlsuwVec2gVBoDYE
	V02+EIkmgFS92IME4ollIhmy1kga/oB6s0E7J/Ui16zdjtICcEJfPwr4kkp/NxuBYyHf2it0L41
	9AIsL6jklimxDPL6tInHtdlyp+Q9ltw==
X-Google-Smtp-Source: AGHT+IEIKccx9blzf9llqbKOuINUpgevrgxy7JmhT5OYB9SFfw43fRjjZkmVQUHc0LpDf3/IM6E90ouP90rVy6LvzL4=
X-Received: by 2002:a2e:a586:0:b0:2f1:929b:af03 with SMTP id
 38308e7fff4ca-2f6104f2590mr118510641fa.30.1725381211102; Tue, 03 Sep 2024
 09:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903161115.143632-1-frederic.danis@collabora.com>
In-Reply-To: <20240903161115.143632-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Sep 2024 12:33:18 -0400
Message-ID: <CABBYNZJpz5z-96YaE8U=q2oYG1LkUPjYxc-n-Pm3QH0xWvKKCw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gobex: Replace g_convert by utf16_to_utf8
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Sep 3, 2024 at 12:11=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> g_lib may be built without the gconv modules for UTF-16, which
> prevent to use g_convert().
> This commit replaces it by a function similar to the existing
> utf8_to_utf16() function.
> ---
>  gobex/gobex-header.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
> index 002ba8861..b43374da6 100644
> --- a/gobex/gobex-header.c
> +++ b/gobex/gobex-header.c
> @@ -62,6 +62,32 @@ static glong utf8_to_utf16(gunichar2 **utf16, const ch=
ar *utf8) {
>         return utf16_len;
>  }
>
> +static glong utf16_to_utf8(char **utf8, const gunichar2 *utf16, glong le=
n,
> +                               GError **err)
> +{
> +       glong utf8_len;
> +       int i;
> +       gunichar2 *buf;
> +
> +       if (*utf16 =3D=3D '\0') {
> +               *utf8 =3D NULL;
> +               return 0;
> +       }
> +
> +       /* OBEX requires network byteorder (big endian) UTF-16
> +        * but g_utf16_to_utf8 expects host-byteorder UTF-8
> +        */
> +       buf =3D g_malloc0(sizeof(gunichar2) * len);
> +       for (i =3D 0; i < len; i++)
> +               (buf)[i] =3D g_ntohs(utf16[i]);

Shouldn't the buf variable be freed before going out of scope? Or is
it reused as return by g_utf16_to_utf8? Perhaps we could use a stack
variable instead?

> +       *utf8 =3D g_utf16_to_utf8(buf, -1, NULL, &utf8_len, err);
> +       if (*utf8 =3D=3D NULL)
> +               return -1;
> +
> +       return utf8_len;
> +}
> +
>  static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
>  {
>         memcpy(to, from, count);
> @@ -130,7 +156,7 @@ GObexHeader *g_obex_header_decode(const void *data, g=
size len,
>         GObexHeader *header;
>         const guint8 *ptr =3D data;
>         guint16 hdr_len;
> -       gsize str_len;
> +       glong str_len;
>         GError *conv_err =3D NULL;
>
>         if (len < 2) {
> @@ -177,13 +203,14 @@ GObexHeader *g_obex_header_decode(const void *data,=
 gsize len,
>                         goto failed;
>                 }
>
> -               header->v.string =3D g_convert((const char *) ptr, hdr_le=
n - 5,
> -                                               "UTF-8", "UTF-16BE",
> -                                               NULL, &str_len, &conv_err=
);
> -               if (header->v.string =3D=3D NULL) {
> +               str_len =3D utf16_to_utf8(&header->v.string,
> +                                       (const gunichar2 *) ptr,
> +                                       hdr_len - 5,
> +                                       &conv_err);
> +               if (str_len < 0) {
>                         g_set_error(err, G_OBEX_ERROR,
>                                         G_OBEX_ERROR_PARSE_ERROR,
> -                                       "Unicode conversion failed: %s",
> +                                       "UTF16 to UTF8 conversion failed:=
 %s",
>                                         conv_err->message);
>                         g_error_free(conv_err);
>                         goto failed;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
