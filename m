Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question about hci_usb endpoint selection...
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <417149FD.6090700@dark-reality.de>
References: <416D23A6.3010904@dark-reality.de>
	 <1097752849.4640.37.camel@notepaq>  <416EF4B0.6070802@dark-reality.de>
	 <1097928414.4911.27.camel@pegasus>  <417149FD.6090700@dark-reality.de>
Content-Type: text/plain
Message-Id: <1098013275.4911.44.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 17 Oct 2004 13:41:15 +0200

Hi Lars,

> Can you please describe how I can access your Bitkeeper repository? I
> never used Bitkeeper before, and I'd rather not because of it's strange
> license issues and stuff. Will this changes be in the MH-patches
> sometime soon? Right now I'm trying to understand how things work, and I
> think it'll be at least one more week until I can modprobe something
> that might work, so I can wait a bit for a next release. Of course, if
> you don't plan to release patches containing this changes soon, I'll use
> Bitkeeper.

I am waiting for the final 2.6.9 release before I put out my next -mh
patch. So it should be very soon. Otherwise check the Bitkeeper docs in
the kernel source.

> OK, after digging for an USB API documentation I found:
> 
> ***
> ~ int usb_set_interface(struct usb_device *dev, int interface, int
> alternate);
> ***
> 
> The documentation/manpage says:
> 
> ***
> Note that in the Linux USB subsystem, bandwidth associated with an
> endpoint in a given alternate setting is not reserved until an URB is
> submitted that needs that bandwidth. Some other operating systems
> allocate bandwidth early, when a configuration is chosen.
> 
> This call is synchronous, and may not be used in an interrupt context.
> Also, drivers must not change altsettings while urbs are scheduled for
> endpoints in that interface; all such urbs must first be completed
> (perhaps forced by unlinking).
> ***
> 
> Questions I'm unable to answer myself right now:
> 
> 1. are we in an interrupt context? (don't think so)

You can check this with in_interrupt() and I think we are in interrupt
context when notify() is called.

> 2. how can we make sure that there are no pending urbs? maybe we have to
> change the setting asynchronus in the transmit function or something? Or
> should we unlink pending SCO URBs?

I think you can't. We have to unlink them and resubmit them, but I don't
know this for sure.

> 3. can we safely assume that the endpoint ID's that are stored in
> isoc_in_ep and isoc_out_ep are always the same for different alternate
> settings?

Check the HCI USB specification. I think it talks very clear how
endpoint IDs must be numbered.

> 4. I think we *can* assume that alternate setting 1 matches for 0x0?40
> voice modes, while alternate setting 2 matches for 0x0?60 voice modes,
> as you (Marcel) wrote that it's defined in the BT-USB-HCI specs.

That is not the whole truth. It also depends on the number of SCO
connections.

> 5. Why do I need the SCO link count? Shouldn't it be sufficient to call
> 
> usb_set_interface(hcidev->udev, hcidev->isoc_iface,NEW_ALTERNATE_SETTING);
> 
> after making sure that we solved the URB release problem?

Look at the specification. The number of SCO connection and the current
voice setting defines the alternate setting.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
