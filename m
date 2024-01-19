Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B75467F
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677134; cv=none; b=t1i8eaRU6fIjxR3QFj2d6DWr10m7h8LjKC8yrjNgyGbsVW/ASrDav7zgoGWnG9250dakUT0FU9mE0ZtVgAism8eZB4IDpyb/z+RZ9YKWo2rBzvr227ByljuvATls7qZBkQVdMyBU8ZFF5QDRIA8CrosBMCq1uYoy+knz/g2qlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677134; c=relaxed/simple;
	bh=VeWYgV1pyEyf7jAmLV16uzlDQc1jrQac+asXwi+/gIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak7H1EPs1flhpWRwM3nF6BhUJFZfFnx1k1sFGvIsPh46VoM2jIglMCcpQqOoXRj4NVmTNBGhQXB6EIu1cgmS9mk7VEA/TOKvbnnjb7AqvuWVd58qEKyNjmIrIS4H0eGGSGGHw3adbLFWlmtXpKw/i6tGT8yReSbSaGa7qQqxMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQVGDSHi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQVGDSHi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso9041151fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705677131; x=1706281931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dypkvvb1rjZx1eTM7p7HScF6sNLIWiTPsbmKYQYD3Rg=;
        b=jQVGDSHiMvBTOLZLz+vByRgWSbUEiOgoUYg/zRLe5/1/0uyy1S0BmyIFAdN6HsCdx6
         yBZUemnFkZ/RPbXd09OwC2fJhOSS9lphQ3/eER1GH1OGLnpovv2bq8h+rsmDzOJvPIqh
         tw7U8IjKgNOpNuP5SFpo3om98YhvQVsQTFMwfctytZP0R0ncksUg0nvXxO/fiDvIWU85
         6TGKKUGAY+u3mERAQTIgk3QfhoLXRMWjqdS3UO+vTlCW2OmeQYMTACWtd8xIzvYcmW6w
         DraSf/a9kAyE1teQdti9ac4z4wBTzLyQuuxJjoAX/OpAhzCYbWTovdoyL9yNj8GkC21i
         igKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677131; x=1706281931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dypkvvb1rjZx1eTM7p7HScF6sNLIWiTPsbmKYQYD3Rg=;
        b=K/hjXgx9LIWIg+ild2uDin9EQWpC3tmvCizEZP6R5+3IuijI+tETKbxUfg4exmsD3b
         3/U+Tx5Gss+1rLquTzCGlw3RzBTKyQUqBKSGuELzaQDM4Ka3h6TKLvwayRep/N+2MQ+x
         NfbQcalkmRP81Vh+Zu0ONmHRiVnoH4YQlJG55MF0+qhlzwa729x/t7pAIW1vWKkerUQJ
         Y3jz1zlMJxSgCM02oVxjo0/+Hv9y9bNJTsQa4ONVjXbdJ8T74ABog9eWrBBKJjVHzxtR
         khFgJFiYxFBMDqGhm4SbaRqrmJ6jJzhLr9UGHgzp9iXO6mzxOls7lUxlXKBS9FrT2XEi
         tjnA==
X-Gm-Message-State: AOJu0YzbL4ohqfNSfDy4SVxLMpovYN9GAIngro+27iDJXjAmqfHuZfzH
	iHbeZcj+lTfyvUeTKDxyTIAQGU0U6yOtIXz7hU9Sy4/3VqYWMn6PVpNMH57bDtjjzGSCprxiV7l
	xsrEnGWtPA/bR+TnvEv9UoNg2U14K03Cgcak=
X-Google-Smtp-Source: AGHT+IFz+TUvBreiPegxHvCNXo/OLPbpimufLyLoKnWu3zeU509LMyBUvWFri85oqBUmh1+/0a/E+gmcdGUJJz3IIn8=
X-Received: by 2002:a2e:bcc2:0:b0:2cd:8ec5:87d2 with SMTP id
 z2-20020a2ebcc2000000b002cd8ec587d2mr31238ljp.0.1705677131081; Fri, 19 Jan
 2024 07:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119150443.3163-1-iulia.tanasescu@nxp.com> <20240119150443.3163-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20240119150443.3163-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Jan 2024 10:11:58 -0500
Message-ID: <CABBYNZJduvCkv3F5VNJDmUn1sBDAvV5uXFaTOskc0Feg0xU14w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: Fix bcast endpoint config
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Fri, Jan 19, 2024 at 10:04=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This updates the way broadcast is differentiated from unicast
> at endpoint configuration: Instead of checking if setup->base
> is allocated, check lpac type.
>
> ---
>  profiles/audio/bap.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index b88876485..137ed7d39 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   *
>   */
> @@ -617,15 +617,16 @@ static int parse_bcast_qos(const char *key, int var=
, DBusMessageIter *iter,
>         return 0;
>  }
>
> -static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
> -                       struct iovec **base)
> +static int parse_qos(DBusMessageIter *iter, uint8_t pac_type,
> +                               struct bt_bap_qos *qos)
>  {
>         DBusMessageIter array;
>         const char *key;
>         int (*parser)(const char *key, int var, DBusMessageIter *iter,
>                         struct bt_bap_qos *qos);
>
> -       if (*base)
> +       if ((pac_type =3D=3D BT_BAP_BCAST_SOURCE) ||
> +               (pac_type =3D=3D BT_BAP_BCAST_SINK))
>                 parser =3D parse_bcast_qos;
>         else
>                 parser =3D parse_ucast_qos;
> @@ -656,9 +657,9 @@ static int parse_qos(DBusMessageIter *iter, struct bt=
_bap_qos *qos,
>         return 0;
>  }
>
> -static int parse_configuration(DBusMessageIter *props, struct iovec **ca=
ps,
> -                               struct iovec **metadata, struct iovec **b=
ase,
> -                               struct bt_bap_qos *qos)
> +static int parse_configuration(DBusMessageIter *props, uint8_t pac_type,
> +                               struct iovec **caps, struct iovec **metad=
ata,
> +                               struct iovec **base, struct bt_bap_qos *q=
os)
>  {
>         const char *key;
>         struct iovec iov;
> @@ -686,6 +687,12 @@ static int parse_configuration(DBusMessageIter *prop=
s, struct iovec **caps,
>
>                         util_iov_free(*caps, 1);
>                         *caps =3D util_iov_dup(&iov, 1);
> +
> +                       /* Currently, the base iovec only duplicates
> +                        * setup->caps. TODO: Dynamically generate
> +                        * base using received caps.
> +                        */
> +                       *base =3D util_iov_dup(*caps, 1);
>                 } else if (!strcasecmp(key, "Metadata")) {
>                         if (var !=3D DBUS_TYPE_ARRAY)
>                                 goto fail;
> @@ -699,24 +706,13 @@ static int parse_configuration(DBusMessageIter *pro=
ps, struct iovec **caps,
>                         if (var !=3D DBUS_TYPE_ARRAY)
>                                 goto fail;
>
> -                       if (parse_qos(&value, qos, base))
> +                       if (parse_qos(&value, pac_type, qos))
>                                 goto fail;
>                 }
>
>                 dbus_message_iter_next(props);
>         }
>
> -       if (*base) {
> -               uint32_t presDelay;
> -               uint8_t numSubgroups, numBis;
> -               struct bt_bap_codec codec;
> -
> -               util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_le=
n);
> -               parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug=
,
> -                       &presDelay, &numSubgroups, &numBis, &codec,
> -                       caps, NULL);
> -       }
> -
>         return 0;
>
>  fail:
> @@ -882,8 +878,9 @@ static DBusMessage *set_configuration(DBusConnection =
*conn, DBusMessage *msg,
>                 setup->qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
>         }
>
> -       if (parse_configuration(&props, &setup->caps, &setup->metadata,
> -                               &setup->base, &setup->qos) < 0) {
> +       if (parse_configuration(&props, bt_bap_pac_get_type(ep->lpac),
> +                               &setup->caps, &setup->metadata, &setup->b=
ase,
> +                               &setup->qos) < 0) {
>                 DBG("Unable to parse configuration");
>                 setup_free(setup);
>                 return btd_error_invalid_args(msg);
> --
> 2.39.2

I sort of did the same thing but end up refactoring the code in the process=
:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D817943

So it's worth checking if I didn't break it further.

--=20
Luiz Augusto von Dentz
