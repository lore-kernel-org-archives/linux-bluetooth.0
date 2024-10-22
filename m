Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598B450EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581144; cv=none; b=iL4nXy0vh3orF3Ah28sSfyZqY0qQHBSowazQJSfkuN8kJyM6erOUjOTCXYxvVfENNuVJD7EhU6oscLj9UUXc0RSw4HyOhLHLAp00OYZiHNpzs6zlgiQg5hBaNqo7sXIAPetiDws607PN34omuJ77gg1WU6IoODF0rAtzKCjaFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581144; c=relaxed/simple;
	bh=0ll3gPv7b5EnxMpQXjTWBZqajMHhngE0X2+8q2/Aamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd9tn7djw1effIuO4BmU6ez5R6wrXKVe0JIvGRdCNJJmD5tLx6c8YqrzRdL6eqpOO6WVLXOB7rfjUIqjFqnOY/ECbEGavrL4NEVieCNkiilJ3AbHIh9PY1skv1IcfY+8p/31phaOpU/n0gQcp4DiWAnfV/ivzmX8Bd16JKSUorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t393p-0003Is-ET; Tue, 22 Oct 2024 09:12:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t393o-000pD5-34;
	Tue, 22 Oct 2024 09:12:08 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t393o-007VXc-2i;
	Tue, 22 Oct 2024 09:12:08 +0200
Date: Tue, 22 Oct 2024 09:12:08 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
	Sherry Sun <sherry.sun@nxp.com>,
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
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Message-ID: <20241022071208.lgk2rpl2c2qpytfa@pengutronix.de>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <e7a1622e-6406-478f-bd3e-08a8490d4db0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a1622e-6406-478f-bd3e-08a8490d4db0@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

On 24-10-22, Krzysztof Kozlowski wrote:
> On 21/10/2024 12:25, Marco Felsch wrote:
> > On 24-10-21, Krzysztof Kozlowski wrote:
> >> On 21/10/2024 08:41, Marco Felsch wrote:
> >>> On 24-10-07, Krzysztof Kozlowski wrote:

...

> >>>> Based on earlier message:
> >>>>
> >>>> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means
> >>>> that both wifi and BT controller will be powered on and off at the same
> >>>> time."
> >>>>
> >>>> but maybe that's not needed. No clue, I don't know the hardware. But be
> >>>> carefully what you write in the bindings, because then it will be ABI.
> >>>
> >>> We noticed the new power-sequencing infrastructure which is part of 6.11
> >>> too but I don't think that this patch is wrong. The DT ABI won't break
> >>> if we switch to the power-sequencing later on since the "reset-gpios"
> >>> are not marked as required. So it is up to the driver to handle it
> >>> either via a separate power-sequence driver or via "power-supply" and
> >>> "reset-gpios" directly.
> >>
> >> That's not the point. We expect correct hardware description. If you say
> >> now it has "reset-gpios" but later say "actually no, because it has
> >> PMU", I respond: no. Describe the hardware, not current Linux.
> > 
> > I know that DT abstracts the HW. That said I don't see the problem with
> > this patch. The HW is abstracted just fine:
> > 
> > shared PDn          -> reset-gpios
> > shared power-supply -> vcc-supply
> > 
> > Right now the DT ABI for the BT part is incomplete since it assume a
> > running WLAN part or some hog-gpios to pull the device out-of-reset
> > which is addressed by this patchset.
> > 
> > Making use of the new power-sequencing fw is a Linux detail and I don't
> > see why the DT can't be extended later on. We always extend the DT if
> > something is missing or if we found a better way to handle devices.
> 
> Sure, although I am not really confident that you understand the
> implications - you will not be able to switch to proper power-sequencing
> with above bindings, because it will not be just possible without
> breaking the ABI or changing hardware description (which you say it is
> "fine", so complete/done). I am fine with it, just mind the implications.

Sorry can you please share your concerns? I don't get the point yet why
we do break the DT ABI if we are going from

bt {
	reset-gpios = <&gpio 4 0>;
	vcc-supply = <&supply>;
};

to

bt {
	vcc-supply = <&pmu_supply>;
};

or:

bt {
	pmu = <&pmu>;
};

Of course the driver need to support all 2/3 cases due to backward
compatibility but from DT pov I don't see any breakage since we already
need to define the power handling properties (gpio & supply) as
optional.

That beeing said I don't see the need for a PMU driver for this WLAN/BT
combi chip which is way simpler than the Qualcomm one from Bartosz. Also
there is physically no PMU device which powers the chip unlike the
Qualcomm one. I'm not sure if you would accept virtual PMU devices.

Regards,
  Marco

> Best regards,
> Krzysztof
> 
> 
