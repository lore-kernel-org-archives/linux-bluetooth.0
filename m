Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A138DE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631911; cv=none; b=ddABD09I43mh70Bb5N9gKM+mYgVcUBT4NuScEUi+VsNILigKaeVTIU3M0bgtxIW01OntRheN6LlK/9z8HjSZ4z0hhXYkEX76wf2ZLs1I8f+oLvdt/v4m+L0d602H4XrvpzAe0MU0zbIIpV8C165m/KyaGpqCVA8iBsKiYx5lshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631911; c=relaxed/simple;
	bh=jwMq+h+F3IPSwHFT/od0VKM/A9IxlrlQBzr/HMl7qwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7MPRnRsoRV10vVIorMLevCj5xGzmZeY+2WNH7ng9QJSCdf2EN0hZwiwOKuEzvXFuBvnBBY69d4EPdeFCvNTFUIx1fi48KoDDL/6TKsorlgfUj0iuvHQ95ABCpi03U9G6opbIfMwezewlO7ZewhBbnr//WmPy9nY0Bc2F8J6A1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP/YjvkW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP/YjvkW"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so46608781fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718631908; x=1719236708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ttC+XXy54FOBRiIjxgZ5QEWJgI98BppcpjN67JIKU=;
        b=iP/YjvkWK7f9LNhz7tCxnZnHQO8cJaDf+pqvMItLeaEhym+iq8ojCKn/k8CmxOuL9p
         vyT8Ob61fYpuLToeWWZg2ffE3aj/MFQWcLjrA/RYMQX3lDnDu5LFRa7snnZ6pM0AZ7m5
         CVkKLzZ5DF1KXLpy9SspJzP1mrqF3UY5JAhbW4OXSWvhkLi0cDQ0lj0t0khwRoNx7M2W
         BtjXbPJI2gO4nls3VsVqB6ifdM40CgwCtvCObs2ulAYcMXvWcnvr5wa91jXYjnsvZ+nO
         WKK6SI4+1wBi16Lyjma1Zu4esIs5shVlMWP97LNaWz0sgpGMQlgU1Y+twPX8BDoMiRqo
         rwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631908; x=1719236708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5ttC+XXy54FOBRiIjxgZ5QEWJgI98BppcpjN67JIKU=;
        b=ZRSEY/7QFywf1nevMMK0CUpjG61hT9IWGPuuCdxo3RrttwqPTC5HffQS5KJcfqhwOK
         U2K7gL/0nGWEkHy0Ph37wOKfibdf9MrSDsLabIKFkTWvzxGV1YBVynOqmi2xmybbxk2V
         kcpUt7oUruWeaUQJy7XIIfdVdULvcTQYhgVMxB88p5anv/b8CAVQLtFTvWMsLhVNLz0f
         4lOystBVmykrcB5qkOCii0qUEPOL3z+PoBTleElBtt8r1S+qwh2pOUz5ahJN7CDpLkUp
         hn+hqVtr19ZpRxGs29khyzts8QGiSP0mPTSSX2+asNrvEjXY5EFk5KqRLnbUvVvSgIjK
         9Xgg==
X-Gm-Message-State: AOJu0YxcgjJPN5uiuaJGg9mdIHNzLTFidYREMyd7UYHkuBSxeI3C8JWw
	NZ+63k1Qf4sX8NpkLvveLArx3G+sr12pNmID3EeAW22D/J3xbE33mIr1zwKl/OnXTS2hDnPBzOi
	ItAZvn5WyX64BD9p2WNtkXJg6pliHKw==
X-Google-Smtp-Source: AGHT+IGncBp2++XisHidFokimzGcZEdr87QIJhf+NevRYJPh4vm4Hn5npSA+AUmGSKu84fhlyj3C2GPiZ+4IrzVfjI0=
X-Received: by 2002:a2e:3a04:0:b0:2ec:30cd:fd77 with SMTP id
 38308e7fff4ca-2ec30cdfe98mr14137131fa.5.1718631908135; Mon, 17 Jun 2024
 06:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70a822d15a7e82ec6dc83c4b42e54799c3e45e05.1718457098.git.pav@iki.fi>
In-Reply-To: <70a822d15a7e82ec6dc83c4b42e54799c3e45e05.1718457098.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Jun 2024 09:44:55 -0400
Message-ID: <CABBYNZK3yR9d8qEvsfaJsDsvW-gNRvDTMCPHxA4pax1ib2abSg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: make BT_BAP_* direction defines valid bitmasks
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Jun 15, 2024 at 9:14=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> The directions appear to be intended as bitmasks, as
> bt_bap_stream_io_dir() will bitwise or linked stream directions.
>
> Fix the defines to be separate bits.
>
> Fixes confusion due to BT_BAP_BCAST_SOURCE =3D=3D BT_BAP_SINK|BT_BAP_SOUR=
CE,
> which causes e.g. unicast transports to be in PENDING state after QoS
> although this does not make sense for BAP unicast Client.

Nice catch.

> ---
>  src/shared/bap-defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
> index 2467e816f..75e6950ea 100644
> --- a/src/shared/bap-defs.h
> +++ b/src/shared/bap-defs.h
> @@ -17,8 +17,8 @@
>
>  #define BT_BAP_SINK                    0x01
>  #define        BT_BAP_SOURCE                   0x02
> -#define        BT_BAP_BCAST_SOURCE             0x03
> -#define        BT_BAP_BCAST_SINK               0x04
> +#define        BT_BAP_BCAST_SOURCE             0x04
> +#define        BT_BAP_BCAST_SINK               0x08

To make it clearer I guess we could use the BIT macro to define these.

>  #define BT_BAP_STREAM_TYPE_UCAST       0x01
>  #define        BT_BAP_STREAM_TYPE_BCAST        0x02
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
