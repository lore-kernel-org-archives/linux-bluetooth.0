Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44761061.1000804@free.fr>
References: <44761061.1000804@free.fr>
Date: Mon, 29 May 2006 15:10:24 +0200
Message-Id: <1148908224.31689.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Question for Marcel (& maybe others)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

> There is an item in the TODO list concerning SCO audio:
> 
> "Full support for SCO connections with the HCI USB driver"
> 
> Could you please provide me some details on the missing bits ?

for the hci_usb driver and SCO support you need to switch the alternate
setting of the second interface depending on how many SCO channels are
opened and what voice setting is in use. This is not implemented. We
only support one channel and 16-bit encoding.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
