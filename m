Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] travelmate c110
From: Marcel Holtmann <marcel@holtmann.org>
To: pokui@ucu.ac.ug
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
Content-Type: text/plain
Message-Id: <1098107316.21553.8.camel@pegasus>
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
Date: Mon, 18 Oct 2004 15:48:37 +0200

Hi,

> The chipset on my acer travelmate c110 doesn't seem to be supported
> because typing "hcitool dev" gives me:
> Devices:
> #
> 
> 1. Is there anyway I can tell what chipset this laptop is using (and
> cross-check against the h/w list).
> 
> 2. Given that the chipset may not be supported (if I can find out what the
> answer to 1 is), what would I need to add support for this chipset (in
> terms of what major parts of the code do I need to modify etc)

use "hciconfig -a" to look for your local adapter, but first check any
hardware switch on your machine. Maybe you have to activate it first.
You can also use "lsusb" and check "/proc/bus/usb/devices".

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
