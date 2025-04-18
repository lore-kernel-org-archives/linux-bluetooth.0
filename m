Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617913790B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990541; cv=none; b=KbRSXzWDZItJT/sI2A7Du4nKvezjPuSdc29r2bPnEYpTuZ4NTSpM0KXUx684VVAXpOG6fAjJupKKM2JRMQrsVtm9Tt6/I7tJHiUCGRfXZlODnoUgFwjOS8JQfPAwgbNOxMZsVYl5ItMey1Uc0Il8KjGwj9eLIO+TwLwYdjjNHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990541; c=relaxed/simple;
	bh=Q1spznY7yByxjE8GUbM1IWtazKXdSYy1cT16Y1O57Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9F5HJevxlGiqdPg5crjDpUP7pC+8eJkpWMSirMOb8uKtlT4358Dt4wCMyTUIddhIXcdzPcPxU215K0TQla6oIq4TD/+Ip3ucpteYiEMP6QJkx5zj43VCTNSmbWIy/Qpk2gkmd0RUnFUOHlffGJbHKUSIh34cJ3LAImfhmkwafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3JxG6Qi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3JxG6Qi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so14781411fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990538; x=1745595338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP4WPqZqpU7Nj/dg5Ti/XXmK1Ts/yZx1ZJfoZFvjfxo=;
        b=U3JxG6QiQ1HvujN9LClTjeqOesqrVQ+1FlstJB48OG2dpMJwaJM8dPL/Rhxa+iVJpm
         C1UXOAUdJbdpzUQjjwLClHhsoThlIGow8ozZ8qqMUdjrPTpkh14CsdBNlggwLpVjyj0D
         dmJhdRYIzQOKmEbGOIAVpOXSMeGItTUSF3tk/Y4W3cCpT8iUcKqcfUsOOHnACvEnGJfh
         2+EDLh8sdmT0ubcRX3OAqxdLN40IgpVASNcjVAiDEUs4RXqmfX8PSGO2YRbZHC7ev6vl
         CltjX73WMEGrI4e7vA4gpT+SG/FhhNGrJWv7CY7JImzl0Wz2V1+878VL7C1qFE2j1yqP
         +odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990538; x=1745595338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP4WPqZqpU7Nj/dg5Ti/XXmK1Ts/yZx1ZJfoZFvjfxo=;
        b=EVenlNCz0we0Yp+9ziAgnwBZAM/TfZTJ5VaYuuJp2Hq9FHTbTtz/thV//pwtTB7FRF
         c20QuPqZZCj08Fp4TizuRtAvNRPWOvAp1HTDOdXUfsUiz3ErPpBo+eu+Y/f5nee5u0Ju
         qnhJi7kwJ4RtTAp3wbO1N9rLGvSiDd13DnvQiNDn1PQh/eF2cC3ees596kPNf3Kf/asv
         wXJsBF/10vY7eq/SFDVQAsLUU1J8uyhFID9wkrZ1VQM3hMwR4lHoKrgoBw1Fby5IE/KG
         XSL6ZUYIX0NlyZ790xTci+gfUYPEb9Wnz9HPTH3HKNGbHUwVk/pngFO/wLP2yB87vYZO
         wyXg==
X-Gm-Message-State: AOJu0YwX/LiS3Rp4ELhACk36/oFDdps5G5gG5OY9HnzYMLXdLaABmYN+
	ilgaRgjt11OZmD9w4VRYGeRHubRfcXjUlKVKeEbwDhgvQSxv2IXIiGImWtbebhoVF5Tc4/U+VwA
	0D46cE7ykxdhh5CPfjI7fgRA6DjTZep2v
X-Gm-Gg: ASbGnctgDPgTdLOZ9m+KwPaJz0utpUFZwok/V6x5FIL8c/01zhUXYuUKZPBgLWQX6fU
	iufzPw0ruDtXvImu+enxm3vug8q0NAgHDZJGfFZv6OeNuvQfFblYwtJ6NlXzVG9TJS4pAaz2LnP
	86jotra4An1g708F0Cu4PB
X-Google-Smtp-Source: AGHT+IFNmc3xt+a9qmCMSD1wsegZpNoT8CrpsHR2bZO+p/aMgguNu5GLit3hlJfPiwgm32LdkxxtnJMYct2L5Ngkw/c=
X-Received: by 2002:a05:651c:221e:b0:30c:2ff9:913f with SMTP id
 38308e7fff4ca-310904c9987mr11857131fa.2.1744990537442; Fri, 18 Apr 2025
 08:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org> <20250418153115.1714964-2-kernel.org@pileofstuff.org>
In-Reply-To: <20250418153115.1714964-2-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Apr 2025 11:35:24 -0400
X-Gm-Features: ATxdqUGDFBLsanMFQu2-QF-Nv0OznSSn2HZDVnwBKuUKP89ADsAq-okBaHPxGAo
Message-ID: <CABBYNZ+ig2=VWOwFQvkmZB4WebtY03C9AYktSXLmz6XZHXppMg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] build: add bluez.tmpfiles
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Apr 18, 2025 at 11:31=E2=80=AFAM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> Systemd tmpfiles ensure the status of particular files.
> Add a file that bluez can use in future.
>
> Distributors should install the new "tools/bluez.tmpfiles" file, e.g. by
> moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir}`
> variable.

I thought we would not be adding this anymore with the addition to '-'
prefix and the added comments that should be left to distros to figure
it out.

> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  .gitignore              | 1 +
>  configure.ac            | 1 +
>  tools/bluez.tmpfiles.in | 0
>  3 files changed, 2 insertions(+)
>  create mode 100644 tools/bluez.tmpfiles.in
>
> diff --git a/.gitignore b/.gitignore
> index 108c3b820..e4431443f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -157,6 +157,7 @@ obexd/src/obex.service
>  obexd/src/org.bluez.obex.service
>  tools/obex-client-tool
>  tools/obex-server-tool
> +tools/bluez.tmpfiles
>  unit/test-gobex
>  unit/test-gobex-apparam
>  unit/test-gobex-header
> diff --git a/configure.ac b/configure.ac
> index 1e089aaa7..4ebd513d6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -530,5 +530,6 @@ AC_CONFIG_FILES(
>         src/bluetooth.service
>         tools/bluetooth-logger.service
>         tools/mpris-proxy.service
> +       tools/bluez.tmpfiles
>  )
>  AC_OUTPUT
> diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> new file mode 100644
> index 000000000..e69de29bb
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
