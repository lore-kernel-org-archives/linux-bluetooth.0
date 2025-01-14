Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6371B6CE4;
	Tue, 14 Jan 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872027; cv=none; b=uDurVbyfX5iPiMt6H5/2CZX8dwkHsooIsy7a5v4/HJr15GSXUYWO8SI+5GLJuHmN/uyRT1Cjecu+Cf3NC7Z56z2RR20aTYIMTY2fzYVeLZWWKqWNugUA4GID4PoUDItQavW5cpPQpuJWeFBvDLoteIFxLOTFhAKY240UcqKErwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872027; c=relaxed/simple;
	bh=dj4Fu5eLAuh/Tb4Mbzd6Rk76gIqWfyZSZ4mV496yrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsUfbdY/VfZ2PMnCKuu+uOzLDeucrOxaN7NEzRa43oQdq2y7aWpA2tMz9rwNbXppcaa5OE6EIiynJVY9HIspwW5PjLBbZB8J7GCGuVpD3ZtIRk+A6KG2UfijXXB1dsaXPYbAMqxK5EUbS5hEEprUFj6St6nXZYk+oVEOmz+4elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3G03Hho/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3G03Hho/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ogONG8vMCHQIJSOvN+1cvdu84/cgSXOm/R1fS729MG4=; b=3G03Hho/WNEPDfaDTC+1BXw0Ad
	SWlKv2V6YoHL9D9M0mT0RDrLynlw1zpMzU8o/8iIqAo1Nljm/p9LT4xlf+Ieq4DUTROTUAauPGQsy
	sO352zo2NVkjPQ6K6Upc5kS5k4LQdsQCbx0ytclCkwg5a55/ZgxTWc468snWjX3d/vL2cNRAxvhWV
	i5ozgajZPpGv1n9KTDjA/Meg8hkk0S81CVgQ9PTSl0NlTnFf0LiA/EcJx8jPBWEjT2hCINuxsTRQC
	y4bWI51NkZWd+g4Of/FHN3uGrO8UOyPmRZzFf7nDIiblY26QF211ttWWIWaGAEx9AyFOWmaenTmxx
	atSYaf6Q==;
Date: Tue, 14 Jan 2025 17:26:58 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Johan Hovold <johan@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 2/4] Bluetooth: ti-st: Add GNSS subdevice for TI
 Wilink chips
Message-ID: <20250114172658.3fe1a37e@akair>
In-Reply-To: <Z4aCP-r-IUTmyizm@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<20240606183032.684481-3-andreas@kemnade.info>
	<Z4ZVNU0PdCDpMaNY@hovoldconsulting.com>
	<20250114140525.763b4c33@akair>
	<Z4aCP-r-IUTmyizm@hovoldconsulting.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 14 Jan 2025 16:26:55 +0100
schrieb Johan Hovold <johan@kernel.org>:

> On Tue, Jan 14, 2025 at 02:05:25PM +0100, Andreas Kemnade wrote:
> > Am Tue, 14 Jan 2025 13:14:45 +0100
> > schrieb Johan Hovold <johan@kernel.org>:
> >   
> > > > GNSS support is available through
> > > > channel 9 whilst FM is through channel 8. Add a platform subdevice for
> > > > GNSS so that a driver for that functionality can be build.    
> > >   
> > > > To avoid having
> > > > useless GNSS devices, do it only when the devicetree node name contains
> > > > gnss.    
> > > 
> > > That's seems like an unorthodox use of device tree. These devices are
> > > primarily (WiFi and) Bluetooth controllers so should probably not have
> > > gone about and updated the node names to 'bluetooth-gnss' as you did,
> > > for example, here:  
> > 
> > yes, the matching of the node name is a bit unorthodox. How do you
> > define primary? The old design with ti-st driver and bluetooth and
> > other functions on top does not look like anything primary. If you look
> > at the current situation with the GNSS stuff sitting on to of
> > bluetooth, the picture is different, but that is implementation.  
> 
> I call it primary based on (my understanding of) the architecture,
> protocol and chip family. It look to me like the FM, GPS and NFC
> functionality is bolted on top of the Bluetooth one for which a protocol
> already existed (and which is also used by standalone non-wilink
> Bluetooth controllers).
>
Well, it is a bit of a definition thing. The ti-st (the older driver)
stands for shared transport, so sharing multiple things over the same
line, by dispatching the TLV structures accordingly to the relevant
protocol drivers and at that point you say that some type values are
Bluetooth, some are GNSS, some are generic power management + fw
download.
AFAIK using any approach based on the now-removed ti-st driver, no
bluetooth would be needed in kernel for using GPS. How could something
be called
"bolted on top of Bluetooth" if Bluetooth is not required.

But then there are devices with some type values which provide
functionality related to Bluetooth. For those the h4_recv_pkt
infrastructure is there. And this happens to be also useable for the
jobs done by the ti-st driver. So it could be obsoleted and
now removed. Probably this h4_recv_pkt stuff could also be used for
other non-bluetooth-related stuff.

So it is a definition thing if either say regarding that TLV structure:
- everything is Bluetooth
- some type values are some Bluetooth vendor channels.
- these vendor channels include GNSS/FM/whatever
or 
- some type values are Bluetooth
- some other are GNSS/FM/whatever
- some are some kind of generic management (firmware download, power
  management).

The further is what is reflected by the hci_ll approach, the latter is
what is used by the ti-st approach.

It is a bit of a headache to forcefully draw in Bluetooth stuff, but as
I am using Bluetooth anyway for keyboards, I am not eager to venture
on any revive of the ti-st stuff to avoid that Bluetooth dependency 

Regards,
Andreas
