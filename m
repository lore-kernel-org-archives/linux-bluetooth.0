Return-Path: <cyrus@holtmann.org>
Message-ID: <1347889078.25167.13.camel@aeonflux>
Subject: Re: [RFC 1/3] Bluetooth: Add initial skeleton for Intel BT USB
 support
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	albert.o.ho@intel.com
Date: Mon, 17 Sep 2012 15:37:58 +0200
In-Reply-To: <2487417.xmkj2FQ8Wf@tedd-ubuntu>
References: <2487417.xmkj2FQ8Wf@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds an initial skeleton for Intel BT USB support.
> 
> - Extension to execute of vendor specific initialization at early stage
>   which is before normal BT controller initialization and after the USB
>   is initialized.
> 
> - Add initial skeleton of Intel specific initialization functions
> 
> - Add Intel BT USB VID/PID
> 
> Outpu from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=07dc Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/Makefile       |    2 +-
>  drivers/bluetooth/btusb.c        |   29 ++++++++++++++
>  drivers/bluetooth/btusb.h        |   31 +++++++++++++++
>  drivers/bluetooth/btusb_intel.c  |   81 ++++++++++++++++++++++++++++++++++++++
>  include/net/bluetooth/hci_core.h |    6 +++
>  net/bluetooth/hci_core.c         |   16 ++++++++
>  6 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bluetooth/btusb.h
>  create mode 100644 drivers/bluetooth/btusb_intel.c

I am strictly against mixing this all into one patch. Core changes need
to be separate, btusb general changes need to be separate and then Intel
btusb specific code as well.

> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 4afae20..57c7fe2 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
>  obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
>  obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
>  
> -obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
> +obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o btusb_intel.o
>  obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o

It sounds like a bad idea hiding the btusb_intel.ko kernel module behing
the generic option for btusb.ko module.
 
>  obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..029c5b7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -27,6 +27,8 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  
> +#include "btusb.h"
> +
>  #define VERSION "0.6"
>  
>  static bool ignore_dga;
> @@ -47,6 +49,8 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_INTEL			0x100
> +#define BTUSB_DEV_INIT		0x8000
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -190,6 +194,9 @@ static struct usb_device_id blacklist_table[] = {
>  	/* Frontline ComProbe Bluetooth Sniffer */
>  	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
>  
> +	/* Intel Bluetooth device */
> +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_DEV_INIT | BTUSB_INTEL },
> +
>  	{ }	/* Terminating entry */
>  };
>  
> @@ -235,6 +242,17 @@ struct btusb_data {
>  	int suspend_count;
>  };
>  
> +struct btusb_vendor_dev {
> +	unsigned long info;
> +	int (*vsdev_init)(struct hci_dev *hdev);
> +	void (*vsdev_event)(struct hci_dev *hdev, struct sk_buff *skb);
> +};
> +
> +static struct btusb_vendor_dev vendor_dev[] = {
> +	{ BTUSB_INTEL, btusb_intel_init, btusb_intel_event },
> +	{ 0 }
> +};
> +

This does not scale. We can not do it like this. Especially since I also
already have seen some Broadcom dongles requiring special init handling.
And there is still the Atheros stuff that keep popping up.

It seems like that we might better follow a similar approach here that
usbnet and its drivers does.

We can have a library like btusb that provides btusb_probe and
btusb_disconnect. And then have a btusb_driver_info specific structure
that allows overwriting certain setup/fixup functions that we then
trigger from btusb or from the Bluetooth core.

This would also mean that btusb_intel.ko can become its own module with
its own usb_driver table. Which would avoid cluttering btusb.c with
vendor specific details all over the place.

Assuming that the USB driver matching uses VID/PID matches over
interface matches and does not go via module loading order.

If not, then USB_DEVICE_INFO(0xe0, 0x01, 0x01) might get us in trouble.
And then we need come up with our own btusb_driver. Same idea, just a
little bit more work.

Regards

Marcel


