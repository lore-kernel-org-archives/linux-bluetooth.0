Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth Power Modes
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDCA6@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDCA6@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1090876602.4650.1.camel@pegasus>
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
Date: Mon, 26 Jul 2004 23:16:42 +0200

Hi Richard,

> I'm working on an embedded system, with a USB Bluetooth dongle. This is a battery operated
> system, so power consumption is very important to me.
> 
> Does BlueZ support the Bluetooth low-power modes, such as Park and Sniff ?

all of them are supported, but you have to call the HCI commands for it
by yourself.

I still have the automatic-sniff-mode feature on my todo list, but don't
expect this very soon. I have other stuff that must be done first.

> If I have a Bluetooth dongle in my USB port, and I turn off the BlueZ stack by using
> "/etc/rc.d/init.d/bluetooth stop"  which then does an "hciconfig hci0 down" the Bluetooth dongle
> is not powered down. (The Blue LED inside the dongle is still blinking.) Is this a function of
> the Bluetooth stack or is this a USB responsibility ?

Maybe a reset of the device helps here, but I am not sure.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
