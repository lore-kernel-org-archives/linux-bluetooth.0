Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btmrvl_sdio: look for sd8688 firmware in
 alternate place
From: Lubomir Rintel <lkundrak@v3.sk>
To: Bing Zhao <bzhao@marvell.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, David Woodhouse <dwmw2@infradead.org>,  Ben Hutchings <ben@decadent.org.uk>, "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,  "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>,  Johan Hedberg <johan.hedberg@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430D13FDB783@SC-VEXCH1.marvell.com>
References: <1357689361-7969-1-git-send-email-lkundrak@v3.sk>
	 <1357689361-7969-2-git-send-email-lkundrak@v3.sk>
	 <1357698538.1806.43.camel@aeonflux>
	 <477F20668A386D41ADCC57781B1F70430D13FDB783@SC-VEXCH1.marvell.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Jan 2013 07:31:28 +0100
Message-ID: <1357713088.1105.1.camel@unicorn>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-01-08 at 18:43 -0800, Bing Zhao wrote:
> > > linux-firmware ships the sd8688* firmware images that are shared with
> > > libertas_sdio WiFi driver under libertas/. libertas_sdio looks in both places
> > > and so should we.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  drivers/bluetooth/btmrvl_sdio.c |   24 ++++++++++++++++++++++--
> > >  drivers/bluetooth/btmrvl_sdio.h |    6 ++++--
> > >  2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > NAK from me on this one. I do not want the driver to check two
> > locations. That is what userspace can work around.
> > 
> > If we want to unify the location between the WiFi driver and the
> > Bluetooth driver, I am fine with that, but seriously, just pick one over
> > the other. I do not care which one.
> 
> The unified location is mrvl/ directory.
> 
> We can probably move SD8688 firmware & helper binaries to mrvl/ and have both drivers grab the images there?

That would break existing setups, wouldn't it?

I was under impression (commit 3d32a58b) that we care about
compatibility here. Do we?

--
Lubomir Rintel
