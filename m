Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1B138480
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030828; cv=none; b=qYj6pi57AMJ5oJ7Xxvn6YE1pFQsdC130b5QrwPDqx10zUgqS1rw+Ul0WDO9TabkHmXRyJHruAL3JsQC9c1UIRDXUEJ/WJW8GyvBSjUVGwVKTjbsicW3n31Eh2Fw49BlsMWYZjKDYgktcMedeh4jrleSqewnsV+UdamJawL1y/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030828; c=relaxed/simple;
	bh=FyDrokBe4zy+iaDuXE5I/L02d2ggB+7w2o/id94C6F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcz9urErPAX8OD0RlC0fw2DmeTDT0xWcnE2Qdhp5Opo6t9LfhExa0i4FYsVZgsrpLXIqVoAbPoVwApGiFPM1Svk/+db7XI14XXHqtD/CM806fIOyyOeY/SDjJwETypq8vQBLa/squhcfztBDz8X9WxxWxOPsQQUcxQqrGNaFNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+EGBge4; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+EGBge4"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso4032003276.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030826; x=1709635626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6124UVHb7yjBZ1z33/jNDtmli01sG8FE5GBUq3fySCE=;
        b=W+EGBge4dMty0OnksVzHtTZAwBQLJ7ruVO+FUgY5TaK5FD/BK72K0vHBwCOwKSH0wU
         xcy/CMprlpEbyUnCydiNMr2iNqjrbNoDC9X5A/xFMbj3uU+nmdjwgczQqIgjZs1XQoKs
         iVh/j7CH5Prwn9iHnP3hxl6XRnkmkDHEimpdF2fCO1eFSEQbJpA2SWQ637RtX5FHLeSy
         6vICcP0HVLB77p4Fz/hL45c8TanxrALSBH2pUnE31M2kLuLylHJKS8lwv9rlsayOuHfE
         Omj+ylw0mwbj2U3vRodRQxgCsWsIlKSxC8zBsOL0LlxOF5Fr41OmhP7XJbhJUuzz3mV0
         saCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030826; x=1709635626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6124UVHb7yjBZ1z33/jNDtmli01sG8FE5GBUq3fySCE=;
        b=ULlvk1h1G3SMC4nkx+myrFC7TYeMYAlE2jQ3dLcfYSwaAXNn6BjQ4CZNetLOvRjXPZ
         7T609j+g6RUAck/0RmUZs8KJjwdtkGjCNQmu7AxgkmF2ia2wQT/w2gBTt5j7Ynjav62P
         tkOBQTYb9k9VPyy11UO9IZ9NN64A2WemE4+Qxqjr8QyMaXB1BeExZHYPsUMIMCxzCFJS
         ylqjuZDtaAKO2e8HmAUeCjtoMK5QFoetZbSyhgXQ22+Khm4mcH3G0mZ5kAwsaqP3ju41
         kfYUA+Wst6c3/7SUSqE4q9UeC22wbUH8QbsUHA3VZVX7MaXLGjwescWcNifBdy8IJhmX
         9Rjw==
X-Gm-Message-State: AOJu0YxNbOqIpUL+k1SrCNpw11wESh6qsnb8P6Ndm1WoihIDPe3Jgq0a
	EeEAT7bjok/hnXohNuaVlPUmx0tI0do5ICNDeVVgJqjjSo79pwNIy+vVlrRqIzvJnIv3uJIgwks
	6coeawz8geXkV4kJh7VyzbcPfuwUZ87vZ
X-Google-Smtp-Source: AGHT+IFm4j0bMZF7smrTipJhKYbmIeMcFfvtBem4JsltG8zf6VNA1aMR5zUjCjYrYl5s5J8fsBDDI6tWm0Kf1xBK7G8=
X-Received: by 2002:a25:60c2:0:b0:dcf:6122:ccec with SMTP id
 u185-20020a2560c2000000b00dcf6122ccecmr1117776ybb.36.1709030825930; Tue, 27
 Feb 2024 02:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 27 Feb 2024 10:46:54 +0000
Message-ID: <CACvgo53rEdP5FqeGMd+xvQar8nF5KwBmd0G3+fcaRNBsmFjsVg@mail.gmail.com>
Subject: Re: [PATCH] cups: Use pkg-config to find cups backend dir
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: "linux-bluetooth @ vger . kernel . org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 18:36, Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>
> Some distributions(Gentoo) patch cups backend path to
> something else than libdir. Use pkg-config to find backend
> path for cups.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>  Makefile.tools | 3 ++-
>  configure.ac   | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 044342e29..c17244677 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -538,7 +538,8 @@ endif
>  endif
>
>  if CUPS
> -cupsdir = $(libdir)/cups/backend
> +
> +cupsdir = $(CUPSDIR)
>
>  cups_PROGRAMS = profiles/cups/bluetooth
>
> diff --git a/configure.ac b/configure.ac
> index bb6380f2f..778c27a0f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -242,6 +242,9 @@ AC_SUBST(UDEV_DIR, [${path_udevdir}])
>  AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
>                  [disable CUPS printer support]), [enable_cups=${enableval}])
>  AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
> +if (test "${enable_cups}" != "no"); then
> +   AC_SUBST(CUPSDIR, `$PKG_CONFIG cups --variable=cups_serverbin`/backend)
> +fi
>

This has already landed, so fwiw: the patch looks solid IMHO.
Sorry for the delay Joakim - life got in the way.

-Emil
