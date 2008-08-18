Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808181552.52655.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808181457.27919.oliver@neukum.org>
	 <1219066699.7591.41.camel@violet.holtmann.net>
	 <200808181552.52655.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 18 Aug 2008 16:10:20 +0200
Message-Id: <1219068620.7591.52.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > > > > here's my current version of btusb with SCO support. This is preliminary.
> > > > > > > I am still looking at a way to delay using the higher altsettings until SCO
> > > > > > > is actually used, but the timeouts seem to be too long to do the obvious.
> > > > > > 
> > > > > > the module parameter and blacklist/quirks stuff has been merged upstream
> > > > > > with Linus now. Feel free to update your SCO support patch and then lets
> > > > > > get this merged.
> > > > > 
> > > > > Still testing. I am new to bluetooth so getting a sound testing environment
> > > > > up takes a bit of time. I am getting iso urbs to complete now.
> > > > 
> > > > I hacked up a version that does work fine for me and has been tested on
> > > > my Quad G5. The attached applies on top of 2.6.27-rc3.
> > > > 
> > > > The alternate settings are still fixed to selecting #2, however the
> > > > change to always select the appropriate one would be simple. We only
> > > > need to calculate the right value. The killing and re-submitting URB
> > > > code is already present.
> > > 
> > > This approach has a principal race condition. You have no idea when
> > > the work queue will be run. Thus you can lose the first SCO packages.
> > 
> > I am open for suggestions, but I don't see any other way to get support
> > for this. We can't keep the isoc URBs running all the time, because that
> > consumes power.
> 
> How much? Or rather why not change the altsetting to the maximum
> on open and defer submitting the URBs to notify() ?

run powertop and you will see why we can't do that. Also there is no max
altsetting. It doesn't work like this. You have to pick the right one.

The Bluetooth USB spec. is messed up when it comes to SCO.

> > On the other hand, this is audio and I don't really care if we loose a
> > packet or not.
> 
> It isn't limited to sound. The URBs for acl reception can also be delayed
> arbitrarily long.

We can move that into the notify() callback, but the killing the URBs
becomes a problem.

On the other hand, ACL shouldn't be any problem since there is a HCI
connection setup in between and the ACL part of Bluetooth is reliable
and we have flow control on it.

Also these are bulk URBs. I am under the assumption that the Bluetooth
controller will queue packets up until we submit the first URB.

> > > Secondly, what happens when this next event comes so quickly that
> > > the work is still scheduled or running? it seems to me that the work handler
> > > can read stale conn_hash values.
> > 
> > I don't see that happening since Bluetooth connection setup is
> > serialized and we only have to make sure that bulk and isoc URBs are
> > running when the connection is up.
> 
> CPU A					CPU B
> HCI_NOTIFY_CONN_ADD
> schedule_work(&data->work);
> 						hdev->conn_hash.acl_num > 0
> HCI_NOTIFY_CONN_DEL
> schedule_work(&data->work);
> 
> will the work handler run again?

As I said, the ACL and SCO connection setup is serialized. While in
theory this can happen, I don't see it in practice.

What would be your proposal to handle this in a cleaner way?

Regards

Marcel


