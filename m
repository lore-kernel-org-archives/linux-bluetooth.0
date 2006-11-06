Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Xu=E2n?= Baldauf <xuan--2006.11.06--bluez-devel--lists.sourceforge.net@baldauf.org>
In-Reply-To: <454F7267.9010409@baldauf.org>
References: <454F7267.9010409@baldauf.org>
Date: Mon, 06 Nov 2006 18:42:46 +0100
Message-Id: <1162834966.31808.58.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [patch] Broadcom BCM2045 SCO workaround
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

Hi Xuan,

> The Broadcom BCM2045 chipset seems to be also one of those chipsets
> which report the SCO maximum packet incorrectly. The attached patch
> works around this problem. With this workaround, a bluetooth USB
> dongle with this chipset is able to send SCO data correctly.
> 
> The fix was verified using this USB dongle (MSI StarKey 2.0 (Ver
> 222-BW))
>         Bus 002 Device 004: ID 0a5c:2101 Broadcom Corp.
>         Device Descriptor:
>           bLength                18
>           bDescriptorType         1
>           bcdUSB               2.00
>           bDeviceClass          224 Wireless
>           bDeviceSubClass         1 Radio Frequency
>           bDeviceProtocol         1 Bluetooth
>           bMaxPacketSize0        64
>           idVendor           0x0a5c Broadcom Corp.
>           idProduct          0x2101
>           bcdDevice            0.00
>           iManufacturer           1 Broadcom Corp
>           iProduct                2 BCM92045DG Non-UHE
>           iSerial                 0
>           bNumConfigurations      1

is this a dongle with HID proxy support or not. If yes, then you need
the HCI_RESET quirk otherwise you don't. So please check if it still
works after not including the HCI_RESET quirk.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
