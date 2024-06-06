Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65138F9C;
	Thu,  6 Jun 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705188; cv=none; b=i91l7mDa0qnD7TKMkTn6XuXPqdReIwpKSptqgp54y+wHsWn9V65KoPwrJue/G24CgAgqzgdEZ/IhCGMJ4aCma64e0w6BhysngHA7j3jtOI6ua31jjEXS75Wjgfl8GWQtkYwraGW66MDADutyWPLYBOy35bN7VIaoB4dTo1K814c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705188; c=relaxed/simple;
	bh=wa3BBdGR1+78PPUuJsMGHRdeHoVZKgnZms8c31qQteY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfWpfDSFcOUyLRlDfJpsCdLjY7ho5Fy7ya0bkSSQUPIwQmDbopfG8VyP0ubZO7jxnOQzLH/guNKFINKqKv92WeEiHzqN6PrmyDkU6jPJAX0sSC7s/eogAHaSc67m3b1vbK62UNzlgoiv8uxgHgWNik0fQfJZd0schZjuXoEiYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=kFAacZI8; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kFAacZI8"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFJaJ-0094PM-2s;
	Thu, 06 Jun 2024 22:19:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SL5BnMk1PEOausbJHr2HCDEZ4yWEUH7QQMEph3aTbgw=; b=kFAacZI8g90v4i6fUcbrkwDdnX
	rU4s8/cXRH16qiyrT6glZHCQqOS0qjjpaVHSoWDzodbsGebPoAZ38sQqHyEcRsI+iH1QN4xbEkN+E
	Schyei93eUPhiZyZY5XzGaNAx4bdwQctlJ0LNF/cYgLj0TE5FN945zWuCr8T86nKO1289GnIrg+Uj
	lx0p25iRrQxeLlXogaMV2DApnE9iWI0u4ssRQsFqmhGNZ2UIuS+qRsStKYVdwNOYrKJRcbd2iH7kF
	Opl0hzyujsLnKiLb5wtldC+ssVrUw9WP93OYYfyowBKHPKtXXv8XIbokTrHgbMML/AoOk6g+8CgZG
	NlM6cPOA==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFJaH-002oCx-35;
	Thu, 06 Jun 2024 22:19:43 +0200
Date: Thu, 6 Jun 2024 22:19:41 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan@kernel.org, pmenzel@molgen.mpg.de,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20240606221941.333a9704@aktux>
In-Reply-To: <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, 6 Jun 2024 16:04:10 -0400
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Andreas,
>=20
> On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> >
> > Some of these chips have GNSS support. In some vendor kernels
> > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > device which speaks the secretive Air Independent Interface (AI2) proto=
col.
> >
> > To be more compatible with userspace send out NMEA by default but
> > allow a more raw mode by using a module parameter.
> >
> > This was tested on the Epson Moverio BT-200.
> >
> > Who will take this series (1-3)? GNSS with ack from Bluetooth?
> >
> > Changes since V3:
> > - Finally remove the period from 1/4 subject
> > - include things directly for get_unaligned_le16() to fix 0-day issues
> >
> > Changes since V2:
> > - Optimize waits
> > - Fix some packet analysis / checksum computation issue
> > - Adding a proposal for removing those waits as RFC
> > - Minor spell corrections and improved descriptions
> >
> > Changes since V1:
> > - Set up things for NMEA output
> > - Powerup/down at open()/close()
> > - split out logic between drivers/bluetooth and drivers/gnss
> > - leave out drivers/misc/ti-st driver removal to avoid
> >   filling up mailboxes during the iterations, this series is
> >   still a proof that it is not needed, will take the brush after
> >   this series is accepted.
> >
> >
> > Andreas Kemnade (4):
> >   gnss: Add AI2 protocol used by some TI combo chips
> >   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips =20
>=20
> The bluetooth one looks relatively simple so I could take that one and
> push to bluetooth-next if there are no dependencies on the other
> changes.
>=20
There is:

include/linux/ti_wilink_st.h |   8 +

We have compile time deps here. Patch 3 compile time depends on patch 2. If=
 we
cannot take everything in for  6.11, you might opt to take the bluetooth pa=
rt.
That would work.

Regards,
Andreas
