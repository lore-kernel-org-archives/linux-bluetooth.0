Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060707094252.GA26792@suse.de>
References: <20060707094252.GA26792@suse.de>
Date: Tue, 11 Jul 2006 13:24:58 +0200
Message-Id: <1152617098.15028.16.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1 SCO packet
	for	unknown connection handle 0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> i have an el-cheapo USB BT dongle in front of me that throws an endless
> stream of
> kernel: hci_scodata_packet: hci1 SCO packet for unknown connection handle 0
> after inserting it into the USB port, unless i do
> echo 1 > /sys/module/hci_usb/parameters/isoc
> 
> I don't know about the usual practice in such cases: do those devices get
> blacklisted in the drivers? If yes, what information should i provide to
> get it into the blacklist?

what does "hciconfig -a" tells you about this dongle? The content
from /proc/bus/usb/devices for this device might also be helpful.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
