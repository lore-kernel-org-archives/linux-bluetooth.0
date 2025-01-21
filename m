Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43B1C36
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475545; cv=none; b=QBYJ4kiYjK0rIu0EmuFAPi3126YraF0IT3WnebWDLzpjNM2lJp8z+pqEm2JyGY3v/QSvJGI0+lCx4wmvReh6/n7kFDJV+wHt/qTtuyrSpHkEK5Km5uCj116iZEzBtFHPPVOJg3RrSQEMmfvTYedfsHoqJnHIf/bfA/8VN+JUVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475545; c=relaxed/simple;
	bh=lvcN0NyMjYlNZp/Ia/V6K6vF83DLxyckNNO5MhwZS3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciNfWC2RV6H3h8/NUyGhSmwxlIsiaDLVp1Evfc1GnGgkHJEgCe1iRGCY0pizYx88WM19LilHyMeqcmTh1czQ2O997Mh2HqXNLtd3RPh04R1jZqV/ycSF+AgVpniEijMbvZb5Gq7dbXg5mY26BtvEj4c/Vy4m5O3UOlKKj6z/xiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZKlQ3tz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZKlQ3tz"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-303548a933aso51558401fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737475540; x=1738080340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAo54IHfG8OFoLpyOJ7dfi1/XUsuV17gwJsS82XhdVU=;
        b=DZKlQ3tzNCZwP86DCcATAtAVddUm8wKuIHI4f1OQri7NsWs16C+CqA3tWiu0o9epPd
         2gqbCSBnWVJyvMTDN4XuuVGV5iatD25ZEwO0D4/cwYnlx1+uEsf6StLQtgko5wfdtc0m
         EJMmK4/Mjwt/9IQGk+PpfAWFgawsDCxWBEnLOzyKhA4cy0TRsJWgX+5CW9QQ951KB+9H
         jI20XndgqGH1jzqDy6RjMX68nXA6XVA95qOxyG7h74Ni7mVA5cFldN49QtoSdExpV7Te
         eu0M4kwzW8TdTSnXO8bM/Mt/iPoC/qEEDx5NbB5tg3Np1cHKfiz61T0m1+IvnAMVktGP
         NLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737475540; x=1738080340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAo54IHfG8OFoLpyOJ7dfi1/XUsuV17gwJsS82XhdVU=;
        b=ZM0LN1W7OLX98i0wRMkgJMSTh1IymOkizVLhXehgS/ABZUxmaEZSsg1dfnvyFCTvNk
         3RQe9s2/jP9CtAUNt9I9mjsAWfj4F+IRFJEB/QFTUQIsQ+6FQ49JvIR0TbqVzRrTZWt0
         +y+3yl0yA6XM6iIefPJj1OV0ZYtrdxH6JDLdYL3vXZdFgPcwrsFtALioY2RzahxwLEs/
         nuDKGZjy2FxAWwI+nwdwD9M8Os0WROIrRrstwTgKwNv2s4R3pcl/EoKZzIwHSsZtzdtA
         GS0iqC8WkKCnR5SGpKJkidk2IFYizrhGvHa2InvYJso1L9Kc9yLo2WrODDn5jbbM8/Nt
         bB4g==
X-Gm-Message-State: AOJu0YxgAothvs0nH0kC36kc7S1lSiA7P6NPQFYndBviEUn+Kt2gc5Pi
	lVO7ApIYCpzWkuokcaAiihps8P50weZOpnIGOb51AQuMw71IbhoIXTvb8ZreTiwmR8WOSeDOdu/
	VuHkeiTlP76m5WbvYs0NA+LKvv2v+VAqMn4U=
X-Gm-Gg: ASbGncvQB7WNnxjMREQPAGqpLjYdhA6TAPhQaGD4Y0d9UkR3PTJ2gotnu62y+x/9AMo
	6VWiTNXHmJ5lpUAnkxGo6XJY9PqBaNpcSIpedvPTOQC2zfdPdYmogDTApNpB9CXc=
X-Google-Smtp-Source: AGHT+IGziQqZ72swkKLTCixVjNRVGAWxsHm0J4CPWEzmMpuUiaAGIERGSMauuuNFAmIhZGYcsdrgll8zYRPmfpPvCM8=
X-Received: by 2002:a05:651c:1987:b0:302:4115:acd with SMTP id
 38308e7fff4ca-3072ca99a3fmr65708101fa.22.1737475538253; Tue, 21 Jan 2025
 08:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-upstream-v1-1-7b6e450747f7@amlogic.com>
In-Reply-To: <20250121-upstream-v1-1-7b6e450747f7@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jan 2025 11:05:24 -0500
X-Gm-Features: AbW1kvYsWWZPb448I9jTE_LvNln_UT0TX1URFPaCsUxqKYihZ11zfyS6ehtE19A
Message-ID: <CABBYNZKoszd-3MxmFW9MjMpuVdDsA_mtz8MSVtwMOLcLWt4baw@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] gatt: expand the max GATT Channels
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 21, 2025 at 5:05=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Fixed the problem that Xiaomi K70 mobile phone takes too long to
> connect to CIS.
>
> L2CAP CB Connection (PSM=3D0x0027, MTU=3D517 bytes, MPS=3D251 bytes,
>  Credits=3D255, Src=3D0x0056 =E2=80=BA All Connections Refused =E2=80=93
>  Insufficient Authorization)
>
> Ref https://github.com/bluez/bluez/issues/1033
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/main.c    | 2 +-
>  src/main.conf | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index d13ada2af..e2243c824 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -1119,7 +1119,7 @@ static void parse_gatt(GKeyFile *config)
>         parse_config_u16(config, "GATT", "ExchangeMTU", &btd_opts.gatt_mt=
u,
>                                 BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU)=
;
>         parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channe=
ls,
> -                               1, 5);
> +                               1, 10);

Afaik if we set it to 5 because that is the maximum one could request:

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3, Part A
page 1067
Destination CID =E2=80=93 (2 to 10 octets)
The Destination CID is an array of up to 5 two-octet values and represents
the channel endpoints on the device sending the
L2CAP_CREDIT_BASED_CONNECTION_RSP packet.

>         parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client=
);
>         parse_gatt_export(config);
>  }
> diff --git a/src/main.conf b/src/main.conf
> index 60ab60edc..95de56003 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -264,7 +264,7 @@
>  #ExchangeMTU =3D 517
>
>  # Number of ATT channels
> -# Possible values: 1-5 (1 disables EATT)
> +# Possible values: 1-10 (1 disables EATT)
>  # Default to 1
>  #Channels =3D 1
>
>
> ---
> base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
> change-id: 20250121-upstream-fab070351ad3
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
