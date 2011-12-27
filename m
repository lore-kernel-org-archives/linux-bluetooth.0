Return-Path: <cyrus@holtmann.org>
Message-ID: <1325012849.1965.273.camel@aeonflux>
Subject: Re: [PATCH v3] Add USB ID of HP's Broadcom BCM2035 Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Pool <albertpool@solcon.nl>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 27 Dec 2011 11:07:29 -0800
In-Reply-To: <1325012535.2109.10.camel@albert-ASUSTeK-P4P800SE>
References: <1324728064.3074.5.camel@albert-ASUSTeK-P4P800SE>
	 <20111227160323.GA8298@joana>  <1325008493.1965.270.camel@aeonflux>
	 <1325012535.2109.10.camel@albert-ASUSTeK-P4P800SE>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

please refrain from top-posting on this mailing list.

> I think the desktop's dongle might be to blame when the old laptop fails
> to pair to that. I've had more Bluetooth problems on the desktop, e.g.
> being unable to remove paired devices of the dongle's previous owner.
> 
> The Bluetooth sticker on the downside of the old laptop lists:
> Broadcom BCM92035NMD CE 370653-003
> Universal Scientific Industrial
> Contains FCC ID: QDS-BRCM1009
> IC: 4324A-BRCM1009
> SCT: RCPBRBC04-389
> CMI ID: 2003DJ1517
> CNC 16-3215
> along with a lot of text in other languages.
> 
> Other BCM2035 USB ID's have BTUSB_WRONG_SCO_MTU but that option really
> does not work reliably on this old laptop.

The need for WRONG_SCO_MTU detail can be easily determined. Check the
output of hciconfig without this quirk. If the SCO MTU essentially shows
0 values, then you need it.

But then again, you are just randomly adding quirks without
understanding what they are for. This makes me worry a lot.

Are you actually running a recent 3.x kernel or are you just using an
outdated kernel?

Regards

Marcel


