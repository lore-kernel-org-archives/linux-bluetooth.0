Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C2132C19
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207451; cv=none; b=Mk0Rfvy/HyoibLj8cpUGlbZovbAKfyBBvgz0gBw/D21aGEAn85ySoATqW53ai2vo3zkyHs+9Ghza417G86oZwBt7idfy3fgHMmr6iam2S2H7ScYkjOl0FtrgkYHaOkbGa8vj/Qvf1snSiOcZz7GBzVCiOnjnsCxslIVivj475vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207451; c=relaxed/simple;
	bh=HygBRgcljnBp1xavNXcVTWq6p0jnpSYwW3u1lVmovv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mupqZea8fzSYY1+WyBfxum30Jr11RXGbY81tAX3D4vk++5NXtPSTwJG7dmI95B9MMk3+U0DtVdpTZ8JgLUNszuVuG+vhsann7stR//Sg0eDsXJIeAoT8ChgKV/vHEPwfnV7ZiUheFRgeBU7HhGli0wbUXZdunR1ind6PmGe7FqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azwmJx16; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azwmJx16"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ccec119587so90566451fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207448; x=1706812248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HygBRgcljnBp1xavNXcVTWq6p0jnpSYwW3u1lVmovv8=;
        b=azwmJx16XZpjCbLGU8Evqz9JatcNV3udP5k1HtHTeVeMT2q3rn3UiQmlJ5VjmAgLlc
         moZxXG6De45NeRwgkes+E9Nq+ktvmzUjeWzTK5UPrkkr7ZGnj6skPHb2KSczDcDqjNUM
         XM24FgMCqF/elnzkfYPgDL6BfNDhwu7AVv9+K/2/opYZ8Yz0BeG6oQRSZ5s5yEwsq4WB
         VQg4WtK7pyWm3wEttQjIguRZ/JpW99e4GNhH6otxSFOqRLBlnmBPa6SNiq17Gph0HKDl
         6fESl9d+TOb27K47/NeABelRuKWBP9fCxan9Mn7POy4GDLvLkIJ+dgOd5Axzbf8ZTehs
         baVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207448; x=1706812248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HygBRgcljnBp1xavNXcVTWq6p0jnpSYwW3u1lVmovv8=;
        b=W4Iyhyvdc8zAnKsrouCXiQENSLsiLCNTCsApCy5j3iAsiVNyRg2PyhYaGO7SLKTCT9
         Nx/J7oNPE5gK2Aph+cj2dsvEifJf5rRRTAdJ83LQ28u35twchrmMWsWZ34hj4S/KmAA5
         XGuWFWf/cGjIoMrBfJaH878RN7nIzOT4Q7GmJugRemLeVQAR2rI17IB2KEQ4TQIr4Lkv
         EMYzsKWZ+pbIiHGL7+IY9gvjjw9xuOspBQ9XzBVuz9qZ16G0T09SUCQkPx5qysByELPN
         9RJOd4iVE0/R6wA34BqT0YlSUO+LK81NILCEOMJGuFs0FPfGcbN0evEKMYwBhog4TPs1
         7uEg==
X-Gm-Message-State: AOJu0Yzi3fLywIb8zJw+78Pj+6nf1EbmkTnrmk3JFPEjypMBmkvEtGH4
	onhXl+Xc1NzPS//kwsD/SreZda7jINqEHk/K26wAcnN6gh0xltEOX1ILBgZgozuCkr5UFcbPMIH
	1C6J58VbwFXagOtHUFNE/geKcVvg=
X-Google-Smtp-Source: AGHT+IEn5GnWcl53MJvoceTZ0zlUw2gu6Fe25Y+gXd7/+6Hz34qf19OAO2GCoFKIhMA2FaTW/LxXdx+IS44HllOWCOg=
X-Received: by 2002:a2e:9688:0:b0:2cf:1a11:ea87 with SMTP id
 q8-20020a2e9688000000b002cf1a11ea87mr16920lji.39.1706207447879; Thu, 25 Jan
 2024 10:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
 <CAAEJBhKW3XZCZiz6MZ8NbCW61iU0gxL_LGru5y0Ubb_hbGAt_g@mail.gmail.com> <CACvgo50AWHGmYdRRLjq7ki=+FQ2J_YQq4JDg0PZATxorEjwccg@mail.gmail.com>
In-Reply-To: <CACvgo50AWHGmYdRRLjq7ki=+FQ2J_YQq4JDg0PZATxorEjwccg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2024 13:30:35 -0500
Message-ID: <CABBYNZLx1DVkXQgDXbLZPCEawQR4kBNfOo8q9KCG=MGw9xnjkg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/8] Remove support for external plugins
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, linux-bluetooth@vger.kernel.org, 
	Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, Jan 25, 2024 at 8:51=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> On Thu, 25 Jan 2024 at 13:02, Szymon Janc <szymon.janc@codecoup.pl> wrote=
:
> >
> > Hi,
> >
> > On Thu, 25 Jan 2024 at 01:07, Emil Velikov via B4 Relay
> > <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> > >
> > > Hello everyone,
> > >
> > > Here's v3 fixing a small bug with the previous patches, which was
> > > tripping the CI.
> > >
> > > Link to the previous revision can be found below.
> >
> > Just a comment that external plugins support was added to avoid udev
> > dependency (from sixaxis) in bluetoothd.
> > (not that I have strong opinion on this, just a note, I don't remember
> > exactly why it was done, maybe Marcel recalls?)
> >
>
> Thanks, I may have some ideas why.
>
> About 10 years ago (or so) some distributions were shipping
> libudev.so.0 while others libudev.so.1. The ABI break was minimal,
> although it was a thing.
> I remember us doing all sorts of hacks in Mesa trying to pick the
> correct one, esp when your system can have .1 while the game (or its
> chroot-like environment) has .0 and vice-versa.
>
> I would imagine a similar issue was observed in bluez - but I can only
> speculate.
>
> Over the last 5+ years, literally all supported distributions have
> moved for libudev.so.1 and the Steam games (and runtime) has both with
> some compat quirks to avoid explosions.

I was considering applying this week but if you want to respin this
set to sort out the dependency Im fine with, but I don't think it
would hurt to have a libudev dependency provide we have some means to
disable it in case the system don't intend to support sixaxis plugin.

--=20
Luiz Augusto von Dentz
