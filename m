Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT3C ceased working in kernel 2.6.6
From: Marcel Holtmann <marcel@holtmann.org>
To: Antti =?ISO-8859-1?Q?M=E4kel=E4?= <zarhan@cs.tut.fi>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
References: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
Content-Type: multipart/mixed; boundary="=-PCylrp6fuezFU2gKwvcY"
Message-Id: <1084368942.25099.41.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 15:35:42 +0200


--=-PCylrp6fuezFU2gKwvcY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Antti,

>   I upgraded from kernel 2.6.6-rc2 to 2.6.6 and it seems that BT3C is now
> broken. The driver is compiled as a module.
> 
>   The firmware is placed in /usr/lib/hotplug/firmware as it should be, and
> it was working in 2.6.6-rc2. The driver is compiled as a module, rest of
> the system are in kernel.

I know and there is no real fix for it, because the PCMCIA subsystem is
not fully integrated into the driver model. However the attached patch
should prevent the oops and make the driver work again.

Regards

Marcel


--=-PCylrp6fuezFU2gKwvcY
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/bt3c_cs.c 1.20 vs edited =====
--- 1.20/drivers/bluetooth/bt3c_cs.c	Sat Apr 17 00:23:48 2004
+++ edited/drivers/bluetooth/bt3c_cs.c	Wed May 12 15:33:13 2004
@@ -491,6 +491,9 @@
 
 static struct device bt3c_device = {
 	.bus_id = "pcmcia",
+	.kobj = {
+		.k_name = "bt3c_cs"
+	}
 };
 
 

--=-PCylrp6fuezFU2gKwvcY--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
