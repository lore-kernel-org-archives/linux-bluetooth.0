Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fourq4$ivu$1@ger.gmane.org>
References: <fourq4$ivu$1@ger.gmane.org>
Date: Wed, 13 Feb 2008 14:40:38 +0100
Message-Id: <1202910039.7664.407.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] hidraw support for Bluetooth HID devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pascal,

> This patch exposes Bluetooth HID peripherals to userspace
> through the hidraw API, in addition to the input subsystem.
> This improves consistency between hidp and usbhid.

it misses a Signed-off-by line.

> --- linux-2.6.24.2/net/bluetooth/hidp/core.c.orig       2008-02-13 13:28:26.000000000 +0100
> +++ linux-2.6.24.2/net/bluetooth/hidp/core.c    2008-02-13 14:19:29.000000000 +0100
> @@ -40,6 +40,7 @@
> 
>   #include <linux/input.h>
>   #include <linux/hid.h>
> +#include <linux/hidraw.h>

This looks like your editor can't handle inline very well.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
