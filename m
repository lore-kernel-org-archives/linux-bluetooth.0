Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with pppd through bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: igorluiz@magiclink.com.br
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077831499.7219.34.camel@emerald>
References: <1077831499.7219.34.camel@emerald>
Content-Type: text/plain
Message-Id: <1077843554.2843.19.camel@pegasus>
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
Date: Fri, 27 Feb 2004 01:59:14 +0100

Hi Igor,

> I'm experimenting a problem trying to connect internet via GRPS through
> bluetooth using my Nokia 3650 and a Linux Box with a usb-dongle
> bluetooth BT3030, via pppd.
> 
> The connection between the mobile and the PC via bluetooth is working
> fine. I can transfer data in the two ways: PC->mobile , mobile->PC,
> using the bluez driver.
> So, now when I try to access the internet via GPRS a got this message
> when I call "pppd"
> 
> root@emerald:~# rfcomm 1 xx:xx:xx:xx:xx:xx 9
> Connected /dev/ttyU1 to xx:xx:xx:xx:xx:xx on channel 9
> rfcomm_send_data: DLCI 18 not connected
> rfcomm_send_data: DLCI 18 not connected
> rfcomm_send_data: DLCI 18 not connected
> rfcomm_send_data: DLCI 18 not connected

use the kernel RFCOMM layer.

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
