Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dfutool - IBM X23 refuses to update ;)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43591455.7070005@kernelconcepts.de>
References: <43591455.7070005@kernelconcepts.de>
Content-Type: text/plain
Message-Id: <1129912213.11428.8.camel@blade>
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
Date: Fri, 21 Oct 2005 18:30:13 +0200

Hi Nils,

> Some time ago I purchased an IBM X23 notebook (nice thing BTW) with
> Bluetooth. The Bluetooth chip is, of course, a CSR one, labeled as ITSE.
> IBM offers a Bluetooth firmware upgrade for it to help support of
> multiple connections.
> So I would like to upgrade my firmware using the dfutool. IBM's uprade
> file can easily be unpacked and what you get is the, I guess, proper DFU
> file for the upgrade.

you can use "verify" to see if the DFU file is at least valid.

> Using the dfutool I can nicely backup my firmware to a file - works like
> charm!
> But when I try to flash the new firmware the dfutool waits a couple of
> seconds at "switching device to dfu mode", then sais "Dowloading
> firmware" without progress indication and then sais "Can't get status:
> Broken pipe (32)".

The dfutool is not perfect. I only tested it with a small bunch of
devices and most of them were BlueCore02 or later.

> If it is of help I can provide the original and update firmware files.
> Here is additonally what hciconfig tells me about my chip:
> 
> root@miu:~ # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:80:98:24:80:BE ACL MTU: 128:8  SCO MTU: 64:8
>         HCI 11.3
>         Chip version: BlueCore01b
>         SCO mapping:  HCI

This is a very old firmware and maybe the boot loader on the chip is
even older. Maybe it is broken and need some special tweaks to make it
working. Sometimes increasing the timeouts inside the code might help,
but you can also render your device useless.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
