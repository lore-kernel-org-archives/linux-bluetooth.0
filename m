Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC281C1AD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020698; cv=none; b=YB35AV3E90SMVoeew1a662MZmgYvLF83ZzPggWCOVXNln5Ws4Bu1xdpiPquYZCsmdUK1itOE8zzOSAblOj1orlmvCsbUFGQmkXIkfCsiepXmEPCQjs3+AGMGtFpUhyyhB1nJm+lxlahq1Z/ZJKqDEwITF6NWvvHY/3Y/fGqWqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020698; c=relaxed/simple;
	bh=8+kO+hmaFU9f3uoEfpMUg23Td4M9jDSb8ePHUvCGZKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk6iU+rMLoMu4h40Q3qwMB/cvAxsGfAW92ifrcgAaCTFufZvzMvL0aL4dyYGk/h0nlRnQ6pz9EraKmSZoFyYVUO1svxPXWBeGpZWWIk5vYcwjvBdRrTTSYK12WYLEJVHEXNfTQaB8jOSZ4M+DIFSXgK/hYb27zpwft/kx5ub5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDNhc-0003uq-NH; Tue, 19 Nov 2024 13:51:32 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDNhc-001ZKn-0G;
	Tue, 19 Nov 2024 13:51:32 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tDNhb-003KVN-38;
	Tue, 19 Nov 2024 13:51:31 +0100
Date: Tue, 19 Nov 2024 13:51:31 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Bough Chen <haibo.chen@nxp.com>,
	POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
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
	Krzysztof Kozlowski <krzk@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Message-ID: <20241119125131.pb5lkeryldsl7htq@pengutronix.de>
References: <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028150048.qnqjxntns6quy7py@pengutronix.de>
 <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
 <DB9PR04MB84299E3E1776C60F5D1F0FF792202@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84299E3E1776C60F5D1F0FF792202@DB9PR04MB8429.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

On 24-11-19, Sherry Sun wrote:
> 
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > 
> > Hi,
> > 
> > gentle ping on this discussion since I'm still convinced that this the correct
> > approach to add the reset mechanism and handle the power.
> 
> Hi Marco,
> 
> Sorry for the late reply. After internal discussion, we still have
> some confusion regarding this new feature.
> This patch do improve the independent handling of wifi/BT, but with
> the controlling granularity segmentation, many different wifi/BT use
> cases need to be considered.

Sure!

> For the case -- WLAN (SDIO) not used + BT (UART) used:
>
> The ideal behavior of BT should be reset and the standalone BT FW
> should be re-downloaded when unloading and re-loading the BT driver.

To make it clear, I assumed that it's clear that independent
(sub-)device handling require independent firmware (fw) files, which can
be the case. NXP already supplies independent FW files for bt and wifi.
We just need to ensure that the drivers are using these.

That said the bt driver already checks if the fw has to be downloaded.

> However, due to the regulator control and PDn reset control are bound
> to the SDIO bus instead of the WLAN device, the SDIO bus may be ready
> after kernel boot up.

Right, but this is a separate discussion not belonging to these driver
changes. Also it's the common chicken-egg issue. You need to power the
bus and release the device-reset before you can check which device is
connected and to check if there would be a proper driver.

> Although the WLAN is not used(WLAN driver is not loaded and WLAN FW is
> not downloaded), the corresponding regulator count and PDn reset count
> are both incremented by 1 through MMC pwrseq. Then with the BT driver
> remove & re-probe, the PDn reset cannot truly reset the BT chip due to
> the count been +1 by MMC pwrseq.  So the BT will not reset and BT FW
> won't be re-downloaded when re-loading the BT driver, right?

You're aware that the btnxpuart.c driver already has the support for an
independent software based reset? Not sure what this sw-reset does, due
to the lack of missing documentation, but this is the only option to
over-come your above mentioned use-case.

I have to ask, is this really a use-case for someone? Either your device
supports both: WLAN and BT or only one of WLAN/BT. If it would be only
BT or WLAN you just don't need the specify the other one within your
devicetree.

Furthermore, this patchset does not break any current use-case you/NXP
has. You still can use the combined fw version and still can use the not
so user friendly user-space dependency of: "wlan driver _must_ be
loaded" before the "bt driver _can_ be loaded" by just not using the
split power handling. For use-space which wants to use the split version
because there is no such dependecy.

Regards,
  Marco
