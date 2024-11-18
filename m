Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E2158DAC
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968287; cv=none; b=NE4kLOi73fZaXVVSJtG8zPN8HSvhJkQlpDEWAfDtto3OKpaA0pEH5MP/RqHYKWrAbN3pLpM/TuL5H8MeYraUF8YWkqUhA1OpouyShDHQSO1KKfYyTKLH9A7UqT6uywUrCbAdoss5TFWTVPKCzArxwL4b2/uDkVMMOvlAtCWqgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968287; c=relaxed/simple;
	bh=8tdPTsZfyOqzFtGrHcy+A1KsPD6ywqAcYjPk118v3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZe/CCYhJYtBw/ksOCr1N7RfhIhXzLMsFr0WC70IjvQZaJAWoI0jUAEnoWiebHoYyBhQhfZwcy2CdTfc6MPJbX4TWWLXFFumLeC17mwreOcxxe6eW/e5paiaWfmT05rYTqyOlVbigz/k81pdEZPdYEqSdLxYiMsMjQ7uYL0iIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDA4G-0004Fu-0E; Mon, 18 Nov 2024 23:18:00 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDA4F-001Srj-14;
	Mon, 18 Nov 2024 23:17:59 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDA4F-001Yme-0i;
	Mon, 18 Nov 2024 23:17:59 +0100
Date: Mon, 18 Nov 2024 23:17:59 +0100
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
Message-ID: <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
References: <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028150048.qnqjxntns6quy7py@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028150048.qnqjxntns6quy7py@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

Hi,

gentle ping on this discussion since I'm still convinced that this the
correct approach to add the reset mechanism and handle the power.

Regards,
  Marco

On 24-10-28, Marco Felsch wrote:
> On 24-10-28, Sherry Sun wrote:
> > 
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > 
> > > On 24-10-28, Sherry Sun wrote:
> > > >
> > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 24-10-28, Sherry Sun wrote:
> > > > > >
> > > > > > > From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
> > > > > > >
> > > > > > > We use the NXP downstream driver mwifiex which doesn't have
> > > > > > > support for regulator or PDn.
> > > > > > >
> > > > > > > However, regulator is already supported by the MMC core (vmmc-
> > > supply).
> > > > > > >
> > > > > > > For PDn, we use mmc pwrseq simple driver that has been patched
> > > > > > > to add support for reset-control.
> > > > > >
> > > > > > Ok, thanks, the mmc change looks good for me, so there is no
> > > > > > problem with the NXP SDIO wifi.
> > > > > >
> > > > > > But how do you plan to handle the NXP PCIe wifi? We also need to
> > > > > > make sure the BT patch won't break the PCIe wifi function.
> > > > >
> > > > > Can you please elaborate how this could break the PCIe use-case?
> > > >
> > > > Similar to the SDIO wifi, if no corresponding reset control for the
> > > > PDn pin in PCIe wifi driver, the wifi part will be unexpectedly
> > > > powered off when removing the BT driver.
> > > 
> > > Nope it's not that easy for PCIe case since the phy + link layer handling is
> > > much more complex compared to the MMC case. For the PCIe case the intial
> > > handling is very strict according to the PCIe spec and we can't handle the BT
> > > device independently.
> > > 
> > > _BUT_ this patch doesn't cause any regression for the PCIe use-case since the
> > > support added by Catalin is optional which means that the user don't have to
> > > use these options.
> > > 
> > > To sum up:
> > > 
> > > WLAN (PCIe) used + BT (UART) used -> no independent handling
> > >                                      possible. BT depends on WLAN.
> > > 
> > > WLAN (PCIe) not used + BT (UART) used -> This patchset allow us to
> > >                                          handle BT. Without the patchset
> > > 					 this is not possible.
> > > 
> > > WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq patchset
> > >                            allow us to handle WLAN and BT independently
> > > 			   regardless if BT or WLAN is used or not.
> > 
> > If we add the reset-gpios property in the BT dts node when using the
> > SDIO wifi chip, my concern is for some host platforms, taking
> > i.MX95-19x19-EVK as an example, it supports both SDIO and PCIe
> > interface wifi chip through the M.2 connector, when customers want to
> > plug in the PCIe wifi chip, they have to remove the reset-gpios in the
> > BT dts node to avoid the PCIe WLAN been affected by BT, right?
> 
> I don't know the i.MX95-19x19-EVK platform since it is not upstream. If
> you want to support both:
> 
> > > WLAN (PCIe) used + BT (UART) used -> no independent handling
> > >                                      possible. BT depends on WLAN.
> 
> and
> 
> > > WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq patchset
> > >                            allow us to handle WLAN and BT independently
> > > 			   regardless if BT or WLAN is used or not.
> 
> you need to stick with the dependent handling which is no problem once
> this patchset get applied if your system support hot-plug. If hot-plug
> is not possible you could consider unsing overlays.
> 
> However, this patchset does _NOT_ cause any regression neither for the
> MMC nor the PCIe use-case, and you don't have to touch your DTS files. It
> would be an improvement for platforms (not speaking of NXP EVK
> platforms) which utilize the MMC+UART interfaces only.
> 
> > And it looks strange that we can only add the reset-gpios BT property
> > to the hosts that only support SDIO WLAN, we hope there is a solution
> > for the PCIe WLAN too.
> 
> "We hope there is a solution" <-- This is not how upstream work.
> 
> Also as said: The WLAN PCIe interface must/should be compatible with the
> PCIe Spec. There is no way that we can handle both devices
> independent since the PCIe spec specifies the power-up-sequence very
> strict.
> 
> If for example, we do handle it independent and the BT part brings the
> device out-of-reset while the PCIe bus is not yet ready, the device's
> WLAN PCIe subsystem may get confused.
> 
> There are two solution NXP could provide:
> 
>  - The PCIe WLAN/BT devices exposes all devices WLAN + BT via PCIe, this
>    would eliminate the UART part.
>  - All new WLAN/BT devices do have a separate hw reset line for each
>    radio the device supports.
> 
> Regards,
>   Marco
