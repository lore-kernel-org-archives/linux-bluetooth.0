Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] driver support for sitecom cn-510 bluetooth usb
	Adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200511281541.06119.philipp.sandhaus@gmx.de>
References: <200511281541.06119.philipp.sandhaus@gmx.de>
Content-Type: text/plain
Message-Id: <1133210331.31513.62.camel@blade>
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
Date: Mon, 28 Nov 2005 21:38:51 +0100

Hi Philipp,

> I've trouble getting an usb bluetooth adapter getting to work. When I plug the 
> devvice into my computer it somehow get's recognized, because the modul 
> hci_usb automatically get's loaded. However, I see nothing about that in the 
> kernel log and "hcitool dev" doesn't list any devices. Any ideas, how I could 
> get this thing to work? I've, that the sitecom cn-500 adapter is supported, 
> but I didn't find anything about the cn-510 on the internet.

check with "hciconfig -a" and look at /proc/bus/usb/devices.

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
