Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3AC1CFBB
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283817; cv=none; b=JG62VmY0P+1yrJhdN/XoF9XFNe1US6RrPGlG7Iv1B4SMKDghONgbHlFzg/oIN/mhxlzPr/GRqfKjq/aH5CAd7K3m6OMJRrV1yMZ9XTTLKetokfyZGwV5XcvLCNcdnXuXbi6FLGzjtE35efa78RTCgYNse0siNjpZb/eWMU/1oB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283817; c=relaxed/simple;
	bh=/eb6Nklnv4VRwEkw5fg+xOviCo1oHxtCEj4Gu9/B6Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU20aDMuSULiWf5rcix+wQF7TGBeGhBgWyz1M5X5nP2mFa7aTc5Gft8K02zpdovgXbsQhAC+sDfvYJ079GqEIrIxSzbPvRuJDIdlEeQ/LoIp5vnssIopgA9SGAw7+g9iM9wwcfj/hgsVzv5w+aZuQw+fRbd1UI2OrEUUxME8wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjvJWcDP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjvJWcDP"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602cf45bfe9so4929017b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706283815; x=1706888615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eb6Nklnv4VRwEkw5fg+xOviCo1oHxtCEj4Gu9/B6Eo=;
        b=IjvJWcDPQTETYFXiI/hoLfAWvVKUvwTFxFA+IjBjQbBKwV0wbsubJtuo/LHhEv0znB
         +PctHAq0yzkZPxXcTPeyh/kmWsNTuc5Y+rYsbCgSrXFKVXODXTtorqlbIn+JcDUX+Cl+
         IqiMKAU2QNFU/5hXQbgCuxPw7DZaM8ZNvle4Jkb+1lTjH93i6yJhjh+iMiRxVmWW9SnZ
         S4WYHYnd1xatbk3NUEDen3HhivEVUtehS7HCwngUCNvOt+zokLlj872C/s78rb7Pof5Z
         aolKP2pUmHz5eTEEOhP7wEyAmHd+PVb/wfSeaE163AudlXXqbUe2kTWTpfZkpFJJnHe/
         L2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283815; x=1706888615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eb6Nklnv4VRwEkw5fg+xOviCo1oHxtCEj4Gu9/B6Eo=;
        b=KTAy74UkQXgBDJwHQV3yA1eo8/KHeHsoMkObc+v0US5TqwgBkiyai3nF4WQxGUhjzv
         irhfvtdmeNvjRuXRUGepkxKm1Ued7wLXRmYIUv/ILXlefW04HqAVMNy93hOJ6NJZhsKo
         Uemaa3K9a65AB4+xBj/JMfi/n5YGdLkbJ17lhwQARcWy1AZJ7KQr1ZCX3Rv8CnRfMgDP
         7zC2Oq2kyOPfEsju/KIE4gnAFlXWRsTfzTsLasfdZf4DitGsiYXOZCphB9cBruXczxb5
         kXwXjY2MIoFCrq+TVywInELc+TQptqq1q9SbalfBGubjf2Mh/yXrJUPVPvXraRvKZA9h
         lE/g==
X-Gm-Message-State: AOJu0YxnFmtASFgeXWbepFX64+pnMiL5Ot1gINYmJE84iTrbj2xLOXYe
	asR7/tYbclbPg8gx2kPyacg/9nQLDKfwz8IacSGYXraitCTtyKRMb858fBIzElYWKywlZuHYJOw
	RjILQh6amOloXtCEaxhp8xczf9rwPKdOq
X-Google-Smtp-Source: AGHT+IF0Ek7BT8kyuJzx0PO62pdoenQ4T3Io9m84F1XlMKzJ7EWh51RjMsAmOwgbsNipRHf5Zxy8aOJ7gTTSwVtbyhI=
X-Received: by 2002:a0d:eb51:0:b0:602:d19d:7853 with SMTP id
 u78-20020a0deb51000000b00602d19d7853mr620353ywe.38.1706283814986; Fri, 26 Jan
 2024 07:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
 <CAAEJBhKW3XZCZiz6MZ8NbCW61iU0gxL_LGru5y0Ubb_hbGAt_g@mail.gmail.com>
 <CACvgo50AWHGmYdRRLjq7ki=+FQ2J_YQq4JDg0PZATxorEjwccg@mail.gmail.com> <CABBYNZLx1DVkXQgDXbLZPCEawQR4kBNfOo8q9KCG=MGw9xnjkg@mail.gmail.com>
In-Reply-To: <CABBYNZLx1DVkXQgDXbLZPCEawQR4kBNfOo8q9KCG=MGw9xnjkg@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 26 Jan 2024 15:43:25 +0000
Message-ID: <CACvgo52Ze+sDcZUhKc90JAUjPVcubwNQ4Cksvv8F9xeCezJzWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/8] Remove support for external plugins
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, linux-bluetooth@vger.kernel.org, 
	Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, 25 Jan 2024 at 18:30, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Thu, Jan 25, 2024 at 8:51=E2=80=AFAM Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:
> >
> > On Thu, 25 Jan 2024 at 13:02, Szymon Janc <szymon.janc@codecoup.pl> wro=
te:
> > >
> > > Hi,
> > >
> > > On Thu, 25 Jan 2024 at 01:07, Emil Velikov via B4 Relay
> > > <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> > > >
> > > > Hello everyone,
> > > >
> > > > Here's v3 fixing a small bug with the previous patches, which was
> > > > tripping the CI.
> > > >
> > > > Link to the previous revision can be found below.
> > >
> > > Just a comment that external plugins support was added to avoid udev
> > > dependency (from sixaxis) in bluetoothd.
> > > (not that I have strong opinion on this, just a note, I don't remembe=
r
> > > exactly why it was done, maybe Marcel recalls?)
> > >
> >
> > Thanks, I may have some ideas why.
> >
> > About 10 years ago (or so) some distributions were shipping
> > libudev.so.0 while others libudev.so.1. The ABI break was minimal,
> > although it was a thing.
> > I remember us doing all sorts of hacks in Mesa trying to pick the
> > correct one, esp when your system can have .1 while the game (or its
> > chroot-like environment) has .0 and vice-versa.
> >
> > I would imagine a similar issue was observed in bluez - but I can only
> > speculate.
> >
> > Over the last 5+ years, literally all supported distributions have
> > moved for libudev.so.1 and the Steam games (and runtime) has both with
> > some compat quirks to avoid explosions.
>
> I was considering applying this week but if you want to respin this
> set to sort out the dependency Im fine with, but I don't think it
> would hurt to have a libudev dependency provide we have some means to
> disable it in case the system don't intend to support sixaxis plugin.
>

I don't think I follow: what do you mean with "sort out the dependency"?

Sixaxis is no different to midi where it a) pulls a third-party
library (udev vs alsa) and b) it can be disabled at build. Technically
one can dlopen/dlsym libudev.so, although that should probably be
deferred until needed IMHO.

Thanks
Emil
