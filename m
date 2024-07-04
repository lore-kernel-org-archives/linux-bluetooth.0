Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DC1AEFEA
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102670; cv=none; b=aScKfbXA/T3zC7ZaCf4k/ZWqVhj7poP2w6C0yTj2336h9xENQEEsR2yjoSc9HTmY37lrJlIiAiyl9Inq6t/2jhnhXg4MqoZptoYVqQjgklMdX9on4nEVuKRH7LkMCpoX9ziOi04tOvshNSz2/G+7otKiAAN6XcMQyYBaAeglnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102670; c=relaxed/simple;
	bh=ePv5ADr2Hp9tuVYkJoExoEuPx5XqczraIs0xQMX2AMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcWUka0ZmV8odDxSAWdeFxP5HALghW4UkGO3PrOOr+1WTocRUlCZNiW2eaN1P9TCZBoEsVJgKeg74y1BOyc3sIed+OrbWNhn0qPJKY6sxyx6A+/IvTdaxvh3+MsvA6+YRIChGUCCIzAs7dXxi3/V2pgoa79H+bhiU3GhSaFJJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewIET4Rx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewIET4Rx"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so8932621fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720102666; x=1720707466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePv5ADr2Hp9tuVYkJoExoEuPx5XqczraIs0xQMX2AMM=;
        b=ewIET4RxL9VDCrGUhEniO2irsZXUsxfZJzslIHMsvVVvtsoxw16fkLtSXrZY3pWUvQ
         Scl8IM/XXjYq5AFHdHZVqdMt5MYjLTIBj5FQIQEQNvfI+TbAoUX+bpVnm1/gUoWnztM0
         RH7y3y3kZTTsYb/es/q0Xe5JHNX+SMfHerMlUgs967WgNuSl2n7lH7hDDF4CG1cHV4O+
         UDr5nOvgl9fbwbfiYMwolk1NpXuSCOyr3NfJdHJnf/mqb3FkPKzulLhrk8RG8nUE/fau
         04fnGGYKx+RpXgUrCl8h39Gdp8oQL2NYEYYcJNKMiVQKdgOq0zMsnt0nxeeqTLr1zVUY
         oxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102666; x=1720707466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePv5ADr2Hp9tuVYkJoExoEuPx5XqczraIs0xQMX2AMM=;
        b=nkiUpjK1MvCAj5GpAscNTwUE6p4Rclr+TUW9jnAUSC41dWz7KyPhINZepVbVotJSuE
         uz4E8weXeeitzWx4R0Pqdsm3vsd3w1Pb4ZSmV4yRbQmgopJgg2ey7RXwIEw6XaDqrbld
         wnoFEGR47FlXDkz3c/6VhGImxLdbfTxoqQxjLGngWJZ12YCd7zoV9oGJQFaCwYyz6bHJ
         41XYmwI/zmnBCshW7Svc+LZbPxaejoQ3Y4SfiY92HeWQlEfQXinYgB5cUjXPs22NMLX9
         pPRjpDA4jEHapGyavj2QFX0ktOi1kn4BX4r90ttfPybXMJgfZp7D2cp1avb0eXTXolUV
         O5zg==
X-Forwarded-Encrypted: i=1; AJvYcCVQWD1pu7mF+gAn6Yke9DaMW7yIU3qpVXAcjPjCrB6+hZ9bln/Y+svauNXnWI9mwx2NKvvotP36EF1GLUYUpkitC/tVr9NYfabZkgSYm97Q
X-Gm-Message-State: AOJu0YzIsamQV+fwKLzquB68X8W6lIjqFP44/+T6h60CikOXLsNtCQyr
	aQ/MMsrJej8Uav/ngLLAbchaE8OxeF9QwcduqwWvPbIfa6jSxUeyuIQkKgoNih2DcwzCIiK+A2S
	pBtAQgn2YlUOiLXcwMI/9bK2MG5hjEg==
X-Google-Smtp-Source: AGHT+IHey+p5n66ZuChSZ1DeKeGGZ99IhbcpvtM+8I8yejKawy1X7cLGBC9FymgYVeaNkGMBD2aTJzu/KEEaV7g3pSw=
X-Received: by 2002:a2e:6e11:0:b0:2ee:8d05:db2 with SMTP id
 38308e7fff4ca-2ee8eda81b9mr13549451fa.29.1720102665988; Thu, 04 Jul 2024
 07:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li> <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
 <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li> <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
 <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net>
In-Reply-To: <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jul 2024 10:17:32 -0400
Message-ID: <CABBYNZLkQh-Lb9P-ZwDgXkQJPpxVSRE0wTEFGEG6nUQ9HQkboA@mail.gmail.com>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
To: Bastien Nocera <hadess@hadess.net>
Cc: =?UTF-8?B?Sm9uYXMgw5Z6YmF5?= <usul@gmx.li>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Jul 4, 2024 at 4:20=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Wed, 2024-07-03 at 13:31 -0400, Luiz Augusto von Dentz wrote:
> > <snip>
> > @Bastien Nocera do you happen to know why gnome not register a
> > pairing
> > agent? Ive seem quite a few reports of things not working after
> > rebooting lately which hints to No-bonding pairing happening or
> > perhaps fedora uses main.conf:AlwaysPairable?
>
> There hasn't been a pairing agent in GNOME outside the Bluetooth
> Settings panel for more than 10 years.
>
> I've never seen this being a problem before.
>
> Fedora uses the main.conf shipped by bluez with no changes (except
> AutoEnable to true, which does nothing as it's already the default):
> https://src.fedoraproject.org/rpms/bluez/blob/rawhide/f/bluez.spec#_196

Hmm, so if you got a incoming pairing request there is nothing to
respond to authentication? Well even in that case it doesn't explain
why there was no agent while setting up a new device, or perhaps that
is not how setting up new devices works nowadays? Jonas, did you use
the gnome setting panel to set it up or did you use something else?

--=20
Luiz Augusto von Dentz
