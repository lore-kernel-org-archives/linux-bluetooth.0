Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030717172101.072ffe28@unixmail.qualcomm.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] hci_usb module interrupts?
In-Reply-To: <3F048FF4.4080609@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Jul 2003 17:25:21 -0700

At 01:20 PM 7/3/2003, James Courtier-Dutton wrote:
>I have the following bluez modules loaded: -
>hci_usb                 8088   1
>bluez                  32356   1  [hci_usb]
>
>hciconfig hci0 down
>No interrupts from the bluetooth device.
>hciconfig hci0 up
>About 100 interrupts per second from the bluetooth device.
>hciconfig hci0 down
>No more interrupts from the bluetooth device.
>
>There is no actual data coming from the bluetooth device, as I can check with hcidump. We get a few lines of output at the transition from up to down and down to up, but nothing in between.
>
>Is this activity normal?
>Does is happen with the PC card or PCI card usb adapters ?
>It seems to me that these interrupts should not be there.

Do you have SCO support compiled it ?
Also USB is a pulled bus. ie HC pulls device. When we bring device up we submit URB read requests.
I believe those can trigger interrupts even if there are no actual transfers.

Max



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
