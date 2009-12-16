Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Dec 2009 15:54:50 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH]btusb:Prevent illtimed autosuspend
Message-ID: <20091216235449.GA6108@kroah.com>
References: <200912161923.43127.oliver@neukum.org>
 <20091216182600.GA20031@srcf.ucam.org>
 <1261006677.4041.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1261006677.4041.41.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 16, 2009 at 03:37:57PM -0800, Marcel Holtmann wrote:
> Hi Oliver and Matthew,
> 
> > > commit 0b72b0a05c1d950e4f35520926cc36bc01fb998a
> > > Author: Oliver Neukum <oliver@neukum.org>
> > > Date:   Mon Dec 14 22:09:49 2009 +0100
> > > 
> > >     btusb:Prevent illtimed autosuspend
> > >     
> > >     The device must be marked busy as it recieves data.
> > >     
> > >     Signed-off-by: Oliver Neukum <oliver@neukum.org>
> > 
> > Tested-by: Matthew Garrett <mjg@redhat.com>
> 
> thanks for figuring this out. I will queue this patch up along with the
> other changes and send them to Dave this week.

This also might be a -stable patch, right?  Care to mark it as such?

thanks,

greg k-h
