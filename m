Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFA5A05067.92F54E5C-ONC12570BA.003D30BC-C12570BA.0053751C@sagem.com>
From: Matthieu CASTET <matthieu.castet@sagem.com>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] uart driver
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 15 Nov 2005 16:11:17 +0100

Hi,

I have a uart driver that use non-standard read/write and can't be used by 
the hci_ldisc.c driver.
A hack was done in the hci_ldisc.c driver to use these non-standard 
read/write functions and remove all the tty stuff.

I want to clean it and write a standard uart driver for 2.6.

But I don't know how to write it and what callbacks are needed.

I look some example in driver/serial, but I don't how to implement all the 
uart_ops callback and which are needed/optional.

Have you got some pointers for how to write uart driver or an example uart 
driver that is not too complex?


Thanks,

Matthieu



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
