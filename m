Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <451426AA.7080700@verizon.net>
References: <451426AA.7080700@verizon.net>
Date: Mon, 25 Sep 2006 23:40:16 +0200
Message-Id: <1159220416.20997.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] race condition in hci_usb.c?
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

Hi Jose,

> I'm studying the hci_usb driver and I found a possible race condition.
> The routine hci_usb_tx_wakeup is called from hci_sub_send_frame
> and from hci_usb_tx_complete to get some work done by calling
> hci_usb_tx_process. It basically provides serial access to
> hci_usb_tx_process by using a couble of bit variables:
> HCI_USB_TX_PROCESS and HCI_USB_TX_WAKEPUP.
> 
> The problem is that if hci_usb_tx_wakeup is invoked again from a
> different context while execution is just terminating hci_usb_tx_process
> (right after the while loop), then hci_usb_tx_process will miss the
> wakeup. This condition will correct itself when another call is made
> to hci_usb_send_frame or another urb finishes transmission.
> 
> I experimented by replacing hci_usb_tx_wakeup with a tasklet
> that schedules hci_usb_tx_process. This to me seems like a safer
> approach.

feel free to provide a patch. In general the hci_usb driver needs a
complete rewrite anyway.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
