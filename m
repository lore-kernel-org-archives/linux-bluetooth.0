Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Jan J. Jessen" <jjjessen@control.auc.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.40.0309161558370.18622-100000@prosit.control.auc.dk>
References: <Pine.GSO.4.40.0309161558370.18622-100000@prosit.control.auc.dk>
Content-Type: text/plain
Message-Id: <1063756641.29941.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 17 Sep 2003 01:57:15 +0200

Hi Jan,

> I've now tried the patch and compiled a new kernel with hci_usb as a
> module.
> When I load it into the kernel I get the following:
> 
> # insmod /lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o
> /lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
> hci_register_dev_Rsmp_17de4405
> /lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
> hci_unregister_dev_Rsmp_380d73d1
> /lib/modules/2.4.22/kernel/drivers/bluetooth/hci_usb.o: unresolved symbol
> hci_recv_frame_Rsmp_75250b00
> 
> I've used a "fresh" 2.4.22 kernel

try it again, because this is a problem with MODVERSION. Maybe the
running kernel or bluez.o module is compiled without and the hci_usb.o
driver with it.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
