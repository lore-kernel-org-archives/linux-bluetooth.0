Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 14 Aug 2016 13:35:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NeilBrown <neilb@suse.de>
Subject: Re: [RFC 2/7] tty: add support for "tty slave" devices
Message-ID: <20160814113513.GB21529@kroah.com>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-3-git-send-email-sre@kernel.org>
 <20160813100345.GA14665@kroah.com>
 <20160814084822.GA21321@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160814084822.GA21321@amd>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Aug 14, 2016 at 10:48:22AM +0200, Pavel Machek wrote:
> On Sat 2016-08-13 12:03:45, Greg Kroah-Hartman wrote:
> > On Sat, Aug 13, 2016 at 05:14:33AM +0200, Sebastian Reichel wrote:
> > > From: NeilBrown <neilb@suse.de>
> > > 
> > > A "tty slave" is a device connected via UART.  It may need a driver to,
> > > for example, power the device on when the tty is opened, and power it
> > > off when the tty is released.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > > @@ -3317,6 +3318,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
> > >  	retval = device_register(dev);
> > >  	if (retval)
> > >  		goto error;
> > > +	if (device && device->of_node)
> > > +		/* Children are platform devices and will be
> > > +		 * runtime_pm managed by this tty.
> > > +		 */
> > > +		of_platform_populate(device->of_node, NULL, NULL, dev);
> > 
> > Why are these platform devices?  And why only OF?
> 
> OF based systems are the only ones that have this problem, so that's
> the only place where we can test this solution.
> 
> Given that these devices are connected over the UART, it seems right
> to categorize them as platform devices... You can't connect PCI, SATA
> or USB device over UART port.

No, that's a total abuse of the platform bus, please don't.

I've said before that a "serial" bus should be created and you can hang
devices off of it.  For some reason that message keeps getting
ignored...

thanks,

greg k-h
