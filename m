Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23418EAD
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746638; cv=none; b=Mzo2yqIVqeM5j2k5LcXBe6miY5M3RLlzQRS4MZHpTmeTr9BFi4qW6/00/arRiyLJoMixWQUhfa2HUSXgOPGiA1EnVDGFcqXi+wYiXxPNsBjbep+wrIxkqAPLLY8IYVgrNDzxVfgNNOVp+ZTJ2Hab7WNHGgnqbKyCOggzk6f6PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746638; c=relaxed/simple;
	bh=eaJoIfc7yAM4yU9k/qpYAdQNpdE0pi9XqzWhnJ9xguM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=bpDWjVV+WkrfhRCGRlbhyF492KzjueADxgCg5rkdfYziID4nwno2i8BTaXX0iU78Fzvdt+fTBQaQPQzLcq8quCgU10TKDxU1GdJ5xatM32uF73IjdWkTAlcs/Le9NtCUwVlQQ7KN0ZHj48pIOnR7iSJ+5mAbG6XmpLUAdTu/TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=hHKI7lCb; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="hHKI7lCb"
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=hHKI7lCb;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id 733C8240DB7;
	Thu, 15 Aug 2024 20:30:31 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id PrGrqxEz_2uI; Thu, 15 Aug 2024 20:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1723746630; bh=eaJoIfc7yAM4yU9k/qpYAdQNpdE0pi9XqzWhnJ9xguM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=hHKI7lCbjV4IzHoCP5ldMcTz5vO42rEUMx1WvEyBYSJk5uIVWE4auIOq39JpU94xg
	 hcu3+yJSL9gbTd11l8a1riVebvBT37pQdQA8gOSonish+BawwAaNimeedkqkH0Psgv
	 E5q7BNuvL7XAcixgCGSns6UB002DtG7HBwsYD2291kW9MTxs48SO8vKU1Kx9Rfl8gw
	 fMheoNubwCzb325fcoVRQNvW1gaw7hDgk/QzC1V5khaF4C7/oBrTnG+P2UWZqaBOjC
	 QHtdZ5VFSwniD0SV0ahjJ1Ka6oOoPYWOsOPUwtXpoo8/Zg1L79Bofa0O/cJJL3HZSr
	 ulHDCZfUGgQwQ==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 69933240695;
	Thu, 15 Aug 2024 20:30:30 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 497181601B9; Thu, 15 Aug 2024 20:30:30 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: monitoring advertisements from specific device(s)
From:  Anton Khirnov <anton@khirnov.net>
To:  Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:  linux-bluetooth@vger.kernel.org
In-Reply-To:
  <CABBYNZLXvvM2knc6khd+iFnx0NkDFiuF-d5UjcFpFj-xD85Drg@mail.gmail.com>
References:  <172362641171.1463.1558884635182654862@lain.khirnov.net>
 <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com>
 <172374276216.7554.15339600683100081438@lain.khirnov.net>
 <CABBYNZLXvvM2knc6khd+iFnx0NkDFiuF-d5UjcFpFj-xD85Drg@mail.gmail.com>
Date: Thu, 15 Aug 2024 20:30:30 +0200
Message-ID: <172374663027.7554.6790757631293861028@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Quoting Luiz Augusto von Dentz (2024-08-15 19:34:41)
> On Thu, Aug 15, 2024 at 1:26=E2=80=AFPM Anton Khirnov <anton@khirnov.net> w=
rote:
>=20
> > Also, the advertisement monitor interface already does almost exactly
> > what I want, except for the fact it forces me to receive advertisements
> > from devices I'm not interested in.
>=20
> Yeah, I was gonna say that, but this is a vendor extension,

I don't follow, what exactly is a vendor extension? IIUC in-controller
handling of advertisement monitor or_patterns is a Microsoft extension,
but what I want is just a nontrivial device whitelist, which should be
standard.

> not really following about forcing you to do anything, or you are
> saying you want to connect rather than parse something on the
> advertisement? It is a little bit hard to give you any advice if you
> are not really explaining what is the use case,

I wanted to avoid flooding this list with too many unnecessary details,
but seems I went too far :) Sorry.

I'm writing a data collector for bluetooth weight scales, which I'd like
to run in the background and work automatically without user
interaction.
Advertisement reports for a weight scale contain ServiceData that
indicates whether new measurements are available - when the collector
sees such an advertisement it should connect to the scale and retrieve
the measurements.

So what the collector needs from the bluetooth stack is to monitor
advertisement reports for a given list of devices (the scales it
previously registered with).
The advertisement monitor API almost gives me this, except it always
uses an unfiltered filter policy (as per the block right above the done:
label in hci_update_accept_list_sync()), which means advertisements from
all devices are processed by the kernel and sent to userspace. This is
not a fundamental problem, but it seems wasteful as the controller
should be able to filter just the devices I want.

> also if you are involving a daemon then perhaps you are not really
> using bluetoothd?

Just to be clear, I am using bluetoothd (via bleak), but AFAIU the issue
is in the kernel code.

Thanks,
--=20
Anton Khirnov
