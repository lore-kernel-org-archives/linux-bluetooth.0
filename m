Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] travelmate c110
From: Marcel Holtmann <marcel@holtmann.org>
To: pokui@ucu.ac.ug
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <32925.193.108.254.98.1098191310.squirrel@ucu.ac.ug>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
	 <1098107316.21553.8.camel@pegasus>
	 <34318.81.199.88.27.1098107653.squirrel@ucu.ac.ug>
	 <1098109156.21553.11.camel@pegasus>
	 <32925.193.108.254.98.1098191310.squirrel@ucu.ac.ug>
Content-Type: text/plain
Message-Id: <1098191809.31395.1.camel@pegasus>
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
Date: Tue, 19 Oct 2004 15:16:50 +0200

Hi,

> >> a tabletpc... does it still show up as USB device?
> >
> > I am not sure. Maybe it is attached through an UART. Is Windows giving
> > you any kind of extra information about the bus type of your Bluetooth
> > adapter?
> 
> Oddly enough, windows reports it as a USB CSR bluetooth device by widcomm.
> FWIW, this is running SuSE 9.1. I've attached text files that show the
> output of the commands:
> 
> 	-lsusb -vv > lsusb.txt
> 	-cat /proc/bus/usb/devices_please-use-sysfs-instead > proc_bus.txt

there is no CSR dongle in the devices file and so you must find the
switch to activate it. Maybe it is only a software switch. Is there an
ACER ACPI module available?

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
