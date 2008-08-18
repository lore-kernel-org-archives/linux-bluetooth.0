Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 18 Aug 2008 15:52:51 +0200
References: <200807311452.24166.oliver@neukum.org> <200808181457.27919.oliver@neukum.org> <1219066699.7591.41.camel@violet.holtmann.net>
In-Reply-To: <1219066699.7591.41.camel@violet.holtmann.net>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808181552.52655.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 18 August 2008 15:38:19 schrieben Sie:
> Hi Oliver,
> 
> > > > > > here's my current version of btusb with SCO support. This is preliminary.
> > > > > > I am still looking at a way to delay using the higher altsettings until SCO
> > > > > > is actually used, but the timeouts seem to be too long to do the obvious.
> > > > > 
> > > > > the module parameter and blacklist/quirks stuff has been merged upstream
> > > > > with Linus now. Feel free to update your SCO support patch and then lets
> > > > > get this merged.
> > > > 
> > > > Still testing. I am new to bluetooth so getting a sound testing environment
> > > > up takes a bit of time. I am getting iso urbs to complete now.
> > > 
> > > I hacked up a version that does work fine for me and has been tested on
> > > my Quad G5. The attached applies on top of 2.6.27-rc3.
> > > 
> > > The alternate settings are still fixed to selecting #2, however the
> > > change to always select the appropriate one would be simple. We only
> > > need to calculate the right value. The killing and re-submitting URB
> > > code is already present.
> > 
> > This approach has a principal race condition. You have no idea when
> > the work queue will be run. Thus you can lose the first SCO packages.
> 
> I am open for suggestions, but I don't see any other way to get support
> for this. We can't keep the isoc URBs running all the time, because that
> consumes power.

How much? Or rather why not change the altsetting to the maximum
on open and defer submitting the URBs to notify() ?

> On the other hand, this is audio and I don't really care if we loose a
> packet or not.

It isn't limited to sound. The URBs for acl reception can also be delayed
arbitrarily long.

> > Secondly, what happens when this next event comes so quickly that
> > the work is still scheduled or running? it seems to me that the work handler
> > can read stale conn_hash values.
> 
> I don't see that happening since Bluetooth connection setup is
> serialized and we only have to make sure that bulk and isoc URBs are
> running when the connection is up.

CPU A					CPU B
HCI_NOTIFY_CONN_ADD
schedule_work(&data->work);
						hdev->conn_hash.acl_num > 0
HCI_NOTIFY_CONN_DEL
schedule_work(&data->work);

will the work handler run again?

	Regards
		Oliver
