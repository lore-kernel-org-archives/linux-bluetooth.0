Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Report of working dongle: IOGear GBU311 and
	question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4223E423.4030603@cloutier-vilhuber.net>
References: <20050228143635.6E7668844B@sc8-sf-spam1.sourceforge.net>
	 <4223E423.4030603@cloutier-vilhuber.net>
Content-Type: text/plain
Message-Id: <1109666679.17256.129.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 01 Mar 2005 09:44:39 +0100

Hi Lars,

> I can happily report that my new IOGear GBU311 works under stock SuSE 
> 9.2 (connections tested with Palm T3 and Sony-Ericsson T610, using 
> OBEX-FTP, OBEX-transfer, DUN).
> 
> However, I am curious: when plugging it in, the logs show a USB *HUB*, 
> and registers keyboard and mouse drivers. Is this something SuSE 
> specific, something driver-specific? Is SuSE misconfigured? or what does 
> it mean when the USB dongle registers as a keyboard/mouse?

the registration as mouse and keyboard is fine, but actually this device
should only start working with a recent 2.6.11-rc5 kernel. What does the
content of /proc/bus/usb/devices shows you? Also show us "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
