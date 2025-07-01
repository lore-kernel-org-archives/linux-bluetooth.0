Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDA280A47
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397110; cv=none; b=kuRlTUUcq2wRSTnG63h8OKbe6LyJS7S9UEgV0rMhbPgmamKHwq1jlRA4i8ZhUd1AvDC9ZvlLd1VP5tB3ZM6MeAT/rKVIwUwiIpAHdrW3u70oaobuqI4HkcrZRibVKVDt0CJmR136fJG2evVelBbJBFWpDVOD3oyggfrJYosaR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397110; c=relaxed/simple;
	bh=OpBZzJdf2pGt/4R3plQr962qAPwOscxUQdUGACY6Flc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIyOqBSmmuCS0qbJzMWid2/EnRHZ5TT91qjAZmAywDPCaWBuQY1rMWkMUCqBTxVnzaZS6iN2vPCF4Dc+v0eAH1XKZJpkvto6rlFqq+o0pmRwB2E8fBX28z4YPxDzkvxXqRsmXz29/jUNJ3JwLO32hJARBkPav2vSehwbvwjdTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNRUNMFu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNRUNMFu"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32aabfd3813so37428871fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397105; x=1752001905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBH8M0nW3cQ0fgu9gr80IwDsx/xT9zUIqXnycQVcytc=;
        b=MNRUNMFuTezq2rh4XBe4bVJFlcDIorXxP4vM8PAeK8qlqrsjw4lIIPf7PDOSCvumR1
         cCyiuVzUYQh3x2gSldvE2ZUxQ1vPwBBlbkM+e2p34nE8kfBG285wTjZGsQjl39tdYy/H
         L5dAKpAuEHSsAr+PYrMflP2jMMqnP5IbT7k7lixSWK93hCojo8TvMOyYh66Ybmnr0peT
         4W0luysy1Q3uojrvxImBhktBMOhFqQNCzXbcHnGxNLF8o4IYvKwsWEAZoWoevUg5Ky+G
         eDo0odNnp4xd/6HTPmGMc5Lm7e389qsfZZquqXeRYl322ppPmQ4WMD90ra6ZLgZ+Qy9l
         1SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397105; x=1752001905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBH8M0nW3cQ0fgu9gr80IwDsx/xT9zUIqXnycQVcytc=;
        b=irVF5GZOFtc7Z2tY9I+kj5aUrezm4/oWOxitGfFK7T9O03B3XNkhjU44UWBAxH6MMC
         +XK24n5V35YC9Jbbg6F82czPMnJjOURJPIww1Gz4akQEtq/UXbvFUdFu/mHuy6513vI6
         WTBCnEOhpy3oEb2SD2kJSgJdK4Ax/C/ROMf0utL+8A1FXgEPuhVkFdsjCY7VqxGTGycu
         kmv7XmzEjXdQGpHZM+RPVhbm/nN+pgxcCXQRWRWb6AMSsaQksuV6fyG2C8iR8vxkSvY8
         DYaQP8dVFkluE0jWeEZk8JvvOWeFFEIxI/p91SmmbW3mxoj3hhq6ZlrC4sHL400Woq2c
         2CVg==
X-Gm-Message-State: AOJu0YwWJDZnvuRAUI1Z0534hme/RRP/FA++oMgn6Dkd1/4IGcpnCs8H
	78H9JRwKV8NPZlJG0rL6amHS2ZdtBO/4RCIggsFZ1l40Psu57Gs4zC8jEcV+HDvhhZMbLaaTckd
	FhBcTlFKWAkg18Yt1YhDT2SGtGV/p9zQ=
X-Gm-Gg: ASbGncscOMi48mtH899eLhWe6U3OR6HtuXfQBm4peIevQAqjSKUj5ixRVeQPqaBR1YA
	9ikoMy+sj4dVcTSJ7S76h76kGT054k1h1UDzsv87NydoKsKLc4O5KGIrBRtTE3Yc+udQjr/ltjb
	tTNRBV8bBbgig8/fG8DdzKFwtNJ7UuK0/7sezGRN7CWQ==
X-Google-Smtp-Source: AGHT+IESJnCzJxvryDUPjquElcZiTVkTzw2Cqv891B7S4886+IB35R5bHYDqUFJbbi4KhHKUihSGrp4AwA1mXwdc6AU=
X-Received: by 2002:a05:651c:1115:b0:32a:6606:a58 with SMTP id
 38308e7fff4ca-32e000d7a52mr643951fa.35.1751397104784; Tue, 01 Jul 2025
 12:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701144647.19572-2-ceggers@arri.de> <CABBYNZLUu3KnXBOeCkWHtpG_es+yF7vzXjd-fOsHv-S_UMWU2A@mail.gmail.com>
 <2308158.vFx2qVVIhK@n9w6sw14>
In-Reply-To: <2308158.vFx2qVVIhK@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Jul 2025 15:11:32 -0400
X-Gm-Features: Ac12FXw5tg_7SEPIhWZbbNa9etYDO-fiuTNDdZkB-6qeAt1ljbneFBGANTRAa2w
Message-ID: <CABBYNZK-FtXiFxUgJNc5wOO-1=oQ6o9rpoW9=-LuwLW=OYvg9g@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@gmail.com>, 
	Inga Stotland <inga.stotland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jul 1, 2025 at 12:38=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Luiz,
>
> On Tuesday, 1 July 2025, 18:07:06 CEST, Luiz Augusto von Dentz wrote:
> > Hi Christian,
> >
> > On Tue, Jul 1, 2025 at 10:47=E2=80=AFAM Christian Eggers <ceggers@arri.=
de> wrote:
> > >
> > > This series adds initial support for the GATT Proxy Service feature.
> > > This allows provision and management of MESH devices from mobile phon=
es.
> > >
> > > Before continuing, I would be happy to get some feedback about this i=
nitial
> > > part (and about what has to be done in order to mainline it). Any hel=
p for
> > > doing the missing features (e.g. relaying between GATT and ADV) would=
 be
> > > highly appreciated.
> > >
> > > What seems to work:
> > > - Provisioning from another Linux computer via meshctl (sometimes I n=
eed
> > >   to repeatedly enter 'discover-unprovisioned on' and 'provision <uui=
d>'
> > >   if it doesn't work on the first try).
> > > - Reading the composition (composition-get in meshctl). It looks like
> > >   meshctl tries to connect to the GATT Proxy Service automatically af=
ter
> > >   provisioning, but I have to enter 'connect' several times in order =
to
> > >   get a connection. You also need to manually set the target unicast
> > >   address ('target' command in 'config' menu).
> > > - Adding extra network keys (Advertising for GATT Proxy Service cycle=
s
> > >   between different network ids every 3 seconds).
> > > - Transferring and binding of application keys.
> > > - Using the OnOff client in meshctl (you again have to set the unicas=
t
> > >   address in the 'onoff' menu).
> > > - Provisioning and configuration of an OnOff device from iOS (using
> > >   the SMART+ app from Ledvance). This app requires at least basic
> > >   support for proxy configuration messages (patch 4/4).
> >
> > Meshctl is sort of considered deprecated by meshd, it was created
> > because at the time bluetoothd and meshd couldn't operate in the same
> > controller so we need the GATT client to be used against bluetoothd,
> > which is why the whole tools/mesh-gatt is sort of duplicated from
> > mesh/ portion, but now that there is possible to have both bluetoothd
> > and meshd we should probably move meshctl to be a client of meshd
> > directly and then remove the whole tools/mesh-gatt/ directory.
>
> <Not sure whether I understand you correctly>
>
> I am working on the GATT Proxy Server (in bluetooth-meshd), whilst meshct=
l
> implements the GATT Proxy Client. Having a deprecated test program is muc=
h
> better than having nothing :-).

Yep

> Although I haven't checked for this, I guess that meshctl could become co=
mpletely
> obsolete if GATT Proxy Client support was added to bluetooth-meshd. In th=
is
> case, provision would be done by mesh-cfgclient regardless whether the
> link established by bluetooth-meshd is using ADV or GATT.

Yeah, we should probably integrate all the roles into mesh, now about
mesh-cfgclient I wonder if we wouldn't be better off integrating it
into bluetoothctl directly though, so one can control all daemon with
that instead of resorting to different clients.

> My patch series mainly makes bluetooth-meshd a client of bluetoothd (whic=
h
> normally operate independently). As bluetoothd is (exclusively?) responsi=
ble
> for GATT and LE advertising, using these technologies in meshd requires i=
t
> to use the D-Bus interfaces provided by bluetoothd.

Yeah, that is intentional so we don't have to replicate the GATT and
LE advertisement handling on meshd.

> >
> > > What maybe added later:
> > > - Proper selection of the output interface (GATT vs. ADV) when sendin=
g
> > >   messages.
> > > - Relaying of network messages / beacons between GATT and ADV
> > >   interfaces (in order to access further devices via the proxy).
> >
> > Afaik the tools/mesh-gatt does already relay messages, but since it
> > has been a long time I don't deal with mesh perhaps I don't remember
> > it correctly so please have a look.
>
> I only had a short look, but I think that tools/mesh-gatt can only perfor=
m
> configuration of the 'relay' feature on a GATT Proxy Server (switch
> relaying on/off on a remote system). But probably I haven't got the big
> picture yet.
>
> >
> > > Note: I don't use the test-join script, because python3-pygobject is
> > > (currently) not available on my (embedded) system. Instead, I use a
> > > custom C++ program for the 'Join' and 'Attach' D-Bus calls.
> > >
>
>


--=20
Luiz Augusto von Dentz
