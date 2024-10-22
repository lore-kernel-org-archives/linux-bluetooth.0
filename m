Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86884A22
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581797; cv=none; b=Oug/ij9KW9xuTYZ1jmWWDH1COJlFRL4VQYNjj6oy9ryQ6ESAWLI+Wyfj8k2W5jupNFHKFIFJ78nNtkiyRBNIH18zwQOI/P+VgwRBiq6TSV/w3ePoB7yqwCBaR8HEBnsl6p2xIYT8Dfuap1Xo39bxMhlXfEDLNriTI9h1ytdUtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581797; c=relaxed/simple;
	bh=hOKrI3GQqLEYrRGRQ4W1xaNqTzfZ590TisBLQIuIizQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa4ZJ7z5i+28xcki6TMuYp0gaEKnRkQMr691qMCT6NBYN0UJjdsUCfQYjc1fYOrkn6bjVX7SueH4mujGWPWVv60g/maxU0r/aLNBJGG6ucziIi9Ish6g3v+ZQaHvc3O9rmwMwFvsbaeIEpWINwiMO+dyebgl2x+ypeUwePV+1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t39EW-0003v3-2i; Tue, 22 Oct 2024 09:23:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t39EV-000pEO-1c;
	Tue, 22 Oct 2024 09:23:11 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t39EV-007Vcd-1H;
	Tue, 22 Oct 2024 09:23:11 +0200
Date: Tue, 22 Oct 2024 09:23:11 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Message-ID: <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

On 24-10-22, Sherry Sun wrote:
> > On 24-10-21, Krzysztof Kozlowski wrote:
> > > On 21/10/2024 08:41, Marco Felsch wrote:
> > > > On 24-10-07, Krzysztof Kozlowski wrote:
> > > >> On 07/10/2024 14:58, POPESCU Catalin wrote:
> > > >>>>>>
> > > >>>>>> +  vcc-supply:
> > > >>>>>> +    description:
> > > >>>>>> +      phandle of the regulator that provides the supply voltage.
> > > >>>>>> +
> > > >>>>>> +  reset-gpios:
> > > >>>>>> +    description:
> > > >>>>>> +      Chip powerdown/reset signal (PDn).
> > > >>>>>> +
> > > >>>>> Hi Catalin,
> > > >>>>>
> > > >>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which
> > means that both wifi and BT controller will be powered on and off at the
> > same time.
> > > >>>>> Taking the M.2 NXP WIFI/BT module as an example,
> > pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we has already
> > controlled this pin in the corresponding PCIe/SDIO controller dts nodes.
> > > >>>>> It is not clear to me what exactly pins for vcc-supply and reset-gpios
> > you describing here. Can you help understand the corresponding pins on M.2
> > interface as an example? Thanks.
> > > >>>
> > > >>> Hi Sherry,
> > > >>>
> > > >>> Regulators and reset controls being refcounted, we can then
> > > >>> implement powerup sequence in both bluetooth/wlan drivers and have
> > > >>> the drivers operate independently. This way bluetooth driver would
> > > >>> has no dependance on the wlan driver for :
> > > >>>
> > > >>> - its power supply
> > > >>>
> > > >>> - its reset pin (PDn)
> > > >>>
> > > >>> - its firmware (being downloaded as part of the combo firmware)
> > > >>>
> > > >>> For the wlan driver we use mmc power sequence to drive the chip
> > > >>> reset pin and there's another patchset that adds support for reset
> > > >>> control into the mmc pwrseq simple driver.
> > > >>>
> > > >>>> Please wrap your replies.
> > > >>>>
> > > >>>> It seems you need power sequencing just like Bartosz did for
> > Qualcomm WCN.
> > > >>>
> > > >>> Hi Krzysztof,
> > > >>>
> > > >>> I'm not familiar with power sequencing, but looks like way more
> > > >>> complicated than reset controls. So, why power sequencing is
> > > >>> recommended here ? Is it b/c a supply is involved ?
> > > >>
> > > >> Based on earlier message:
> > > >>
> > > >> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which
> > > >> means that both wifi and BT controller will be powered on and off
> > > >> at the same time."
> > > >>
> > > >> but maybe that's not needed. No clue, I don't know the hardware.
> > > >> But be carefully what you write in the bindings, because then it will be
> > ABI.
> > > >
> > > > We noticed the new power-sequencing infrastructure which is part of
> > > > 6.11 too but I don't think that this patch is wrong. The DT ABI
> > > > won't break if we switch to the power-sequencing later on since the
> > "reset-gpios"
> > > > are not marked as required. So it is up to the driver to handle it
> > > > either via a separate power-sequence driver or via "power-supply"
> > > > and "reset-gpios" directly.
> > >
> > > That's not the point. We expect correct hardware description. If you
> > > say now it has "reset-gpios" but later say "actually no, because it
> > > has PMU", I respond: no. Describe the hardware, not current Linux.
> > 
> > I know that DT abstracts the HW. That said I don't see the problem with this
> > patch. The HW is abstracted just fine:
> > 
> > shared PDn          -> reset-gpios
> > shared power-supply -> vcc-supply
> 
> Actually we should use vcc-supply to control the PDn pin, this is the
> power supply for NXP wifi/BT.

Please don't since this is regular pin on the wlan/bt device not the
regulator. People often do that for GPIOs if the driver is missing the
support to pull the reset/pdn/enable gpio but the enable-gpio on the
regulator is to enable the regulator and _not_ the bt/wlan device.

Therefore the implementation Catalin provided is the correct one.

Regards,
  Marco
