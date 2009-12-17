Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]btusb:Prevent illtimed autosuspend
Date: Thu, 17 Dec 2009 09:31:00 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Matthew Garrett <mjg59@srcf.ucam.org>,
 linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <200912161923.43127.oliver@neukum.org> <1261006677.4041.41.camel@localhost.localdomain> <20091216235449.GA6108@kroah.com>
In-Reply-To: <20091216235449.GA6108@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912170931.00394.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 17. Dezember 2009 00:54:50 schrieb Greg KH:
> On Wed, Dec 16, 2009 at 03:37:57PM -0800, Marcel Holtmann wrote:
> > Hi Oliver and Matthew,
> > 
> > > > commit 0b72b0a05c1d950e4f35520926cc36bc01fb998a
> > > > Author: Oliver Neukum <oliver@neukum.org>
> > > > Date:   Mon Dec 14 22:09:49 2009 +0100
> > > > 
> > > >     btusb:Prevent illtimed autosuspend
> > > >     
> > > >     The device must be marked busy as it recieves data.
> > > >     
> > > >     Signed-off-by: Oliver Neukum <oliver@neukum.org>
> > > 
> > > Tested-by: Matthew Garrett <mjg@redhat.com>
> > 
> > thanks for figuring this out. I will queue this patch up along with the
> > other changes and send them to Dave this week.
> 
> This also might be a -stable patch, right?  Care to mark it as such?

Oh, you are right. Sorry, yes, this should go into 2.6.32 stable,
but nothing earlier. I forgot when btusb autosuspend went in.

	Sorry
		Oliver
