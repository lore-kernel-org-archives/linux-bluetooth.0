Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1139331334.12556.3.camel@pc-05.ycom.ch>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>  <1138880751.21953.38.camel@bluez.bueche.ch>
	 <1139331334.12556.3.camel@pc-05.ycom.ch>
Content-Type: text/plain
Message-Id: <1139351059.22790.63.camel@localhost>
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
Date: Tue, 07 Feb 2006 23:24:19 +0100

Hi Alexandre,

> > Did you contact the hotplug team about this issue ?
> 
> I got the folowing answer from hotplug ML : 
> 
> Kay Sievers <kay.sievers@vrfy.org>
> 
> The kernel driver needs to set the "struct device", to get a "device"
> link
> in sysfs pointing to the physical device, otherwise the USB devices are
> not
> reachable and udev can't match.

and we don't have a "struct device", because the current integration of
the Bluetooth subsystem is a class device under /sys/class. It seems we
need to wait until the /sys/device unification found its way into the
kernel.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
