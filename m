Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech DiNovo?
From: Marcel Holtmann <marcel@holtmann.org>
To: Dominik Behr <dominik@dominikbehr.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040209034835.15ac7289@localhost>
References: <20040209034835.15ac7289@localhost>
Content-Type: text/plain
Message-Id: <1076686208.2671.86.camel@pegasus>
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
Date: Fri, 13 Feb 2004 16:30:09 +0100

Hi Dominik,

> I have recently got me Logitech DiNovo. So far everything seems to work fine in USB boot protocol mode. Will ever Logitech bluetooth hub be supported in bluez? Or is it the classic "no documentation" problem?

I thought, that I already answered this question. The hid2hci programs
supports the Logitech Bluetooth HUB, but you need a special kernel patch
for the USB HID driver. Look at the mailing list archive.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
