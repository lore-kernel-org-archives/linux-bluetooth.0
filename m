Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter
	getting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051108143127.GA7773@localhost.localdomain>
References: <1131315924.5824.14.camel@blade>
	 <20051107093436.GB6845@localhost.localdomain>
	 <1131359661.5824.97.camel@blade>
	 <20051107121354.GA9950@localhost.localdomain>
	 <1131368088.5824.116.camel@blade>
	 <e1effdeb0511070612u7555e383kaaade3f1f0c7bbd1@mail.gmail.com>
	 <20051107145430.GA12669@localhost.localdomain>
	 <1131397067.5824.145.camel@blade>
	 <20051107215732.GA19351@localhost.localdomain>
	 <1131457496.5824.172.camel@blade>
	 <20051108143127.GA7773@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131461076.5824.189.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 08 Nov 2005 15:44:36 +0100

Hi Johan,

> > > Ok, I see your point. I didn't quite understand the use-case you were
> > > thinking of earlier. One extra requirement that the dbus-id settings has
> > > is that we will have to monitor the lifetime of a D-BUS client (by
> > > listening NameOwnerChanged D-BUS signals) and remove the corresponding
> > > entry from the settings table when an id gets removed from the bus.
> > 
> > this might be too much work for the current interface. Or do you think
> > it can be easily implemented?
> 
> It will require a moderate amount of coding, so it wont be easy at least
> in that respect. However, I think that implementing D-BUS client
> lifetime monitoring is a feature that we will inevitably have to
> implement at some point anyway. It may e.g. be needed for noticing if a
> program which requested an RFCOMM connection suddenly died (in which
> case hcid/bluetoothd should disconnect that connection). Also, I've
> already done it once (for dbus 0.23.4 though) for the D-BUS API we have
> in maemo, so there shouldn't come any "supprises" when implementing it.

then lets do it. Or to be more precise, you do it ;)

> > > Ok, I'll begin by doing a patch for Inquiry and PeriodicInquiry
> > > (probably during tomorrow).
> > 
> > This would be great. For the next release I like to have the inquiry (or
> > better name it device discovery) working. This will include some nice
> > support for the extended inquiry. So you will get the remote name for
> > free with a discovery. So is it possible to have different signatures
> > for signals too?
> 
> Sure, and if the new signature differs only by having extra parameters
> at the end it should even be backwards compatible (i.e.
> dbus_message_get_args call for the old signature works also for the new
> signature).

Then I think that I will include the device name in the inquiry response
signal and leave further extensions to a different signature.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
