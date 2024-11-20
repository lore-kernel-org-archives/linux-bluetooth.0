Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D071AA793
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115639; cv=none; b=bHXGGmfz2Z6CgF/KwY/KuVzSk3hWEiM8C8OmzSyz5NWHPh+3d3xVI9s598o/3qgAVkuVhjmQ6FKzOr89dRtTAYrMBlQ9y4qWWhOufdyjwLOzTSzOKjN7oU4Iiirq8LBSpnY4LaPJWosfUnC57nCbk3yPD2HSrGGFulJYAPPOUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115639; c=relaxed/simple;
	bh=gL7ZCooCxZuw4uX3cLwGzs8B+euK8O6BHQdiGCoJmb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6OZ7+eyX+yNsp11D8Fvw7fQ/G9jV9jofkG1swvHhCNYi620IbeSvv+vSyWrdc3+LeEsEWWhT1Esw2qBc1o/K/5MJiMA/b7c1qBoML2g8XU/Ms1+JqZMi+qalBVQzNOEA+9VwHt0XBOiO3C0IaeukkWn9FFpAP6mfl9Vm69Dqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVLqLNEN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVLqLNEN"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso24326851fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732115636; x=1732720436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0uyLOwOPOnyASOtKVtTmvH9ztq8azMSS3wSuRKFQhE=;
        b=UVLqLNEN/NTd0qDfnOP/x/Udp4c52L5iwpZV/X/0SbZ02Sz5jSjcvEnHj+OuUP8xhT
         4PRAWMvM3RcxKbYKmN7hyPX9NBMKP9vZLL0CuY04Vbt8pkokHlMW83Ho2bNFStDrx4WF
         UvhjZgngatg5xkOOQd7KUZ5mgsfUK76fFvrVc4p5840wfGaUp8TbJSqMqci0rIb560fq
         kSOHc7//6G7MshUZp7inGrqNuwsCMZbRW5va4+GZhfQDIIADmXxJCpwqHOalulYvKX3B
         hEmmsyC1aTYZINDvVvNj3ObZJW/5SE5w3QbLaVmKRXH50R4mYMTZM5X2geJ0QRFbUioS
         DDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732115636; x=1732720436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0uyLOwOPOnyASOtKVtTmvH9ztq8azMSS3wSuRKFQhE=;
        b=iHWcwT2Pr2kXz5qfHuf2HZS+0OCDYRAOGB2aDHl4gcdogAYONUUI5sG8qZSEAOA23a
         63S2QPCwJwjfLrMhgK3J0QfhMS2Gtyy2vhqsNm/4xIAUKTUfeX2SlUn0uva0yzzRe52q
         Ohr9OIxQrpgEy8/9ePdG000uja1N1X0KsV5RWMo0O1C8FO9JKT/mK4uJx9ZxEBItb/Jr
         fo0mKXxo2sT1R/JOafd7RCgQvzzzr4qN9v3Rm6IlTnrbe3iWmALc/RGEsZlVhx/lO4QN
         URgiJD3Rch4ntuv+MMOzQtz+OmQcFYK3rWuYZt0Lp5M+ifhB+C0kJ1b/3umpydnnLYRX
         YIOQ==
X-Gm-Message-State: AOJu0YyATp6TjRVHSHBit9p7YJq7CncSz0/P+eSSJUFUK1i5DQiwQWTL
	Jyv/2WuGBtkb5deJlrS8KKTNiQXYibE4Xo88PMfWpgBhCDvbDjLk1Y41BcBXQ0CiLhVVD06Jdz5
	+l+IahHnIDO0K0hMp30cVLZPl33GQIfz1
X-Google-Smtp-Source: AGHT+IEVCnEMl5Rvuv4FSHD2v2Jcx5GJ5KlReZtYkILg+8ZZrdmj3VKtA+t39OjdLr8+VmDg+5QH1EabVaxIWGicLb4=
X-Received: by 2002:a05:651c:b25:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2ff8dcbabdamr20746971fa.35.1732115635565; Wed, 20 Nov 2024
 07:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120144918.11991-1-quic_prathm@quicinc.com>
In-Reply-To: <20241120144918.11991-1-quic_prathm@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Nov 2024 10:13:42 -0500
Message-ID: <CABBYNZL=HwZ1rsgghwF90VyfFVmLJwcT2LJEKK0-T__3N1jBaA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix for broadcast mode, not to add any AD flags in
 advertise Data
To: quic_prathm@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 20, 2024 at 10:00=E2=80=AFAM <quic_prathm@quicinc.com> wrote:
>
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>
> src/advertising.c
> Include check for broadcast mode:
> Need not set flags in AD flags of Advertise Data

Please reword the last sentence to something like: "AD flags shall
never be set for broadcast", also add traces showing what is
happening.

> Test steps:
> From DUT, bluetoothctl go to menu advertise
> secondary 1M/2M
> name on
> back
> advertise broadcast

In case you don't know it, it is possible to call command from
submenus directly:

advertise.secondary 1M/2M
advertise.name on
advertise broadcast

> ---
>  src/advertising.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index bd121e525..2fc6f917d 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -759,10 +759,15 @@ static bool parse_discoverable(DBusMessageIter *ite=
r,
>
>         dbus_message_iter_get_basic(iter, &discoverable);
>
> +       /* For broadcast mode, need not add any flags
> +        * just return true without adding flags.
> +        */
>         if (discoverable)
>                 flags =3D BT_AD_FLAG_GENERAL;
> -       else
> +       else if (client->type !=3D AD_TYPE_BROADCAST)
>                 flags =3D 0x00;
> +       else
> +               return true;
>
>         if (!set_flags(client , flags))
>                 goto fail;
> --
> 2.17.1
>
>


--=20
Luiz Augusto von Dentz
