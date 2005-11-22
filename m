Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFC584E534.1FAAD75C-ONC12570C1.00476D61-C12570C1.00480347@sagem.com>
From: Matthieu CASTET <matthieu.castet@sagem.com>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_[Bluez-devel]_uart_driver?=
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
Date: Tue, 22 Nov 2005 14:06:00 +0100

Hi,

> send in more details what this driver is about.
My hardware is a simple uart, but which is managed by an extra processor.
So the driver for the uart take buffers of characters and don't 
send/receive character by character the data.

My question was if there is an easy way to use hci_ldisc.c driver.
I understood that I need to do a real uart driver in order to use 
hci_ldisc.c. My question was how to make a real uart driver.

Also can't hci_ldisc.c be split to use tty or other external read/write 
function ?

Regards,

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
