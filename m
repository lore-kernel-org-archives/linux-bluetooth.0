Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A31DE4C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203080; cv=none; b=tBjUp4u1+4hyWlY0sRZUwggXGhhYpyAUzdC7flTWuB0L1bWlxH0k4e8hoLUSwdMTsaWY5lRKc028fv3MBD9hgYBh0kpVWm2RBOmQtggjWpAvw+w1nlmaICOOxKIrkFrBYefeNLEaiHqlM2nIuteFR3pP2xg57Y831+SAIXXsW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203080; c=relaxed/simple;
	bh=g2RqUGAPwhT7EVyaCr6VI+SGbjZLelh6Xvm4z6vngrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBGPfkAvRl86U5suP/1OmCnBBxYbwDV4odbv7naxpOm0r7jwaparTbieRSngnRKXk41zbv5dc7ELcGiKSZyMGom1I3YbIMOVtnBHlYTm88aX4mBmvjPm60WriBIuURQNEIVANNEdYcvGIUGu5ObVV7tljSdnMwCs6RtZPfKOIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8w6au87; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8w6au87"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5dd164ee34so2656266276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740203078; x=1740807878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW0U6XE5dadFnlwiaJSOgRm7TtOqVG8RKY4MPvgIS9M=;
        b=Q8w6au87afMdo91RgXasEKEa3HlvmyE3urikrRtXFs1xCHMC2JfdYljDV13tkH3t4d
         ixd6w+XYc5TQq4Zr71ngk5bciLLBSDw/xkfguVmA0U5fKEKzq3g7mT176dqChL0b9Vnj
         nt1MdSxoMNzk/FQr7sTyP91GgX3m/w4JskiRr4ApV09Tc13xZf6G8CLHV98KbNuA1MnA
         Ug8xSJFPwSmpaHL38o2Da3iYI4q6ctuSev7X2sqmyay4LGjVGPlM+gte01GLApmfoLe+
         NHZNe4HJu6WCuB+LoPLiec5dcgshF2iG64d+KOTN9XT2wljTc43HKaesK4A0aXERZH8K
         MqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203078; x=1740807878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW0U6XE5dadFnlwiaJSOgRm7TtOqVG8RKY4MPvgIS9M=;
        b=XZ94NAM44MdEBVmRfc/B0WV21AfiKugxKqbDwwvhQOcW3zMCt71pGft9f6o1ak1gBe
         HYqsqL2jHbpPgnYfPomHBEX74hIozJ/pq3b26XaTd675KE+z3/+5G2449cRT/c8nBY/D
         MUxPrN/vKGYROYhuPf/8dEoZPGzz+QO/a22wgIJUYZ4kSV1xoY2+yi5Ms8onif2+svMg
         1dKglmkfEZkBPxt37dsBbEMGR8qH7aT1Na5RQn4fq9SEMLQs4wnWPgkUFLgKCN0czhzh
         0NZK8mo0beby6PFpxt7GLbaCUCcYng7tFicr66D4niOouxux3w+YgLFa7wT4tjnjVBe7
         Yk0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUZtrqyQ2ObkYg6nOaePLkkQRYfpTgGVX/ouH3bbG3Cifjgj8BdxB7B8MxreRwFwNarYJV9B6SREp0t3Tr3qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO88Wo1ssUUpU2SuBibrO3BNA0l8Iyp59N6sQg2CNGxE6fkm0n
	8wnZlie27UCSIxv5p5duQGiYAKmcAE2xcjtBsUxi3xzAZ6dhZl2w96Ye+wqoi1TUAyPuPplpfJc
	eLuQcY6nqQS0tdZBxpusYjLvkD9QwzKFAXLpX
X-Gm-Gg: ASbGnctJfM2bz5GKzu6rg7esNbX3waF1fo1OBclDPHB89FZzzxlKX9WGo3ixnBBUi7I
	Hm9Ffw6F9ZhQSVmlLvNnMb5c0tjl8q4lfbR+A4+U3S6/pDfsFgSqpTGmZ3LZ5yu0J2delUFJQch
	kPSmvq/w==
X-Google-Smtp-Source: AGHT+IEMpO00uemXmGY6b464HS40oKo+dihlFMgpDgU1txDpLJh+5Afnfry4LLgBDLhNg47CesKOoJ0XEs4AQlt7H1s=
X-Received: by 2002:a05:6902:f06:b0:e5d:c686:fe02 with SMTP id
 3f1490d57ef6-e5e8afcf651mr3936362276.16.1740203077552; Fri, 21 Feb 2025
 21:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>
 <2025022100-garbage-cymbal-1cf2@gregkh> <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
 <CABBYNZ+63EdbEcB7-XD9jN79urmk5CtUZ6iBzphO3HuCMukQoA@mail.gmail.com>
In-Reply-To: <CABBYNZ+63EdbEcB7-XD9jN79urmk5CtUZ6iBzphO3HuCMukQoA@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Sat, 22 Feb 2025 13:44:11 +0800
X-Gm-Features: AWEUYZnYXlpbzQNJ7UlFKYOWA3cFheHOAd-U40G8kDxTfwzkk8us50aaQAcEy-4
Message-ID: <CADg1FFeyN3AWYBD6UxOYGKfUaStyvVKVhuAzVtG_oCpXVdQnMg@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, Feb 22, 2025 at 12:21=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Fri, Feb 21, 2025 at 12:57=E2=80=AFAM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 1:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> > > > On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@=
google.com> wrote:
> > >
> > > <snip>
> > >
> > > > Hi Luiz and Greg,
> > > >
> > > > Friendly ping for review, thanks.
> > >
> > > A review in less than 2 days?  Please be reasonable here, remember, m=
any
> > > of us get 1000+ emails a day to deal with.
> > >
> > > To help reduce our load, take the time and review other patches on th=
e
> > > mailing lists.  You are doing that, right?  If not, why not?
> > >
> > > patience please.
> > >
> > > greg k-h
> >
> > Got it. Take your time and thank you
>
> So it is not really possible to change the alt-setting any other way?
> I'm really at odds with adding something to sysfs that only one distro
> cares about, at very least that shall be put behind a Kconfig or as a
> module parameter, or perhaps we start to intercept the likes of

I'm willing to put this API behind a module parameter if that resolves
your concerns.

> HCI_EV_SYNC_CONN_COMPLETE when USER_CHANNEL and then check if
> alt_setting needs to be changed based on the air mode, how about that?

This is a good idea. Let me verify it and get back to you. Thanks.

--=20
Best Regards,
Hsin-chen
