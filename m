Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ and the ALSA support
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A0F6F4.6070707@dark-reality.de>
References: <1100995285.7250.17.camel@pegasus>
	 <41A027BD.5020401@xmission.com> <1101057242.7250.34.camel@pegasus>
	 <41A0D34C.8070400@dark-reality.de> <1101061573.7250.68.camel@pegasus>
	 <41A0F6F4.6070707@dark-reality.de>
Content-Type: text/plain
Message-Id: <1101069548.7250.77.camel@pegasus>
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
Date: Sun, 21 Nov 2004 21:39:08 +0100

Hi Lars,

> | My problem is that I haven't written all of the hci_usb driver code and
> | some parts are still so messy that I think a complete rewrite is the
> | best that we can do.
> 
> I see, did not know that.

we use our own URB management and this is bad and ugly :(

> | But what I will do is to add a module parameter for
> | choosing the alternate setting that can be changed at runtime. To bring
> | up a device with a new alternate setting you only have to unplug and
> | then plug it in again. This is not the solution we should have, but it
> | will help us with testing the SCO stuff without recompiling the kernel
> | every time.
> 
> Yes, that would be a first step.

Maybe I get this done tomorrow.

> I hope I can have a look at the way how usb_hci works, so that I can
> understand when an asynchronus/delayed change of the endpoint selection
> could happen - or how we could get rid of not-send urbs. *sigh* just
> need more time...
> 
> don't you think it should be possible to
> a) block the submit of new urbs when a change notify has arrived
> b) queue until the queue is empty
> c) change the endpoint setting and release the block
> 
> I don't know to which bad runs or locks this could lead...

To be honest, I don't know. This ISOC stuff is still a mystery to me and
so far I don't know of any Linux driver that is using the ISOC transfers
and have to change the alternate setting at the same time. Selecting it
at probe() time is very easy.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
