Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Thibaut VARENE <varenet@gmail.com>
Message-ID: <loom.20050222T131039-923@post.gmane.org>
References: <7d01f9f00502210904ac37fae@mail.gmail.com> <1109025926.7626.2.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: urb timeout with bluetooth USB HCI on =?utf-8?b?QVJNCSgyLjYuMTEtcmMzKQ==?=
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
Date: Tue, 22 Feb 2005 12:31:45 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> > 3) Any clue about how to fix this?
> 
> The hci_usb driver contains some extra parameters that may can help you.
> Try "isoc=0" or "reset=1" and post the content of /proc/bus/usb/devices.

Hi,

Looking at the code, "isoc" is only available when CONFIG_BT_HCIUSB_SCO is
enabled, which wasn't my case. AFAICT it's used for disabling SCO protocol at
runtime in the code, but just to make absolutely sure I rebuilt the module with
SCO support enabled, tried various values for isoc=, none changed anything. 

tried with "reset=1", didn't change anything either

FWIW, it's almost impossible to debug with CONFIG_BT_HCIUSB_DEBUG force set on,
for the machine is so slowed down that the timeouts would actually be
meaningful. Maybe this is why this config option isn't available from the config
menu ;)

Thanks for your help

Thibaut VARENE

PS: Please CC me in answers, I'm not subscribed (used Gmane to avoid breaking the
thread).



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
