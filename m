Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
From: Marcel Holtmann <marcel@holtmann.org>
To: Sigrid Kronenberger <skronenberger@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040811231204.18574a27@localhost>
References: <20040811231204.18574a27@localhost>
Content-Type: text/plain
Message-Id: <1092262417.4564.259.camel@pegasus>
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
Date: Thu, 12 Aug 2004 00:13:37 +0200

Hi Sigrid,

> I'm using Mandrake 10.0 Official with the updated Kernel 2.6.3-15mdk. I
> have an USB Bluetooth dongle from AVM (BlueFritz) which don't work... :(
> 
> I've copied the firmware to the /usr/lib/hotplug/firmware directory.
> hotplugd starts at boot time. I've changed to an older version of the
> AVM-firmware, because Marcel told me, that this Kernel won't work with
> the newest firmware. 
> 
> I've downloaded and installed the newest version of bluez-libs,
> bluez-utils, bluezs-pin, bluez-firmware, bluez-hcidump and bluez-hciemu.
> (I've compiled myself, no rpm-packages) Source for the software: 
> http://www.bluez.org/download.html. 
> 
> When I'm typing "hciconfig" in a console, nothing happens... 

are the hotplug scripts installed (look for /etc/hotplug/firmware.agent)
and show us the content of /proc/bus/usb/devices after you plugged in
the dongle.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
