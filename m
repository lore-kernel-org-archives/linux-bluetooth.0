Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFFBED3F2B.F3FBB1C9-ONC12570BA.00595759-C12570BA.005ABF75@sagem.com>
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
Date: Tue, 15 Nov 2005 17:30:55 +0100

> Hi Mattieu,
Hi peter,

> you may use the PCMCIA card driver (btuart_cs) as a base and remove all
> the PCMCIA specific stuff. Than modify the UART access for your 
hardware.

> You may also use our PCI driver and removed all PCI specific stuff.
> this is based on the PCMCIA driver as well.
> The attached version is for 2.6.x. For 2.4.x you can find one on our
> website.
I look in your pci driver, and is more or less what I did except that I 
still use hci_h4 module.

What I don't like with these scheme is that all PCI/PCMCIA/USB driver 
duplicate some generic uart bluetooth code.

What I wanted is to have a generic uart driver that know nothing about hci 
and bluetooth, and then use hci_ldisc.c for the bluetooth part.

Is the fact to use the tty layer between uart driver and bluetooth uart 
module is too complex and have a high overhead ?


If tty is too complex, why not doing a generic uart bluetooth driver with 
simple inferface : send_packet/receive/init/close/... ?


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
