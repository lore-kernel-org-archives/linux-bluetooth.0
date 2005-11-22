Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] =?ISO-8859-1?Q?R=E9f=2E?= : Re: [Bluez-devel]
	uart driver
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OFC584E534.1FAAD75C-ONC12570C1.00476D61-C12570C1.00480347@sagem.com>
References: 
	 <OFC584E534.1FAAD75C-ONC12570C1.00476D61-C12570C1.00480347@sagem.com>
Content-Type: text/plain
Message-Id: <1132665275.28644.63.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 22 Nov 2005 14:14:35 +0100

Hi Matthieu,

> > send in more details what this driver is about.
> My hardware is a simple uart, but which is managed by an extra processor.
> So the driver for the uart take buffers of characters and don't 
> send/receive character by character the data.
> 
> My question was if there is an easy way to use hci_ldisc.c driver.
> I understood that I need to do a real uart driver in order to use 
> hci_ldisc.c. My question was how to make a real uart driver.
> 
> Also can't hci_ldisc.c be split to use tty or other external read/write 
> function ?

about what transport protocol are we talking. Is this still H:4 or what
do you use?

I personally think it is easier to write a HCI driver that handles your
special UART directly. Since I have no idea how your UART really looks
like, I can't give a perfect advice.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
