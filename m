Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: urb timeout with bluetooth USB HCI on
	ARM	(2.6.11-rc3)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <loom.20050222T131039-923@post.gmane.org>
References: <7d01f9f00502210904ac37fae@mail.gmail.com>
	 <1109025926.7626.2.camel@pegasus> <loom.20050222T131039-923@post.gmane.org>
Content-Type: text/plain
Message-Id: <1109241609.5645.4.camel@notepaq>
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
Date: Thu, 24 Feb 2005 11:40:09 +0100

Hi Thibaut,

> Looking at the code, "isoc" is only available when CONFIG_BT_HCIUSB_SCO is
> enabled, which wasn't my case. AFAICT it's used for disabling SCO protocol at
> runtime in the code, but just to make absolutely sure I rebuilt the module with
> SCO support enabled, tried various values for isoc=, none changed anything. 
> 
> tried with "reset=1", didn't change anything either
> 
> FWIW, it's almost impossible to debug with CONFIG_BT_HCIUSB_DEBUG force set on,
> for the machine is so slowed down that the timeouts would actually be
> meaningful. Maybe this is why this config option isn't available from the config
> menu ;)

if both not helps, then I think that it a ARM and USB related problem.
Since I don't have any of these platform, I can't help you here.

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
