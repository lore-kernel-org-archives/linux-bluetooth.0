Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
References: <231dafb50612152211h1bc9ca42lade6687ac51c0@mail.gmail.com>
	<adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
Date: Sat, 16 Dec 2006 10:44:34 +0100
Message-Id: <1166262274.6557.1.camel@aeonflux.holtmann.net>
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

> > I just bought a Bluetooth dongle that uses the Broadcom 4503 chipset
> > and I am having trouble getting stable use out of it. I have got it to
> > work twice before with the following steps
> >
> > plug it in
> > modprobe bcm203x
> > hciconfig up
> > hciconfig reset (hours of googling to find out this is required)
> 
> For my Broadcom BCM2045B2 chipset dongle loading the hci_usb module
> with "reset=1" worked wonderfully.

if you post the content of /proc/bus/usb/devices, I can make the reset
option permanent for this dongle and you don't have to worry about it
anymore.

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
