Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
From: Marcel Holtmann <marcel@holtmann.org>
To: Holger Frydrych <h.frydrych@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40EFE1DA.4070709@gmx.de>
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>
	 <40EF0F10.8050302@gmx.de> <1089413516.13519.16.camel@pegasus>
	 <40EFABCE.7000503@gmx.de> <1089449283.13519.35.camel@pegasus>
	 <40EFB4C7.3040509@gmx.de> <1089451515.13519.49.camel@pegasus>
	 <40EFE1DA.4070709@gmx.de>
Content-Type: text/plain
Message-Id: <1089480872.13519.64.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 10 Jul 2004 19:34:32 +0200

Hi Holger,

> 1. What's the status on hid2hci now? Is it still needed or should it be 
> obsolete by now? Because I've read in this mailing list that others do 
> not need it anymore, but I can't get it to work without, as described.

no. You will always need hid2hci to switch from HID mode into HCI mode,
because after reboot the HID mode is default.

> 2. The usual procedure (as I understand, I'm not much into that 
> bluetooth stuff, as may be obvious ;) ) to connect a new bluetooth 
> device would be to press its connect button and then the one on the hub, 
> right? Well, this does not work, simply because the hub (after hid2hci) 
> does no longer react to a press on 'Connect', so I have to manually 
> search for new devices via hidd. The diNovo devices seem to 
> automatically reconnect when I use them, though, so if that's the way 
> it's meant to be currently, then this is ok, I only rarely connect an 
> additional device (a cell phone). Just wanted to know.

For your HID devices you only have to connect them once using "hidd -c".
After that they will reconnect if you use them. To make this work
without any trouble you must run "hidd --server" at boot time and before
you switch into HCI mode with hid2hci.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
