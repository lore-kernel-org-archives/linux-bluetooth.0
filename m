Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4091B270
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8xndklj"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cca5d81826so126537141fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704297045; x=1704901845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP1LwEXGVG6+jqcPPExxv53V/kmMmjlu4Wk04DA7Ok0=;
        b=Q8xndkljOWO9koTCG+Y3n77J5uwMrqgLFSi6ASaKOyOINPukGFTH2WTF2NaLfgFZ06
         MiJUEOCKfy0rU36jgLPfXdwUqDibRcfWbQG3Q/BkWYbGDgIRcbouoHLGDQjaL1KZPhMs
         XPwGwyjpGFRW8MlXcPO3zeOazQbpGw6ZN2fNu8B3u0wyMy8rCA+YeHCet5k6pZWGmPIH
         3vPrIzLkTQIFjzm1y3edeV1DEIeUtvaE4aQl+RcfPYy0BkdYasqvJWmOy7xxD6ivrQX2
         55/v8ldyeHVERll53vaQuCoxQt0h7SWN4AYoOLww9vplheWRDwTB1i9UbdQLTGJL2Yds
         oxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297045; x=1704901845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP1LwEXGVG6+jqcPPExxv53V/kmMmjlu4Wk04DA7Ok0=;
        b=LO14Vpu5Ch/xb0o6c/j1ASJ6O1Z9RO8KmLFrkPuGoM8MuH0+/nMBl5UlW66PoSu2BK
         eFyNN4pE6Fj5Ma+reaJTCdAyg/3pSri9bSNktbogIINxbquPUffzcdGlfvjWP0GBOj51
         dWg+E4xlmbYA0iEKVbBD6kxG9EFjFGAyBpPCWpRS7Zd8gGPS1PJeP3j6RorcZr/8u3Pu
         bp7GHYJtpJP1Z6/1PoO9f6JzjyehcnKYwMZIVS1j/U3WZ5MthZfMIeQMNfmLD1muIg4x
         tG6Xuytr2aC9r4nGStkTEbpgpmweAj6wTP3S7WH9kfZCfme9XkHRciJCOw6qp856rv3B
         z5bQ==
X-Gm-Message-State: AOJu0YxweM8PLxbfqjh+seX17Ch1WLUXh30kzM+BGzEj6DC6JrayTB66
	vvtT+b6gtzpXH0a1eU75CqXph0/bZQ5fILMbwTI=
X-Google-Smtp-Source: AGHT+IFjg9XgRuTdPJhu0ceLo4KH9/0nlPgEJVPoJGuxVVB8YlSkBZDQMR9j6GWRslEowvYuXzLD9rAYGbCKni8zoC4=
X-Received: by 2002:a2e:5c03:0:b0:2cc:77fd:703 with SMTP id
 q3-20020a2e5c03000000b002cc77fd0703mr8677676ljb.83.1704297045231; Wed, 03 Jan
 2024 07:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103092816.22952-1-frederic.danis@collabora.com>
In-Reply-To: <20240103092816.22952-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 10:50:31 -0500
Message-ID: <CABBYNZJ-pPU=3jFWK8dDWrqPMG_8Uzow5XTxEP7mKnV7OhdajA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Fix munmap_chunk invalid pointer
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Jan 3, 2024 at 4:28=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfff=
d
> and ending at 0xffff.

Don't we have a test for it under unit/test-gatt.c? Perhaps it would
be a good idea to add one while doing this change.

> This resets the next_handle to 0 in gatt_db_insert_service() instead of
> setting it to 0x10000. Other services are added later.
> This could end-up by a crash in db_hash_update() if not enough space has
> been allocated for hash.iov and some entries are overwritten.

I understand we don't want to loop around but handle 0x10000 is not
valid either.

> ---
>  src/shared/gatt-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 676f963ec..d32c9a70f 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -58,7 +58,7 @@ struct gatt_db {
>         struct bt_crypto *crypto;
>         uint8_t hash[16];
>         unsigned int hash_id;
> -       uint16_t next_handle;
> +       uint32_t next_handle;

I wonder if we can just set the next_handle to 0 and then check it
when using it, that way it indicates that it had looped around and
handle 0 is invalid already so we shouldn't allocate anything on it.

>         struct queue *services;
>
>         struct queue *notify_list;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
