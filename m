Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HOWTO: Logitech MX900 Bluetooth Optical Mouse on
	Linux
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1071698686.6361.31.camel@bluez.bueche.ch>
References: <1071698686.6361.31.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071699651.21803.83.camel@pegasus>
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
Date: Wed, 17 Dec 2003 23:20:51 +0100

Hi Charles,

> With the help of Marcel, Olivier and a few other =FCbergeeks of the
> Bluez-devel mailing list, I have been able to get my Logitech MX900
> mouse working with my Dell Inspiron 8600 equiped with internal
> Bluetooth.
>=20
> I have made a small document to help other MX900 owners. It works for
> me, but be prepared to suffer a bit :
>=20
> - it's probably buggy
> - it run CVS code
> - it run on Gentoo with 2.6test kernel
> - my english is ashaming
>=20
> http://www.bueche.ch/comp/mx900/mx900.html
>=20
> Comments welcome. Regards,

very nice. I linked it.

I am also near at the stage where I know how to switch the Logitech
wirless hub from HID into HCI mode. They use a special HID report for
the mouse (report ID 16) to switch the mode. My Linux USB HID driver
presents me an extra hiddev node, but I haven't got success in using it
to send these special report. Do anyone here know how to send HID
reports through a hiddev device node?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
