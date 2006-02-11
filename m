Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluez and dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43ECFB21.3030101@gmail.com>
References: <43ECFB21.3030101@gmail.com>
Content-Type: text/plain
Message-Id: <1139629676.2098.3.camel@localhost>
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
Date: Sat, 11 Feb 2006 04:47:56 +0100

Hi Doug,

> >it should be started from /etc/init.d/bluetooth depending on your Linux
> >distribution. You get a connection once you press a key on your
> >keyboard.
> 
> I happen to have the m$ dongle that came with the keyboard.
> It does have a CCR chip, so is it flashable for HID proxy support?

in general yes, but this particular one is not flashable. You will
render it useless. Trust I already did this.

> also the DBT-122 that I have, sais the HCI version is 1.2, which would 
> make it a (RevB3)
> but all the other info I see on it seem's to say otherwise?
> http://www.holtmann.org/linux/bluetooth/features.html
> 
> if it really is (RevB3), isn't this chip also able to be upgraded to HID 
> proxy support?

If you grap the GenericCSR.dfu firmware from Apple, then you can upgrade
this one with an HID proxy capable firmware.

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
