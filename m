Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A463839A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517383; cv=none; b=Kwicph4UZG+tjGvtsArBIhVjdiSHCgyxyTFEnJdnVxMvFX1Is5SQTm5EtlEITn7smvoHS3A+Gx3/TnXwZLLCq/8ngqma1+hFy2hkT5KDTCsM/VliAB4qhGJ24qD8zy1QmEbMeXtkGlFzCj8AY/9T0Edj7+1EW3pFmzLdrZcPiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517383; c=relaxed/simple;
	bh=lpNB94J602Nnl1tpe3dkaRdI6tPvhBeH9uH4L1othJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7H9pJ09RA4fxlOrGnsM/xd9BAMqf/0sOJ9ZQYP2orJh+YrYvahjnn2LultCyhc4VQCjm8sD0FXSk8oazSPZBM9qVeGCUpBRt7JQwr1aKFuxCoc4pgGHiUtsB+15G7n0H0b1/fbLiY+u1I4WI8dFoeGeuHGGJjQ40ORH5h1/bcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+f85r+n; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+f85r+n"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d073b54359so19075281fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707517379; x=1708122179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL7uMW0JupjowTRinTzPcx6eUzpFh2dWhEKb/dvfCO0=;
        b=A+f85r+nzctGu2I1+lO/vnuxYj+V3FBc/JUco1x1ub3OKPJtH5TeoEHKxxh3ttfAst
         d1etZ/NyZO4F4MN8yDM3ZwzYLkOjjoJ4qC2XSE4ajz247G9mltK/PFD2EamAvpZ2khr3
         VAbgi6a0kgEwfdlhvAhTxrTadzXhX+AQk4nrhnEZZ8A87yhxirL7uq2HLSWTMO6AEXrQ
         YdL97rmqBFTYLfoGBMQjsjb/rp4ltEhNnIktD6cK4gV9SCdGHGLebLyzUrG7QzVXMziq
         +5pM9hRKyVe7yYf5Fc5UHGkChOczpigBmZw4aTxvZMg/WbfelcTKS18Ug3J0Jq3fM/VB
         6Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517379; x=1708122179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL7uMW0JupjowTRinTzPcx6eUzpFh2dWhEKb/dvfCO0=;
        b=DNFEH7hp0BFfew3aDhch4I8w4cAQea2tMV2Xif8nRfyD2qpcmVU8mEt68hdICoDOed
         xFd5gpF6fE+Sq2Ek3XIJs6bKkan1J0r4ihjFcnfR1lIqR4WxqPb79kbQzQPogYwpvKgL
         ampwTVgugRW04o66DuSCCZaCqv3lYLF++TiIRNdTrFvHAvtTULG3I2/wi3hBOMUAXUp1
         ef094YiL5FXTzw5KQ0uBj+IRZqZekTBGh2blyvjZgJjQiUqiIRjjRuKpHFVZeGLsnx+g
         yljwlaT1MCyvzV1Gn4gNVGzNCQvf1I53hHfUR20TcvD13D7DCol0NYiUK6yzx4lqt/tH
         IJNA==
X-Gm-Message-State: AOJu0Yz7Pim3/HCN6wYOVJjPiEDsa4ocGCJbafmmwiSJvOOWtpiVXM13
	puNnI2RE1eJnP1krj/DBPqoTNssPTVZFR+KqjI/CzeOwXs8uXl+EKWTaPkBSIypApkDPg9JMlRu
	dWbHfWrE+XCmxaSht5RETiQPw/b0=
X-Google-Smtp-Source: AGHT+IHTAJFTCCbLPvU16fUMEBIeKbE2pCiDZZYYItOMeg/qfR0PgI+bezNbVdNt0HTJqgxW/whtfzBtdXF+G4wtbLI=
X-Received: by 2002:a2e:86ca:0:b0:2d0:9322:8d0f with SMTP id
 n10-20020a2e86ca000000b002d093228d0fmr176504ljj.26.1707517378792; Fri, 09 Feb
 2024 14:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com> <20240209164630.92208-7-andrei.istodorescu@nxp.com>
In-Reply-To: <20240209164630.92208-7-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2024 17:22:45 -0500
Message-ID: <CABBYNZJ7s+0V83MCcBqrQFCXvGD+9mJPiFVYCL=zQaEMP1tPQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/6] shared/bap: Remove stream double configuration
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Feb 9, 2024 at 11:46=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> The stream configuration is done in bt_bap_stream_set_user_data.
> This will be cleaned in a later patch.

Hmm, I rather do the stream config with bt_bap_stream_config,
bt_bap_stream_set_user_data shall not attempt to change the stream
state, actually that might be why there are some warnings with bcast
since it no longer protecting the bap reference which is something Ive
recently introduced while introducing bt_bap_stream_ops.

> ---
>  src/shared/bap.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index b88fc60842a3..133711e99d71 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1677,12 +1677,6 @@ static unsigned int bap_bcast_config(struct bt_bap=
_stream *stream,
>                                      bt_bap_stream_func_t func, void *use=
r_data)
>  {
>         stream->qos =3D *qos;
> -       if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
> -               if (data)
> -                       stream_config(stream, data, NULL);
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> -       }
> -
>         return 1;
>  }
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
