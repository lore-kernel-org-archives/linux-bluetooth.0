Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: ubaldo <ubaldo@eja.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040716140215.564.qmail@webmail2.aruba.it>
References: <20040618175410.28510.qmail@webmail.aruba.it>
	 <1087582530.4309.121.camel@pegasus>
	 <20040618183339.20830.qmail@webmail.aruba.it>
	 <1087583875.25061.2.camel@pegasus>
	 <20040618184232.25439.qmail@webmail.aruba.it>
	 <1087584576.25061.6.camel@pegasus>
	 <20040716140215.564.qmail@webmail2.aruba.it>
Content-Type: text/plain
Message-Id: <1089991775.5119.18.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: multi rfcomm/sco connection
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
Date: Fri, 16 Jul 2004 17:29:35 +0200

Hi,

> > actually I don't see why you need more than one SCO link in a connection
> > between two devices. However take a look at the kernel source code of
> > Linux 2.6.x and especially at net/bluetooth/hci_conn.c
> 
> I explain you a bit more my situation... 
> 
> I need to be able with a single usb-bt-dongle to play/capture audio for 
> several bt-handsfree, I tried with one and there are no problems, but if I 
> try to connect another one then I get something like "sco channel busy". 
> 
> I studied the net/bluetooth directory but I cannot find any good way to 
> achieve what I need! :) 
> 
> Am I wrong in something or is this feature really missing?

as I said, between two devices BlueZ supports only one ACL link and one
SCO link. These links a bi-directional so you can play and capture audio
data at the same time. The limit to one SCO link is only a per ACL link
limitation. If you open a second ACL to another device you can also have
a second SCO link bound to that connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
