Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B087971@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B087971@mail.esn.co.in>
Content-Type: text/plain
Message-Id: <1128341030.22437.14.camel@blade>
Mime-Version: 1.0
Subject: [Bluez-users] RE: How can I establish the communication between BT enableddevice
 and FC 3 Linux box
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
Date: Mon, 03 Oct 2005 14:03:50 +0200

Hi Srinivas,

> > every distribution supports BlueZ, because it is the official
> Bluetooth
> > stack for Linux. The Affix project seems to be dead.
> 
> Then, is it necessary (or not necessary) to configure/install the BlueZ
> packages on my Linux box which uses the Fedora Core 3 with 2.6.9-1.667
> kernel version on IA32 machine?

you need only to install bluez-libs, bluez-utils and bluez-hcidump.

> I have gone through the following links (by you) and other links.
> http://www.holtmann.org/linux/bluetooth
> http://www.bluez.org/faq.html
> www.bluetooth.com
> www.bluetooth.org
> www.bluez.org
> http://affix.sourceforge.net
> http://www.tik.ee.ethz.ch/~beutel/pub/talks/20010402_bt_adequate_lan.pdf
> http://tuxmobil.org/bluetooth_cell_apps.html
> 
> If possible, please send me a link that explains about the BLUETOOTH
> architecture on Linux boxes.

You should first read something about how communication with Bluetooth
works in general, because otherwise I can't help you. Pick a profile
that you wanna use or describe how your communication should work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
