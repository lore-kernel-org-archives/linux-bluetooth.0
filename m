Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40423226.8050007@superbug.demon.co.uk>
References: <40421024.20602@superbug.demon.co.uk>
	 <1078074126.1942.31.camel@pegasus>  <40423226.8050007@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078087109.1942.54.camel@pegasus>
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
Date: Sun, 29 Feb 2004 21:38:30 +0100

Hi James,

> This is something I need to be able to understand better.
> What should actually be adjusting the voice setting? To me it seems 
> sensible that we should try to get the voice setting to match the alsa 
> PCM samples if we can.
> Of course, another approach is getting the application to set the voice 
> setting, and then open the SCO link, and then force alsa to use whatever 
> voice setting the SCO link was set to. We would get the application to 
> inform alsa about this voice setting via an ioctl.

we only need to know about the input coding. The ALSA driver maybe needs
to convert the PCM samples to the input coding of the Bluetooth device.

> The alsa-driver receives a trigger() api call from an alsa based 
> application. It would be nice to pass this trigger() function on down 
> the stack to whichever bluetooth hci driver we are using (hci_usb or 
> whatever else), and that hci driver handle it appropriately.
> I just gave the usb_submit_urb() as an example of what the hci_usb.c 
> driver would do when it received the trigger() call.
> For example. The SCO link is open, but no actual sound samples start 
> being sent or received from the CPU until the trigger() call.

I don't see any need for it.

> I was using the HCI USB driver as an example only.
> The alsa-driver receives a pointer() from the alsa based application. we 
> need to pass a call to the HCI driver (hardware independently) which 
> would return the frame pointer. I don't think the concept of a 
> frame_pointer is USB specific. Any Bluetooth hardware driver will use a 
> frame_pointer.

I don't get this either, because we don't need to interface with any
hardware drivers.

> Maybe I should look at the patch first, but ..

You can find it in the mailing list archive.

> I cannot see anywhere in the current HCI layer api where I can find out 
> which HCI SCO packet is currently(in realtime) being output. All I know 
> is that if I send an HCI SCO packet down the stack, it will get queued, 
> and at some point be output. That is not good enough.

Why would you wanna know this? If you send too much data, the Bluetooth
chip itself will drop the packets.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
