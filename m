Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB/Bluetooth dongle doesn't work in hub
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qszr7n3lgkp.fsf@timepilot.gpcc.itd.umich.edu>
References: <qszekj3j47n.fsf@timepilot.gpcc.itd.umich.edu>
	 <1099959115.29330.40.camel@pegasus>
	 <qszzn1rhnmh.fsf@timepilot.gpcc.itd.umich.edu>
	 <qszr7n3lgkp.fsf@timepilot.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1099985025.29330.52.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 08:23:45 +0100

Hi Scott,

> >> This looks like an USB problem to me. Update your kernel to the latest
> >> Bitkeeper snapshot and try again.
> 
> I downloaded a new kernel with:
> 
>     bk clone http://linux-mh.bkbits.net/bluetooth-2.6
> 
> , compiled and booted, and I still am getting roughly the same error:
> 
>     Nov  9 00:36:06 localhost usb.agent[4258]: Setup hci_usb for USB product 50d/81/828
>     Nov  9 00:36:06 localhost hcid[3688]: HCI dev 1 registered
>     Nov  9 00:36:06 localhost kernel: hci_usb_intr_rx_submit: hci1 intr rx submit failed urb d0d01e94 err -28
>     Nov  9 00:36:06 localhost hcid[4281]: Can't init device hci1. Input/output error(5)
>     Nov  9 00:36:06 localhost usb.agent[4195]: Setup 0x00 0x00 for USB product 50d/81/828
>     Nov  9 00:36:07 localhost usb.agent[4231]: Setup 0x00 0x00 for USB product 50d/81/828
>     Nov  9 00:36:07 localhost usb.agent[4258]: Setup 0x00 0x00 for USB product 50d/81/828
> 
> As before, they work fine when plugged directly into the laptop.

go ahead and report this problem to the USB mailing list, because it is
not a Bluetooth problem and I don't know why this fails.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
