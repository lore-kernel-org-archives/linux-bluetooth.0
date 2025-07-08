Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0511F956
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984483; cv=none; b=W4D4cDzN1kTyuOIJ30R9/HWP4HC5I6sMjNx/DmiXreAzj3zwwYIBSd0h4lqbi9lW2XX87tPO7OFoWdmhwQamwvkvTQFaDBunhPZWr6TEw5cm5LZ7wWbkZlmLAi4nkn3zpjNEPpiTwPi2aVjZKg2vP8glWT2Z018iOXHkLKNPkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984483; c=relaxed/simple;
	bh=XypMQX8NtvDvkjrryEhppPO1f9r7N6NOKfe3EUMOSWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjpFGdFTDGROn0RR9gHn9I/m27TvvBMDj+/f/gmKB8U/jCSZgwlSZ2ANZnwegeVSeKmkccqnfr57y20eyu1/gLHVETFArP2jI/n9yQ2ir+RpxSKz/FBUOdyukcSTC+ij0Q2GVa6dZyH6iZu+qQDvQyTimdFLR9pP7UpsBo/pfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlDygqlU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlDygqlU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so3874691a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984481; x=1752589281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WuvMtp6phKvrgJEGiYARjx+Vu4dN6ZrQYGGg40jm28=;
        b=OlDygqlUAfYgZSVV9lRPaaBizetTN+hb1ygnEy76YnnU29jdsynJ37Lsoj47Cx87XM
         JoVU8TQm0Tb/vQoOkk/Caie3lAJuiefrsJqMh2WdSP8y72qRmP8Sqf75OLz5CPPZyHt/
         UEwaM1xFpyYF9dN5KZK6Pib7vxuMgb2riEVTaSKvNZVtI+N1mFgRpGVCADv/ZRjQ2Ozq
         3rm1FTrwGxfWJL2J5V0s4icQaEi6Cdtp9Rr53aiI1oTq0oQdmjwG39GI8dckV9OGey4i
         pEJtD3Jtgcqo5X0s7kYW+ZBA2Yfq7Y30oEQWR0Go4dtPo6k+BS3syTE5MK9GM+1CCfIc
         5qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984481; x=1752589281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WuvMtp6phKvrgJEGiYARjx+Vu4dN6ZrQYGGg40jm28=;
        b=l2n/EzYnz0N868tpVgRt7nY4heY002ThV0IkudBEW6adJvS0h217pV9f9NCOnYDJ00
         v7MEl8241n/aagmsjjaTfpQx++ii8N6y09Dh6nDAPXvOjNtmn176v8JGWTQ9QbfXQ+/L
         RyDsCrECl7SuYpKxCT2tOv/Rm2b27YfLRBdbnh9WbhP/rxe7vUuL7rLoYg1qzVvWUPrw
         WXxV3M3phIKh0ERUDlHTNwlqh1aZ3TVDsVp6eUr2nYJhYOBQ5COqi2BXxx97xGzrJOJC
         qLOXsK1Z+3OD89U36kz3TK+TXz0VvZZokCVVobO83mvADdwSlE5mKW55Rkn6XXFdrZwo
         gKJg==
X-Gm-Message-State: AOJu0Yygwco6lBM05ngu7d4eJpQIxT7GMTSH2H47ZJkZxM2iOpdmURZi
	AAkhPnrh1nKddXRZ7c13OjtdMBTldHI8Am8iw7A74WPLpMgzaGNb4pvuSVDj+ooe7pyOsYbwgcC
	f9SCyboM8HAxjOFr6xjscmkmx7sdZeTA=
X-Gm-Gg: ASbGncuLtLTuAGGuC6aDu3kwTjLw41h1kiRVBUbYn+WiMTZs2gukCz2Wdcavr5D4jM7
	0wY9u8YvIcKQdbxaaNuVqraI7MYYOCPdZQJrNRU5M1PRtjgS09xSIZ9m9EoupKvMrD6WmaDON5C
	XePC0cwxI2jsVl6K+P1Ahbin/nICxkne1DlVsNage+Eg==
X-Google-Smtp-Source: AGHT+IFttAXAOvkm5XcJR8yX0mr7lU+LYU4qeYVV1AgxLFehsar6+6k6uHg/juX9+n5Qy4BJQNuQzAQrE7zskEkvXJ8=
X-Received: by 2002:a17:90b:5343:b0:31c:203f:cacd with SMTP id
 98e67ed59e1d1-31c203fcbc0mr4948553a91.22.1751984480963; Tue, 08 Jul 2025
 07:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708110909.2626286-1-i.iskakov@omp.ru> <20250708110909.2626286-6-i.iskakov@omp.ru>
In-Reply-To: <20250708110909.2626286-6-i.iskakov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 10:21:05 -0400
X-Gm-Features: Ac12FXw_ax7Tg6zvn0ZTqWBB-m9BpnN3hzews5LcFzQ2Xt4BZb12vnf8I0mxwYg
Message-ID: <CABBYNZLcLWTGEf2Di9evqTvcjHExPoDBHEXC8+J5LD+aKguJdQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 05/11] obexd/client: fix err condition causing memleak
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ismagil,

On Tue, Jul 8, 2025 at 7:11=E2=80=AFAM Ismagil Iskakov <i.iskakov@omp.ru> w=
rote:
>
> transfer_open returns 0 if an error occurs, condition corrected.

It actually returns a boolean.

> ---
>  obexd/client/transfer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
> index a7d00896f..b078c1f6c 100644
> --- a/obexd/client/transfer.c
> +++ b/obexd/client/transfer.c
> @@ -556,7 +556,7 @@ struct obc_transfer *obc_transfer_get(const char *typ=
e, const char *name,
>         transfer =3D obc_transfer_create(G_OBEX_OP_GET, filename, name, t=
ype);
>
>         perr =3D transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 06=
00, err);
> -       if (perr < 0) {
> +       if (perr =3D=3D FALSE) {

if (!perr)

>                 obc_transfer_free(transfer);
>                 return NULL;
>         }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
