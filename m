Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ on Sony Vaio notebook pcg-z1m
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051128215104.2d3e749a.c3t0@yahoo.de>
References: <20051128215104.2d3e749a.c3t0@yahoo.de>
Content-Type: text/plain
Message-Id: <1133211371.31513.72.camel@blade>
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
Date: Mon, 28 Nov 2005 21:56:11 +0100

Hi Thomas,

> I'm new to this mailinglist and to be honest I'm also new to mailinglists at all.
> 
> I recently bought a second-hand notebook (Sony Vaio PCG-Z1M) and I'm trying to get everything
> to work atm. Almost everything works quite fine except the bluetooth-device, which is
> built-in.
> 
> I don't have problems turning the bluetooth-device on and off using sonypi and spicctrl
> as the blue led on the laptop, which indicates the bluetooth-device-status, reacts on my
> spicctrl commands. Unfortunatly the BlueZ-utils doesn't detect any bluetooth-device even 
> though I activated it via "spicctrl -l1" and loaded the hci-usb-modul (bluetooth itself 
> is compiled in the kernel).

after activating the Bluetooth device, look at /proc/bus/usb/devices and
check dmesg.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
