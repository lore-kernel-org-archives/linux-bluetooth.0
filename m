Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC IVT USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43982BAC.2030508@rambler.ru>
References: <43982224.6020208@rambler.ru> <1134044091.3752.87.camel@blade>
	 <43982BAC.2030508@rambler.ru>
Content-Type: text/plain
Message-Id: <1134047622.3752.89.camel@blade>
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
Date: Thu, 08 Dec 2005 14:13:42 +0100

Hi Pavel,

> > looks like the funny dongle with BD_ADDR 22:22:22:22:22:22 I posted some
> > minutes ago. Does lsusb shows something like this:
> > 
> > ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
> 
>   Have no lsusb command installed and too lazy to search for it in the RPMs (Fedora Core 4).

come on, it is in usbutils.

> 
> > The extra line is for firmware upgrades and normally never attached to
> > any driver. Your device has been successfully recognized.
> 
>   Well, why does nothing work then?

Check what "hciconfig -a" says and if hcid is running.

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
