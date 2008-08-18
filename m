Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 18 Aug 2008 16:27:25 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808181552.52655.oliver@neukum.org> <1219068620.7591.52.camel@violet.holtmann.net>
In-Reply-To: <1219068620.7591.52.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808181627.27053.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 18 August 2008 16:10:20 schrieb Marcel Holtmann:

> run powertop and you will see why we can't do that. Also there is no max
> altsetting. It doesn't work like this. You have to pick the right one.
> 
> The Bluetooth USB spec. is messed up when it comes to SCO.

Very well, it can't be helped then.

> > > On the other hand, this is audio and I don't really care if we loose a
> > > packet or not.
> > 
> > It isn't limited to sound. The URBs for acl reception can also be delayed
> > arbitrarily long.
> 
> We can move that into the notify() callback, but the killing the URBs
> becomes a problem.

/**
 * usb_unlink_anchored_urbs - asynchronously cancel transfer requests en masse
 * @anchor: anchor the requests are bound to
 *
 * this allows all outstanding URBs to be unlinked starting
 * from the back of the queue. This function is asynchronous.
 * The unlinking is just tiggered. It may happen after this
 * function has returned.
 */
void usb_unlink_anchored_urbs(struct usb_anchor *anchor)

> On the other hand, ACL shouldn't be any problem since there is a HCI
> connection setup in between and the ACL part of Bluetooth is reliable
> and we have flow control on it.
> 
> Also these are bulk URBs. I am under the assumption that the Bluetooth
> controller will queue packets up until we submit the first URB.
> 
> > > > Secondly, what happens when this next event comes so quickly that
> > > > the work is still scheduled or running? it seems to me that the work handler
> > > > can read stale conn_hash values.
> > > 
> > > I don't see that happening since Bluetooth connection setup is
> > > serialized and we only have to make sure that bulk and isoc URBs are
> > > running when the connection is up.
> > 
> > CPU A					CPU B
> > HCI_NOTIFY_CONN_ADD
> > schedule_work(&data->work);
> > 						hdev->conn_hash.acl_num > 0
> > HCI_NOTIFY_CONN_DEL
> > schedule_work(&data->work);
> > 
> > will the work handler run again?
> 
> As I said, the ACL and SCO connection setup is serialized. While in
> theory this can happen, I don't see it in practice.
> 
> What would be your proposal to handle this in a cleaner way?

Difficult. I was hoping to avoid scheduling work. I have to rethink.

	Regards
		Oliver
