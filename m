Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Oops in hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040505190725.GB1339@kos.to>
References: <20040501173626.GA3866@kos.to> <1083587205.4666.0.camel@pegasus>
	 <20040503193747.GA21331@kos.to> <1083686495.4666.39.camel@pegasus>
	 <20040505190725.GB1339@kos.to>
Content-Type: text/plain
Message-Id: <1083785352.4420.33.camel@pegasus>
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
Date: Wed, 05 May 2004 21:29:12 +0200

Hi Riku,

> Here's an oops with SCO options enabled and without preempt. I wonder if
> symbols are resolved from some wrong place, thou. Anyway, these oops
> don't look like they are preempt-related.

this is a wild guess, but maybe the linking of the USB device into the
/sys structure causes this problem. So please comment out this line

	SET_HCIDEV_DEV(hdev, &intf->dev);

in the hci_usb driver and try again.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
