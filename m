Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_dev_open function
From: Marcel Holtmann <marcel@holtmann.org>
To: radoa <cat@pobox.sk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20041025T141305-8@post.gmane.org>
References: <loom.20041025T141305-8@post.gmane.org>
Content-Type: text/plain
Message-Id: <1098826382.14036.110.camel@pegasus>
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
Date: Tue, 26 Oct 2004 23:33:02 +0200

Hi Radoa,

> I want to ask how linux kernel initializes HCI sockets.
> When bluetooth dongle is inserted to USB, is registered by USB driver in bluez 
> stack as new device. But has not set flag HCI_UP, this flag is set only in call 
> of ioctl command HCIDEVUP - which calls hci_dev_open(). Function hci_dev_open() 
> resets BT dongle and receives its BT address. But where and when is ioctl with 
> HCIDEVUP cmd called? It seems that ioctl call is only place where is BT dongle 
> initialized.

there is no call like hci_dev_open() in the source code and the final
device initialization is done inside the kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
