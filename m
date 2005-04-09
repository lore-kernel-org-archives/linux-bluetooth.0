Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco transfer not possible if hci_usb uses
	ehci_hcd?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200504082054.21259.rjenster@web.de>
References: <200504082054.21259.rjenster@web.de>
Content-Type: text/plain
Message-Id: <1113049174.9783.52.camel@pegasus>
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
Date: Sat, 09 Apr 2005 14:19:34 +0200

Hi Ruben,

> I've the problem that when ehci_hcd is loaded  and I plug my bluetooth dongle 
> to my usb hub,  hci_hcd uses the ehci host and playing or recording sound 
> through snd-bt-sco is not possible then. (USB_EHCI_SPLIT_ISO is enabled)
> I have to unload ehci_hcd and replug the dongle in order to make audio 
> transfer possible.
> Can I tell hci_usb to use ohci_hcd even when ehci_hcd is loaded? 
> 
> Curiously when I plug the dongle to the usb jacks that are direcly attached to 
> the mainboard hci_usb uses the ohci host, even when ehci_hcd is loaded.
> 
> I've added a bug report to thet kernel bugtracker
> http://bugme.osdl.org/show_bug.cgi?id=4358
> 
> I would be glad if someone could help me.

with David's and Greg's attention you got the right guys for this job,
because I am not into USB HCD stuff.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
