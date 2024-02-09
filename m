Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE518053
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517593; cv=none; b=m/1WzXpwLQBMKL0Dgn2VHnLcTV37axrgygDw7/2QmdzqKzOLlN3b68pAYPiq/KQlewyOWASHLEt8YDpDEYYB7Twza9zOTc4Fq8XHaT1C41dyUvQWJ1BmJ5wE1S5Ytu/TxsQz4xXzrQMQMaNHU/TJffYSIoRUKCTUNui+EpzPjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517593; c=relaxed/simple;
	bh=rlVibRiToNgPfjQMq61TMyd39hrkllubuJOM+CuTrMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGO8t3O7HzuJSry9hvdOvqjNGZ2yzISKZ6ysrNNNBaK9gmUlcpTgHe5Iymc7ddfO1oece8pcjLtz9t7X0zsJf+y0vlZ4xhCZ7+8BEDMUne3abhEC7rW3kOBYYWIJC6HyNWRogb3OjXjhM/VvVOf/euMeiZR4JujWXdVo2P6Vgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itkUUaiq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itkUUaiq"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso19800531fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707517590; x=1708122390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNEcaCZxQZ+bw4Mp9bhy7HBjHs4E/5k2xUYBag7ipE8=;
        b=itkUUaiqz5BnkRjQaydAXROPniwxvnoEs4KqkCYaEKFUFHcSUeEWmDKjRWg/KLsJT7
         0feEr4cvpHzyRbFUd/zJxPHe3+cHeijPdE/z52B81GIFpA85sN3gFWCRh17OH8ynaz3z
         2RuqzNZbuPljgmex/zxgiPwcpomjtEAHbeqaAHph7+y6v4xcAyfxTVdpBt6R4BBgYyOJ
         GJYlNsedAPlJlUOrPD+UKpwz9GcUjhxryBPwF5iZ7RLt68Fsveanyu1xpARBiJmuPHbE
         payDSNuxqQ+aIIx/NPGAgeO+C6jYrY1XXClkuWCxnPGkeVB2HBBr1AOimbgkMfXN3i1T
         Wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517590; x=1708122390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNEcaCZxQZ+bw4Mp9bhy7HBjHs4E/5k2xUYBag7ipE8=;
        b=VnLBXcm9D9qtpJ4KinSel+vF2HZvhVXCSAkUcdQH8uFe9BCwLZ5xbIIvkc8Y0O2sWL
         Gw1n4TT5ZlaEBnJh3cvvIcHGTGQj4fk0ibO1moulNLGAEfnW9xTNh52gDJhj1uGRDYTg
         Qy5Kl61gLPAEnGYdBCRQaj/iRnO0mRJ5lX5f6AWwdgyThWpm2FqEL931iFYRxsupNb4c
         k79es6R5OI5hGvun6N+I9BysdeFYv6vD++nAeHkjd6R+efM/YrH9x1oW+yKlcDn38AAF
         Jz7wr5t/oZYS6YZdMLd2ftKSfbhtWXD8S1KY4RD0xMQiYg568foHQ/PEFtMNkGmYeUSc
         4t1w==
X-Gm-Message-State: AOJu0Yx2x75Ci53pM8YdLrL9BrwzR6si6tAJJVCTFtZg9j/EfxGgM+Sn
	aTx65gcGTqi5ps+dMrbPI19tRbiTpNJQFjD3GxByEoUcTHX3S9nEP5CQuO7tpIfJhk1eRG0mTQC
	ZIB1r9ZdMuluex8QFhug8xRdGQDw=
X-Google-Smtp-Source: AGHT+IG6YxWXMSH1zRWmrrA07aNdSRK0I44btPElFgWd7SJTVZnrofojKzfmsslDKLAN+rqk6PAa9henImyDdBEuGFc=
X-Received: by 2002:a2e:a787:0:b0:2d0:a35d:4418 with SMTP id
 c7-20020a2ea787000000b002d0a35d4418mr254174ljf.16.1707517589957; Fri, 09 Feb
 2024 14:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com> <20240209164630.92208-4-andrei.istodorescu@nxp.com>
In-Reply-To: <20240209164630.92208-4-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2024 17:26:17 -0500
Message-ID: <CABBYNZ+RtEWtsB3Hq2L_DrL7Pgk66fcMF-5q5sJ-Fb8ph3oBGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/6] btio: Check for non-zero qos before setting
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Feb 9, 2024 at 11:46=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> ---
>  btio/btio.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index d30cfcac73ee..5a07f91c7d61 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -5,7 +5,7 @@
>   *
>   *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
>   *  Copyright (C) 2009-2010  Nokia Corporation
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   *
>   */
> @@ -1981,7 +1981,9 @@ static GIOChannel *create_io(gboolean server, struc=
t set_opts *opts,
>                 if (!sco_set(sock, opts->mtu, opts->voice, err))
>                         goto failed;
>                 break;
> -       case BT_IO_ISO:
> +       case BT_IO_ISO: {
> +               uint8_t zeroes[sizeof(opts->qos)] =3D {0};
> +
>                 sock =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO=
);
>                 if (sock < 0) {
>                         ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno=
);
> @@ -1992,12 +1994,14 @@ static GIOChannel *create_io(gboolean server, str=
uct set_opts *opts,
>                                  &opts->dst, opts->dst_type, opts->bc_sid=
,
>                                  opts->bc_num_bis, opts->bc_bis, err) < 0=
)
>                         goto failed;
> -               if (!iso_set_qos(sock, &opts->qos, err))
> -                       goto failed;
> +               if (memcmp(&opts->qos, zeroes, sizeof(opts->qos)))
> +                       if (!iso_set_qos(sock, &opts->qos, err))
> +                               goto failed;
>                 if (opts->base.base_len)
>                         if (!iso_set_base(sock, &opts->base, err))
>                                 goto failed;
>                 break;
> +       }
>         case BT_IO_INVALID:
>         default:
>                 g_set_error(err, BT_IO_ERROR, EINVAL,
> --
> 2.40.1

This is probably not the right layer to do this since btio doesn't
know what can be consider valid for BT_IO_ISO, specially considering
there could be different QOS settings that are not for audio streaming
in the future, so Id suggest to move this on top of btio, perhaps in
bap plugin.



--=20
Luiz Augusto von Dentz
