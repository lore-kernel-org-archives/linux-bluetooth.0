Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with PCMCIA Bluetooth card (cbt100c)
From: Marcel Holtmann <marcel@holtmann.org>
To: Eiko Oltmanns <eiko.oltmanns@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402141823.34699.eiko.oltmanns@web.de>
References: <200402141823.34699.eiko.oltmanns@web.de>
Content-Type: text/plain
Message-Id: <1076855735.14758.57.camel@pegasus>
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
Date: Sun, 15 Feb 2004 15:35:35 +0100

Hi Eiko,

> I have problems with using the conceptronic pcmcia card (cbt100c). The hotplug 
> system (on a Suse 9.0 system) doesn't detect the card correctly. It detects a 
> modem a loads 'serial_cs.o'. Obviously this can't work. 

this is correct if the card offers an UART. You have to use hciattach to
attach the serial device to the Bluetooth core.

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
