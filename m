Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] uart driver
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0511151616400.4802-101000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0511151616400.4802-101000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1132658587.28644.22.camel@blade>
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
Date: Tue, 22 Nov 2005 12:23:07 +0100

Hi Peter,

> you may use the PCMCIA card driver (btuart_cs) as a base and remove all
> the PCMCIA specific stuff. Than modify the UART access for your hardware.
> 
> You may also use our PCI driver and removed all PCI specific stuff.
> this is based on the PCMCIA driver as well.
> The attached version is for 2.6.x. For 2.4.x you can find one on our
> website.

it will break on the latest 2.6 kernel, because the skb->pkt_type field
is no longer used.

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
