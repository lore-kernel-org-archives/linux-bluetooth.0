Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88928548EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194130; cv=none; b=how07eHr6OhypPJb/o6zRE6dxV/cLkDAtk1muraTlsXVJRL0IAWRkETCj8N1Xb0CJB1PcMtb01AF5cmG0nLmlyUT9NkxVNoY043U3srZbPuD4rRuunmpe3oSwl/OX8ymQ8ChAZrrRtaRV4CFPjAonDYVeNyt/xK0ckdN5+3O9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194130; c=relaxed/simple;
	bh=G6hYySEc1VQEJt66wGiwxyQclVA0URHHCttEQ75sjxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEy9RGQl0Uvch51W4tADDhLoKTUGNmC/vVvNuOPINHDcNHpNdQebAKnuOd5LSNkszFK8bTZ/kBkZyeF4BtlwK3pXzxeRlRLJxfZw0IzT9zG8F6Zva8yTZ1gTbqsXsckdcZBixMr8G9uz81AQaDtCcFIOSRpYpmFjs2PrzMXyVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEXGW4Ud; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEXGW4Ud"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b31afa781so43813581fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753194126; x=1753798926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q0yuGDEa/DmbQqaln/rdKezxzJICp551q2fzBMHPiM=;
        b=EEXGW4Udjh5nDYU1aulG5plwsFmExgQc47baKyukJBpbyHn9pPxgUp2vDMRTDodGc2
         ykFawWldW4uNr1Ah1tuaNFzgYEO252b03XdV0FcEZiHtXngJS3FwPP9r/EojN12yqeaB
         XeLRyD0fjDWWMCBEqZFEzW/Eijb+d66rm3mVvSWv5mF/Ju59Uy+FWxjqBouFKh2zwQx+
         AHKVq851HSkDbb7J8mbD/KfdCESk+05VRDoE1GU7FRoQll4zmpbqcDRr/1LjfAhV09vo
         W9/k33FlX+EKGlh+Enaz8OOC+5dWLy2Ws7AbK4A1ATHswndjcUU6IFZRBY4Aev5Dhqb2
         8qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194126; x=1753798926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q0yuGDEa/DmbQqaln/rdKezxzJICp551q2fzBMHPiM=;
        b=uGF//6PdTzisXSNvP496oNDbe7mARsKJK1xFUOT3f8LlVzPWbObujgAHW7ql2Dy4TB
         Ws5pIRQV7Lab7qMlmAXMxxyeqBDXxAFdF4Nihme5ZGSd3fx9tP+Wo8hd7uSJu/aTlQmD
         wE9POJPpgjam/6rvzZAPK/kqFD+3HMH+dkQQvZc6Hk1/N3DYyra4YMedy8epwKw29O5B
         QJ/sVlTekmmZn+B5gn7hZ6v+fT+C4PwwgBkyDUyBVTnc3zXBB5Z9W3iLAGU5sRhnA/fP
         Mcn9MFycJwZrKFbGUrRiIVzzi3HtjawafGrwXRW7ETufkP9R1l00rw+lXfnNehGWvtQQ
         4REg==
X-Forwarded-Encrypted: i=1; AJvYcCUWsL28bZHMQSw6kPgqdcCt3w7kowZ8Noh4ThLjZblVcwfbJgUKSVtXTwbWN+8ApvTUx5J3Ys99XyDm8F83CjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrRiogbRJzIiU1NTj0ZrEfrjfGNjk5sc2jXkqMjRNFHsyLRyx
	czddQG3VwuKx/eMhmASPkQiZ9jL9SMI7EKirnH3cERmv5yPc4iIBW93vjiq6unQJ0zqpDRwt40O
	AgRs8gL2msiVM1d/jZqbRZ/Y7u+/YF1iDwXbC
X-Gm-Gg: ASbGncs0lHIDElL6YlwoWk/ruuR40XSzRIMvuDsNCJRFg4iPAy9wpxq/g4xQpAczQmp
	SO0JBLkGNf6S0HJ6CS3G2puunMk09ZYboOolmF+fGAeK4lsxYbL/yOR6zgcQ0pTtDQuVp74EgXr
	6blRU0ak98hONFFylKSacBCB/NZUf31xGeQtSI9ef4lsLhYMOvpMXVP2qkMAdOq7rJsIdEkvkHI
	QlzUgw=
X-Google-Smtp-Source: AGHT+IE32fOxfjsYUu8fOSV1H7E+AoDq2xVLXfGTWDSsCaJUrXUrgkruwczOPcQX/r1HwY6pjX/MAtJs6fxZ8SHGKv0=
X-Received: by 2002:a05:651c:325a:b0:32b:75d7:fc62 with SMTP id
 38308e7fff4ca-3308f65904bmr63548091fa.38.1753194125146; Tue, 22 Jul 2025
 07:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com> <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
In-Reply-To: <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Jul 2025 10:21:51 -0400
X-Gm-Features: Ac12FXxeEt4yi7Q32orzNTYTzam4ZPw3n1_y9BrkB_aI9Tzy4ecbSzYJUz42VSc
Message-ID: <CABBYNZLNTBinoOgaeZ3+i2D6tRXmuB=KGXxCrhu=3wOsPxFyrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Bastien Nocera <hadess@hadess.net>
Cc: Francesco Giancane <quic_fgiancan@quicinc.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jul 22, 2025 at 10:10=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Tue, 2025-07-22 at 14:26 +0100, Francesco Giancane wrote:
> > Hello!
> >
> > On 22/07/2025 13:54, Bastien Nocera wrote:
> > > On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
> > > > Hi,
> > > >
> > > > I am posting this patch series to better decouple `bluetoothd`
> > > > daemon
> > > > and `libbluetooth`, as mentioned in the subject.
> > > >
> > > > I am introducing this change to make new BlueZ more granular.
> > > > This will allow more control on which components are actually
> > > > selected
> > > > to build.
> > > >
> > > > Major use case for this change is fixing circular dependencies
> > > > when
> > > > bootstrapping new builds where the whole build root is to be
> > > > recreated
> > > > (e.g. Yocto Project).
> > > > In these scenarios, to have Bluetooth support enabled in Python,
> > > > `libbluetooth` is required at build time to be present but the
> > > > direct
> > > > chain of dependencies would require a Python installation
> > > > available,
> > > > thus introducing circular dependency.
> > > > Separating the library and header files from the rest allows
> > > > build
> > > > systems to break the dependency loop.
> > > FWIW, I'm currently porting bluez to meson (currently stuck on
> > > porting
> > > ell with its gazillion of SSL certificate tests), which would make
> > > python a pre-requirement for bluez (if meson ended up being the
> > > only
> > > build system).
> > >
> > > What part of Python itself has Bluetooth support? Wouldn't it also
> > > be
> > > possible to make that part of Python separate so it can be built
> > > after
> > > bluez?
> >
> > Python uses autoconf to detect compile-time dependencies.
> >
> > They implemented Bluetooth network management with standard socket()
> > calls.
> >
> > This code path is enabled at compile time only if it detects
> > bluetooth.h
> > header.
> >
> > So for python to support Bluetooth in std library, libbluetooth
> > should
> > be already deployed.
> >
> > With this current patch series I posted, you can build a "lite"
> > version
> > of bluez to ship just enough
> >
> > the library and the headers so that python can have bluetooth support
> > (building a full BlueZ package requires
> >
> > python too... hence the circular dependency).
>
> Right, so you're trying to do:
> - bluez (lib and headers only)
> - python (with Bluetooth support)
> - bluez (full)
>
> And if meson were the only build system, you'd need to do:
> - python (without Bluetooth support)
> - bluez (full)
> - python (with Bluetooth support)
>
> I guess having a minimal uapi header upstream would allow to do:
> - python (with Bluetooth support)
> - bluez (full)

+1

> Definitely the best option.
>
> I think it might be best to only migrate to the upstream kernel uapi
> the minimum needed to build Python with Bluetooth support, and extend
> it as needed afterwards.

What sort of Bluetooth support does Python have built-in? I thought
that would use D-Bus like pybluez, etc, but perhaps it has some HCI
and SDP functionality that came built-in with libbluetooth, but its
usability is very limited without the daemon, in fact it probably not
really recommended to do HCI or SDP on the application side nowadays
since we now have management interface that abstract HCI and SDP is
sort of legacy with LE Audio catching up with BR/EDR that will
probably be deprecated at some point, so perhaps we shall work with
Python folks to drop the usage of libbluetooth completely once we have
the UAPI headers.

> In the short-term, why not apply your bluez patches to your bluetoothd
> recipe rather than upstream? That should also motivate developers to
> land the "correct" fix upstream ;)

Yeah, going with intermediate solution will sort of introduce a new
dependency in the form of lib only support which will serve as excuse
not to adopt UAPI as soon as they are available.

> Cheers
>
> >
> > Francesco
> >
> > >
> > > > `--enable-bluetoothd` flag is added to the `configure` script and
> > > > it is keeping the same behavior as other flags.
> > > >
> > > > Francesco Giancane (3):
> > > >    configure.ac: introduce `--enable-bluetoothd` flag
> > > >    Makefile.am: build `bluetoothd` if enabled
> > > >    README: document `--enable-bluetoothd` flag
> > > >
> > > >   Makefile.am  |  8 ++++++++
> > > >   README       | 14 ++++++++++++++
> > > >   configure.ac |  4 ++++
> > > >   3 files changed, 26 insertions(+)
>


--=20
Luiz Augusto von Dentz
