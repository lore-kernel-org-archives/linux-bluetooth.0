Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200609112146.15972.petr@palacky.net>
References: <200609112146.15972.petr@palacky.net>
Date: Mon, 11 Sep 2006 20:10:59 +0200
Message-Id: <1157998259.26541.47.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] 3 or more BT dongles over 1 USB-2.0 4-port HUB
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

Hi Petr,

> i have problem with three (and more) USB BT dongles (all are the same, 
> CSR-based) and 4-port USB-2.0 HUB.
> 
> When i attach one USB dongle alone, everything is good (hci0 is up and 
> running). When i attach the second dongle (after the first), still is 
> everything OK (hci0 and hci1 are up and running).
> But when i attach third (or fourth) dongle, this does not work.
> 
> I tried attaching all dongles differently but every time the third (or fourth) 
> dongle is not OK and dmesg says:
> #dmesg
> hci_usb_intr_rx_submit: hci2 intr rx submit failed urb cd55b674 err -28

try loading the hci_usb driver with the isoc=0 option. This maybe helps,
but it can also be a general problem with your USB root hub. In that
case you have to check with the USB guys, because this is not Bluetooth
specific.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
