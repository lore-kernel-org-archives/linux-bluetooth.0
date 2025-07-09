Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECB277804
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066680; cv=none; b=Cmq7QnaeAUkTH/3ihTu1vAL/uo1TCqrfWY8W6Edh2iDVfUNgshTQ6EBRUySmu1rQeiy0xXbrkM037gr1PVu21u3IDn1k6sFKQ7EPmizhsARIL+iaxzNEbMkLJGDellSQQid8kJ79sLeh7ygETjdpl+7I8ldHv5zFwtCpi6TUf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066680; c=relaxed/simple;
	bh=FbSNMkOFZejcmGAyPVKeOB5/9Ht8pDSMOWI4aMzk93o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DijVWBmbHY2PRAOnmlNLZX4jNPzRMf/pg+VJnE8ID6LOhrVAgnm0/TfnhhH4zdDpQ+Yqi/ny0N826tPzq9DNFIxrhyyDwfo8LuZCmw/BlBDAaX3ajbI67KgarFII8loLq2vuRniKPZWMiCNgjZU4KtVYcs/YFxTqgiheV3f4kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDnFzdUu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDnFzdUu"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso61684231fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752066675; x=1752671475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGcGBIR3oE0SPnMchqPvxKgn7Avq25ZjScPyWlfvGXs=;
        b=jDnFzdUu50V27XsBVatLbmiSwtgyCsGRuu0FdgZAkjolM1kNPClReO3Ak+JUs9VG2v
         4ZuJGgL1G1T0wmw9zfEPC5kMI/rl6Xf2CAXTTbU6h/4K1MEGr+/9r1pbBtfjwFrW9kIq
         u20CYUYQZw8sF0RG+AojrFHO3N/socG6qY9lzzmWL0jK1k9kd7AgmWl6Dj944gS5eWpI
         g31OB2tH684h5SJZeSQWTenw+gBQdC5fY4ZTbVHXqLYf3d3IQb39WkFsPDhrqhN281aM
         IMaNgKHfMIVvQVBtem+LLsqbUZeLbvnfVezm4v1dBVcMD0JLEU3bLzPgqoC09sBZbUiH
         9Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066675; x=1752671475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGcGBIR3oE0SPnMchqPvxKgn7Avq25ZjScPyWlfvGXs=;
        b=hckZuF0C+QJ5u1qHpo98Yw8SRmH9duxEJVssieCf7UwcQvmSvCDZdWJJtWOt36AQKO
         TmwHJFayyJFjxQy8+5YIdu2zZoWOqSquwLq4cFaCj/b2uhRvk5kNbXdfNlNvdyAif2G/
         yS70ZqryhruW9hQz/aaDAyZzeQmDwq+lH1K6xNNSUCWkaDLZn0a/V2PzyoWrtOQPRGpe
         X2zNxa3LHbUeOcsUSiaWm2lGrUMrHYPH3kfJt3GKbppODByKLK2TIVPCPdLyiOqiZtl5
         +1LwyZc9Pj2oP5d3cP90EK1+6bfpSS1f6yiEm6KCxiHuS1OxAscP+VNUEYr+4fzoNAQd
         QkFA==
X-Gm-Message-State: AOJu0Yyk8Eh3UeVmzFlm8udqyw9Xc4rOHWyjIt4xVPnqI+La8F6uMWZb
	jgRIPnmHlCBJhLHxI5QRMB6Cm6j2vCOk9OGa4phtFQwIq/Czk1Pxyr5g7SUO4DqRgLixqIA3apn
	TIYElLo8fDsYpaoBo/xKQr8zVj0YG7wA=
X-Gm-Gg: ASbGncuQRTyfR41az7rg+GlUPHOCAm239t+gzxiMjsVZez/0Vr4Y+zABQ9i+dmafsEO
	qE995Yq2YRD/9uTur8C+pnn9bAH/fGYneVYaazoZk6pkyiYbFHfHzo5WNfChF0zwsQodIfFlcDN
	r4sGwfySk5Gb8n1os8R+Tn4qX/Q0ciipV7c6AdOZsisg==
X-Google-Smtp-Source: AGHT+IEx7WiFZNa5xZvCdziKE+fHzJT31xaFshtIGO4psldbhF7mW0MocAplQLzE2JGkjoFBPuRFskbPO5qSteBMqQ0=
X-Received: by 2002:a05:651c:1986:b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-32f485a63cbmr6697001fa.38.1752066674503; Wed, 09 Jul 2025
 06:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709094055.516584-1-frederic.danis@collabora.com>
In-Reply-To: <20250709094055.516584-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Jul 2025 10:11:01 -0300
X-Gm-Features: Ac12FXzsiSQPFKCGii5W2XXciif8inpktZ5uKz5f6heX0B7TJte5uZlLfoQ3Hc8
Message-ID: <CABBYNZL1oPd+VYZKiJqz0RM0Rr8oXXmUTxfTeLvkZxyi3RaGbA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/util: Refactor code from strisutf8 and strtoutf8
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Jul 9, 2025 at 5:46=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Move duplicate code to static validateutf8() and fix boundary access
> on multi-byte character check.
> ---
>  src/shared/util.c | 56 +++++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 4780f26b6..36c06188f 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -1909,7 +1909,7 @@ char *strstrip(char *str)
>         return str;
>  }
>
> -bool strisutf8(const char *str, size_t len)
> +static bool validateutf8(const char *str, size_t len, size_t *invalid_in=
dex)
>  {
>         size_t i =3D 0;
>
> @@ -1928,17 +1928,23 @@ bool strisutf8(const char *str, size_t len)
>                         size =3D 3;
>                 else if ((c & 0xF8) =3D=3D 0xF0)
>                         size =3D 4;
> -               else
> +               else {
>                         /* Invalid UTF-8 sequence */
> +                       if (invalid_index)
> +                               *invalid_index =3D i;
>                         return false;
> +               }
>
>                 /* Check the following bytes to ensure they have the corr=
ect
>                  * format.
>                  */
>                 for (size_t j =3D 1; j < size; ++j) {
> -                       if (i + j > len || (str[i + j] & 0xC0) !=3D 0x80)
> +                       if (i + j >=3D len || (str[i + j] & 0xC0) !=3D 0x=
80) {
>                                 /* Invalid UTF-8 sequence */
> +                               if (invalid_index)
> +                                       *invalid_index =3D i;
>                                 return false;
> +                       }
>                 }
>
>                 /* Move to the next character */
> @@ -1948,6 +1954,11 @@ bool strisutf8(const char *str, size_t len)
>         return true;
>  }
>
> +bool strisutf8(const char *str, size_t len)
> +{
> +       return validateutf8(str, len, NULL);
> +}
> +
>  bool argsisutf8(int argc, char *argv[])
>  {
>         for (int i =3D 0; i < argc; i++) {
> @@ -1962,42 +1973,11 @@ bool argsisutf8(int argc, char *argv[])
>
>  char *strtoutf8(char *str, size_t len)
>  {
> -       size_t i =3D 0;
> -
> -       while (i < len) {
> -               unsigned char c =3D str[i];
> -               size_t size =3D 0;
> -
> -               /* Check the first byte to determine the number of bytes =
in the
> -                * UTF-8 character.
> -                */
> -               if ((c & 0x80) =3D=3D 0x00)
> -                       size =3D 1;
> -               else if ((c & 0xE0) =3D=3D 0xC0)
> -                       size =3D 2;
> -               else if ((c & 0xF0) =3D=3D 0xE0)
> -                       size =3D 3;
> -               else if ((c & 0xF8) =3D=3D 0xF0)
> -                       size =3D 4;
> -               else
> -                       /* Invalid UTF-8 sequence */
> -                       goto done;
> -
> -               /* Check the following bytes to ensure they have the corr=
ect
> -                * format.
> -                */
> -               for (size_t j =3D 1; j < size; ++j) {
> -                       if (i + j > len || (str[i + j] & 0xC0) !=3D 0x80)
> -                               /* Invalid UTF-8 sequence */
> -                               goto done;
> -               }
> +       size_t invalid_index =3D 0;
>
> -               /* Move to the next character */
> -               i +=3D size;
> -       }
> +       if (!validateutf8(str, len, &invalid_index))
> +               /* Truncate to the longest valid UTF-8 string */
> +               memset(str + invalid_index, 0, len - invalid_index);
>
> -done:
> -       /* Truncate to the longest valid UTF-8 string */
> -       memset(str + i, 0, len - i);
>         return str;
>  }
> --
> 2.43.0
>

I did something similar yesterday:

https://patchwork.kernel.org/project/bluetooth/patch/20250708174628.2949030=
-1-luiz.dentz@gmail.com/

Let me know if you have any comments.


--=20
Luiz Augusto von Dentz
