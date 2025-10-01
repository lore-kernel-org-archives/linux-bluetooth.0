Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3726A0D5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348070; cv=none; b=Hsf8UEBOLIoDFyvF3Am/sTxdJeq8BBbaJxnIpE3qZ5wD+/x5xmwfstLvKXumvwcbQwMLYZk9ZY2K2+IbVWq8wmmtP0gISMABUY1G2859eFiKUs5Tkmw50PNAY8MfTKzgtastLh5PhjEFoJV39mJIEF3lXCLcwu8RVqBEZDr3Bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348070; c=relaxed/simple;
	bh=JhPo/MyP2mNgd3eqcHzP1S4NsWwErCOpdg2Amum/rxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEOfNZwCr+T9+1hJxobajmHvmdWbWuNUcn/nfXJwdva0tsCyYOebeYqhWW3WWUOm0UJgCMOzB7fuEytjnE7Pf9dS5mbRNF7TVSD9cbr/uYgHMJrgmX6VMPMEIOUkwFxFWE97NblErSU8dFUAHFLlcnX1zw/fIav0hC6H4GinRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0udJ/ed; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0udJ/ed"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58984c363ceso1305467e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759348066; x=1759952866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7xaTGxyUWzEb8mHahlXuQm/k1B8ff6K/pkxdE8ekSs=;
        b=Q0udJ/edY7i9os02hAiezaHmOXnVzdVYBCE/He+fpsBgKRbWucg+IqEOvqwv2ItG+1
         3cSyUF6mTDNxJoHv3nCHPYCmoW8oDI/MOAlBz8RLNBLzGYIMLv4fW2upUYWnK5G83rD7
         CLfKceqAUgAm+oERWgbf1DfmY25D2Ss+a/glhn7Inm9a7ZSyK5PaIXfwcImUp3pHHonx
         iGuMwlu281rAmh7ercGeIOdmF19Rax2HIvATbCjChPahf9HR00u/I92nxrK+O6cAWp2Z
         tgP0aFfv3Qrh+0Hk71+TGjwS4fdDCKpnVEAgY/jVo/HQTB127KrqWipvDDVBUnBIbbvK
         yuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759348066; x=1759952866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7xaTGxyUWzEb8mHahlXuQm/k1B8ff6K/pkxdE8ekSs=;
        b=D8zAWy+y2I7ltUbqNW7IvE3Lcy2mfyAplI4jpBOKIOwP8DnpJnOvoQsFu8n7mXCEk6
         +0letdVnohbDPhffL5DaW03kSv6iyAlVst0vPInS227TFEVb+dUZi1X+VoEM5BsMaGuC
         Qql4hORoSqHcZqSj/UTF9bUOi5YPe2eUt4Gspd+nn0cy9Zx4L3iY/wwTvIr1YvM8Yh8g
         zd4mW7Y5BNFgvW8CCc2sMdSIOnUfBF1fq5TpsH0RVjlacJidXhbVpW3qH7Rwpo1lDkqp
         unKAJHNwCtvDHJKveoiK7v9tSQDbQGsEMS3dj8gWs3Be6Mxy0VPywrRanfaJ0oNJNwjH
         3hNA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+R7V81/0zpP4nBDfpPNSfM4lRHuSSYgwaTeMXxGwkpFUGELy6Zpr1NPIHppUZorytCfbD9P60++Ead2GOws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/zRJMfnM8Ih8mzQnhMAut+Oga2yAeIWDrPAc4ChBnapIWrWG
	zK3qmHmuAoQVFgwrIEjNIOcdFP2u99gu3Fb9NH8//3COBq9hFF0RYYAqVrnhJcgBEXSzkzkv8Pm
	ns37fQTla1EpZXlU9W5qn7CnlVeB8hqY=
X-Gm-Gg: ASbGncvtLp+CA3JZ8BQigjWXk+o9zEpltSs5YUkDS//asDUJs3vqEeU+XJbKGmUMdT1
	2AE9DP+JOle7yoVqN3I2H3W5gyMeFhTabOIAVfsIJqaaNXgjNZpgb3Ym5HaY6ufl9aMU9N5AVcL
	wi7Z6lC5ZtpzSK8R6fRIKdUVU/Vuvs+Fggwy2ysoHqfqxT4SD1LQW5M5UrOLzAq0ADVrIne+NZD
	2KN95bEg3sILDcZHcKUTSMSyEvcrw==
X-Google-Smtp-Source: AGHT+IGCoZuRaL19s9GMSYFkaQAy3BOuSK/+LKMfGOwteOSOsCrTpPKyzQdVN/E1hCl5/oRF3HVaRhQ6DVIbzrcjv9Y=
X-Received: by 2002:a05:6512:401a:b0:581:4d9e:500e with SMTP id
 2adb3069b0e04-58b00b4491cmr247343e87.3.1759348065680; Wed, 01 Oct 2025
 12:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com> <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
 <CABBYNZLNTBinoOgaeZ3+i2D6tRXmuB=KGXxCrhu=3wOsPxFyrw@mail.gmail.com> <4243f713-3bee-41a1-b718-ee0cdc2d8e9c@quicinc.com>
In-Reply-To: <4243f713-3bee-41a1-b718-ee0cdc2d8e9c@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 Oct 2025 15:47:33 -0400
X-Gm-Features: AS18NWArcY8ss3PrXVxs1R4Fa80MwsYi2i1sP2xWeSISqi3m8kcvi6Z7I7-5yM0
Message-ID: <CABBYNZKz=EbmNcux7BkrbdvhSfQamDpt+JAJx16_i1nUYxvQng@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Francesco Giancane <quic_fgiancan@quicinc.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Tue, Jul 22, 2025 at 12:27=E2=80=AFPM Francesco Giancane
<quic_fgiancan@quicinc.com> wrote:
>
> Hello,
>
> On 22/07/2025 15:21, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Jul 22, 2025 at 10:10=E2=80=AFAM Bastien Nocera <hadess@hadess.=
net> wrote:
> >> On Tue, 2025-07-22 at 14:26 +0100, Francesco Giancane wrote:
> >>> Hello!
> >>>
> >>> On 22/07/2025 13:54, Bastien Nocera wrote:
> >>>> On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I am posting this patch series to better decouple `bluetoothd`
> >>>>> daemon
> >>>>> and `libbluetooth`, as mentioned in the subject.
> >>>>>
> >>>>> I am introducing this change to make new BlueZ more granular.
> >>>>> This will allow more control on which components are actually
> >>>>> selected
> >>>>> to build.
> >>>>>
> >>>>> Major use case for this change is fixing circular dependencies
> >>>>> when
> >>>>> bootstrapping new builds where the whole build root is to be
> >>>>> recreated
> >>>>> (e.g. Yocto Project).
> >>>>> In these scenarios, to have Bluetooth support enabled in Python,
> >>>>> `libbluetooth` is required at build time to be present but the
> >>>>> direct
> >>>>> chain of dependencies would require a Python installation
> >>>>> available,
> >>>>> thus introducing circular dependency.
> >>>>> Separating the library and header files from the rest allows
> >>>>> build
> >>>>> systems to break the dependency loop.
> >>>> FWIW, I'm currently porting bluez to meson (currently stuck on
> >>>> porting
> >>>> ell with its gazillion of SSL certificate tests), which would make
> >>>> python a pre-requirement for bluez (if meson ended up being the
> >>>> only
> >>>> build system).
> >>>>
> >>>> What part of Python itself has Bluetooth support? Wouldn't it also
> >>>> be
> >>>> possible to make that part of Python separate so it can be built
> >>>> after
> >>>> bluez?
> >>> Python uses autoconf to detect compile-time dependencies.
> >>>
> >>> They implemented Bluetooth network management with standard socket()
> >>> calls.
> >>>
> >>> This code path is enabled at compile time only if it detects
> >>> bluetooth.h
> >>> header.
> >>>
> >>> So for python to support Bluetooth in std library, libbluetooth
> >>> should
> >>> be already deployed.
> >>>
> >>> With this current patch series I posted, you can build a "lite"
> >>> version
> >>> of bluez to ship just enough
> >>>
> >>> the library and the headers so that python can have bluetooth support
> >>> (building a full BlueZ package requires
> >>>
> >>> python too... hence the circular dependency).
> >> Right, so you're trying to do:
> >> - bluez (lib and headers only)
> >> - python (with Bluetooth support)
> >> - bluez (full)
> >>
> >> And if meson were the only build system, you'd need to do:
> >> - python (without Bluetooth support)
> >> - bluez (full)
> >> - python (with Bluetooth support)
> >>
> >> I guess having a minimal uapi header upstream would allow to do:
> >> - python (with Bluetooth support)
> >> - bluez (full)
> > +1
> >
> >> Definitely the best option.
> >>
> >> I think it might be best to only migrate to the upstream kernel uapi
> >> the minimum needed to build Python with Bluetooth support, and extend
> >> it as needed afterwards.
> > What sort of Bluetooth support does Python have built-in? I thought
> > that would use D-Bus like pybluez, etc, but perhaps it has some HCI
> > and SDP functionality that came built-in with libbluetooth, but its
> > usability is very limited without the daemon, in fact it probably not
> > really recommended to do HCI or SDP on the application side nowadays
> > since we now have management interface that abstract HCI and SDP is
> > sort of legacy with LE Audio catching up with BR/EDR that will
> > probably be deprecated at some point, so perhaps we shall work with
> > Python folks to drop the usage of libbluetooth completely once we have
> > the UAPI headers.
>
> The library requiring bluetooth headers to be available for Python (and
> thus enabling
>
> bluetooth support in python) is:
>
> https://pypi.org/project/bleak/
>
> >> In the short-term, why not apply your bluez patches to your bluetoothd
> >> recipe rather than upstream? That should also motivate developers to
> >> land the "correct" fix upstream ;)
> > Yeah, going with intermediate solution will sort of introduce a new
> > dependency in the form of lib only support which will serve as excuse
> > not to adopt UAPI as soon as they are available.

I guess we should probably create a github issue or perhaps update the
issue https://github.com/bluez/bluez/issues/989 to avoid having this
conversation lost in the email threads, also I may take the lead in
doing the uapi conversion if no-one has started doing it already,
since that may prevent people from using the kernel interfaces just
because they cannot use the headers due to improper license.

> >
> >> Cheers
> >>
> >>> Francesco
> >>>
> >>>>> `--enable-bluetoothd` flag is added to the `configure` script and
> >>>>> it is keeping the same behavior as other flags.
> >>>>>
> >>>>> Francesco Giancane (3):
> >>>>>     configure.ac: introduce `--enable-bluetoothd` flag
> >>>>>     Makefile.am: build `bluetoothd` if enabled
> >>>>>     README: document `--enable-bluetoothd` flag
> >>>>>
> >>>>>    Makefile.am  |  8 ++++++++
> >>>>>    README       | 14 ++++++++++++++
> >>>>>    configure.ac |  4 ++++
> >>>>>    3 files changed, 26 insertions(+)
> >



--=20
Luiz Augusto von Dentz
