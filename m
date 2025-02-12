Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A8271814
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375218; cv=none; b=EEA+j7n9cr8iJXwskSzsvzsaTVbyAQQLM7ZVWYDo2bkO11yofkxXZIjIcTN30NQgreCjrVxLDiqooY/qN9QQtBrhEnvpyHtln7vajZch3hmn/ZVKb1CAYcFwSv1u9Mbdz3fCsUcT5hySHUYhyrVz66m9p9hFg/4KJdEuMJ/bGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375218; c=relaxed/simple;
	bh=UhKQb+tB0oEd7jrDLThFIQ0BE0DDlNWTZ4GJcllf93U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEGx4eokG58jrmmOgHcGEBxdHgYWSTm5mmLvA9jHI/kCPFMPkdFgXjgzoDbyAQeb3Ra1D/a0xxlLFEaUy+ZgKOuFVl7z3PDxn4JfzJkHZlhfVLCh36/Jn9kNbTnBWO591F1lidMzWDfHXHn2RaOdfhMXNSbSMeyrf7usgpStIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEq/8cf+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEq/8cf+"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so64626121fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375215; x=1739980015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcpI2szMjZih0pOkifWyYCN7nM+72u9q8LofhKSnDhk=;
        b=YEq/8cf+SLPj7iJkiUb+OwXseUj1pw1PrI/x4ofyb97X69GVX+gQGF6iVTQvVI0ByO
         1AlGW/VwFRz90d7NwiszR/kfEKgZ23IZ18W3eYyoaMMrBKUE1X6omj1OAn0MRjmECbKe
         4B+1QOvwgl7RKchzpGhACZN13THRUKTBr8OiiLVEePnU/w+aoiaz/G5lFNTxjIl9uHiS
         MIiAUqTk69V25sqtbSeqtgjSglxFtEZBB6w/Vo6TbDq621Zk7HUqD+M5kzhhxC6FAKhI
         DeaGoqaGxGHk1dvmEVE9b8Yfy23mG3qLUc3KXjSZcZ8ywvxoC1jyZc4CqzE1k11gMo9g
         bHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375215; x=1739980015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcpI2szMjZih0pOkifWyYCN7nM+72u9q8LofhKSnDhk=;
        b=OkRvsyBHM6VaSKPmTrbIyxZuB7RvDokuIg3lG/32JGkmU3HbIm5dwMmzn+Et/Nd86R
         x6IRsy2TEcVrw8rEWsK8MgS4IhOcMNXAJCKQhogPa+8ikg0uSaizDfG3ny98IfQF6dI7
         hsmDwxrttK9fEDkYXoiUHKdAR1borSAHaHlQkLIv8fUHfLpPrhJgnUTrKyT6tnsVEHrJ
         OaLTBAOeu4brNq4v8zZ4RUBOw/uJd22OwIQnC6nnu1n4Y2C1xiACZKJt4XdiOOgvHYWz
         7cLI150cGARIreAup82/V1xNbfOj/wH0MmzZfNgHw65KnrKFJ/H07winjUaOhdslfO/n
         hMYw==
X-Gm-Message-State: AOJu0YwJ6fZoFhLJsvh4PwL48h7JKr0KFyV4WoyMFOubVghhTcw1KqXs
	ndfuEd5Njua1DhEbNKE7M5JDYxncF5RkEWQnJfqPyX0zE9KRsAW10FE4Q2pvDIeScFn3cO1kuin
	9OHnaJ/2LUf4l1bZH1P6kIDPMPrfiIdKaXas=
X-Gm-Gg: ASbGncvPf/7FjU0Waw2uLMMkosMZPW9AyoBDTD37AT+lgLrLhHHicBEuePWUU/NjRiD
	9tCDgu4LTJ55DgSzJyzLHc/58feMv3AY9E4AZ3ni/4PPS/NdnapnAZuuVn3u2Im1uGvV6Lv8=
X-Google-Smtp-Source: AGHT+IETZ0TDZNppuRBo3XGH2Irz68ajUcpZ6zstq49vBmhdrp9TlDR5flM1qkyZJ8PvRVU+lkEg6coCL3jO2vP/7Ig=
X-Received: by 2002:a05:651c:210a:b0:307:9555:dc5e with SMTP id
 38308e7fff4ca-3090362f933mr14885681fa.3.1739375215054; Wed, 12 Feb 2025
 07:46:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com> <20250212135209.129361-2-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250212135209.129361-2-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Feb 2025 10:46:42 -0500
X-Gm-Features: AWEUYZmfY1qyc1eOSNq5ZLcFHTrtaYqNZAGb7XApZphBXvB8kXZeX3qNorkKjIQ
Message-ID: <CABBYNZLwMEAQSP8WviAHgDSXmt-vYg4DchotpB=skx84xKv1fQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] test-runner: Remove the "-nographic" option passed to QEMU
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Wed, Feb 12, 2025 at 8:52=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> This option causes QEMU to redirect monitor and serial to the terminal,
> but also it modifies the terminal settings and clears it before printing
> anything. Such behavior might be annoying because it might clear some
> warning messages printed before clearing the screen. Since test-runner
> disables QEMU monitor and redirects serial to stdio in an explicit way,
> the "-nographic" option can be dropped.
> ---
>  tools/test-runner.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 77c89f3f9..13a5de465 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -212,7 +212,6 @@ static char *const qemu_argv[] =3D {
>         "-display", "none",
>         "-machine", "type=3Dq35,accel=3Dkvm:tcg",
>         "-m", "256M",
> -       "-nographic",
>         "-net", "none",
>         "-no-reboot",
>         "-fsdev", "local,id=3Dfsdev-root,path=3D/,readonly,security_model=
=3Dnone,"

Are you sure this won't require changes to tester.config? It seems you
have the impression the test-runner kernel image shall be compiled
with distros .config on top of tester.config, that is not how the
likes of CI uses it though, usually all you have to do is:

https://github.com/bluez/bluez/blob/master/doc/test-runner.rst#kernel

So we need to confirm removing -nographic doesn't end up breaking when
build with only tester.config

> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
