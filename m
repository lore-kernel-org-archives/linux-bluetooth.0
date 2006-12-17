Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <231dafb50612161256n34a1c123p13fd79870e12d265@mail.gmail.com>
References: <231dafb50612152211h1bc9ca42lade6687ac51c0@mail.gmail.com>
	<adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
	<1166262274.6557.1.camel@aeonflux.holtmann.net>
	<231dafb50612160114y6ee8b889ibbe71cd96dbd79b9@mail.gmail.com>
	<231dafb50612161256n34a1c123p13fd79870e12d265@mail.gmail.com>
Date: Sun, 17 Dec 2006 13:20:18 +0100
Message-Id: <1166358018.6557.17.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Trouble loading firmware with bcm203x
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> Could this be my problem.
> http://web.archive.org/web/20050310013858/www.holtmann.org/linux/bluetooth/usb.html
> 
> It says
> Device       usb-ohci                   usb-uhci  	uhci
> BCM 2033 no firmware load 	works 	         works but slow
> 
> 
> I have looked and all my usb ports on my laptop and dekstop are ohci.
> I have found a really old laptop that has a uhci port but none of my
> live disks work because it is decreped hardware so when I find one I
> will see if the firmware loads better.

no it is not your problem. You simply don't have a BCM2033 and that was
the only one needed the firmware download.

Yours looks like an HID proxy mode device it might need some extra love
to switch it from HID into HCI mode. However that is always a magic
sequence and for some devices the reset=1 is fully enough. Some others
need some crazy init command. I prefer you try a clean vanilla kernel
and check if the /proc/bus/usb/devices shows a Bluetooth device.
Otherwise you have to sniff what Windows is doing to init your device
and it would be good if someone sends me one of these to have it in my
device library.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
