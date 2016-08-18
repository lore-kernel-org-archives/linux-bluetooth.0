Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 18 Aug 2016 16:58:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818145848.GA32451@kroah.com>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <20160818104749.GB7427@amd>
 <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com>
 <20160818105759.GA642@kroah.com>
 <20160818154019.40f4df45@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818154019.40f4df45@lxorguk.ukuu.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 18, 2016 at 03:40:19PM +0100, One Thousand Gnomes wrote:
> On Thu, 18 Aug 2016 12:57:59 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Aug 18, 2016 at 12:54:15PM +0200, H. Nikolaus Schaller wrote:
> > > Hi Pavel,
> > >   
> > > > Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel@ucw.cz>:
> > > > 
> > > >   
> > > >> 
> > > >> Thereof 4 files, ~260 changes w/o gps demo and documentation/bindings.  
> > > > 
> > > > So what do you use for the serial devices? platform_device was vetoed
> > > > for that purpose by Greg.  
> > > 
> > > device tree?  
> > 
> > No.
> > 
> > This patchset from Rob is the way I have been saying it should be done
> > for years now.  Yes, a "bus" takes up more boilerplate code (blame me
> > for that), but overall, it makes the drivers simpler, and fits into the
> > rest of the kernel driver/device model much better.
> 
> The basic problem is that the bus should be tty_ports not uart, fix that
> and the rest starts to make sense.

Ok, that makes sense, I missed that in the long "discussion" that
happened last time about this topic...

thanks,

greg k-h
