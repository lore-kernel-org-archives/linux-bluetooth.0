Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Acer BT900 Headset profile
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42695D2D.8000109@xmission.com>
References: <13e9886105042209171edb0fba@mail.gmail.com>
	 <1114197531.32265.77.camel@pegasus>  <42695D2D.8000109@xmission.com>
Content-Type: text/plain
Message-Id: <1114205788.10706.6.camel@pegasus>
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
Date: Fri, 22 Apr 2005 23:36:28 +0200

Hi Brad,

> > I marked the ISOC support for this dongle as broken and so you don't get
> > any SCO data on the USB bus. So no headset connection possible.
> 
> Is there a way to see, like in a device query that isoc is not supported 
> on the adapter?

this is again a stupid Broadcom dongle. The descriptors tell that they
support the ISOC endpoints, but it is broken or our they only don't like
our way of dealing with ISOC transfers. Feel free to fix the hci_usb
driver to deal correctly with these dongles.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
