Return-Path: <cyrus@holtmann.org>
Subject: Re: The link I had working quit.  Help
From: Bastien Nocera <hadess@hadess.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20090407200201.GA18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net>
	 <200904061457.02511.gene.heskett@verizon.net>
	 <20090406221444.GA25011@dactyl.hungrycats.org>
	 <200904071454.54317.gene.heskett@verizon.net>
	 <20090407200201.GA18671@hungrycats.org>
Content-Type: text/plain
Date: Wed, 08 Apr 2009 00:05:18 +0100
Message-Id: <1239145518.20817.915.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-04-07 at 16:02 -0400, Zygo Blaxell wrote:
> 
> On Tue, Apr 07, 2009 at 02:54:54PM -0400, Gene Heskett wrote:
> > But nothing seems to enable the pairing, and everytime I do that
> that far in 
> > the 'bluetooth-wizard' and it sees the eb101, it tells me to enter
> an 
> > apparently randomly derived 4 digit pin number, but the wizard gives
> me no 
> > place to enter it. Nor is there a 'proceed' button, and in 5 seconds
> or so it 
> > clears that screen and reports pairing failed.
> 
> bluez-gnome (where your bluetooth-wizard comes from?) has a really
> stupid
> UI design.  If bluetooth-wizard thinks you *can* enter a PIN into your
> device, it will *require* you to enter a random one.  This idea
> doesn't
> work so well on devices that don't have keyboards or that have fixed
> PINs,
> and bluetooth-wizard knows only about broad categories of devices and
> a
> handful of exceptions.  The opposite problem occurs on devices where
> bluez-gnome thinks it knows a fixed-PIN device's PIN, but it actually
> doesn't.
> 
> Also, bluez-gnome's discovery page won't show you discoverable devices
> that
> are already known, so it can't tell you if a known device is in range.
> 'hcitool scan' will tell you about all devices in range, but it causes
> some
> problems for bluetoothd if both are running at the same time.
> 
> If you can, use simple-agent instead of bluetooth-wizard.

Or you can use gnome-bluetooth which has those problems fixed.

