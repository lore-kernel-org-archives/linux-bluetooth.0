Return-Path: <cyrus@holtmann.org>
Message-ID: <1351380893.25783.15.camel@aeonflux>
Subject: Re: [RFC v2 1/2] Bluetooth: Add driver extension for vendor device
 setup
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, albert.o.ho@intel.com,
	johan.hedberg@intel.com, tedd.hj.an@gmail.com
Date: Sat, 27 Oct 2012 16:34:53 -0700
In-Reply-To: <2721081.2F6GJ3v4qE@tedd-ubuntu>
References: <2721081.2F6GJ3v4qE@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch provides an extension of btusb to support device vendor
> can implement their own module like mini driver to execute device
> specific setup before the BT stack sends generic BT device
> initialization.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btusb.c        |  194 +++++++++++++++++++++++++-------------
>  drivers/bluetooth/btusb.h        |   53 +++++++++++
>  include/net/bluetooth/hci.h      |    2 +
>  include/net/bluetooth/hci_core.h |    8 ++
>  net/bluetooth/hci_core.c         |   28 +++++-
>  5 files changed, 220 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/bluetooth/btusb.h
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..d3f8e7d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -26,6 +26,7 @@
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include "btusb.h"
>  
>  #define VERSION "0.6"
>  
> @@ -39,14 +40,52 @@ static bool reset = 1;
>  
>  static struct usb_driver btusb_driver;
>  
> -#define BTUSB_IGNORE		0x01
> -#define BTUSB_DIGIANSWER	0x02
> -#define BTUSB_CSR		0x04
> -#define BTUSB_SNIFFER		0x08
> -#define BTUSB_BCM92035		0x10
> -#define BTUSB_BROKEN_ISOC	0x20
> -#define BTUSB_WRONG_SCO_MTU	0x40
> -#define BTUSB_ATH3012		0x80
> +/* CHECKME: supporting mini-driver requires changing usage of driver_info from
> + * flags to static const struct. */
> +static const struct btusb_driver_info generic = {
> +	.description	= "BTUSB Generic",
> +	.flags		= BTUSB_GENERIC,
> +};
> +
> +static const struct btusb_driver_info ignore = {
> +	.description	= "BTUSB Ignore",
> +	.flags		= BTUSB_IGNORE,
> +};
> +
> +static const struct btusb_driver_info digianswer = {
> +	.description	= "BTUSB DIGIANSWER",
> +	.flags		= BTUSB_DIGIANSWER,
> +};
> +
> +static const struct btusb_driver_info csr = {
> +	.description	= "BTUSB CSR",
> +	.flags		= BTUSB_CSR,
> +};
> +
> +static const struct btusb_driver_info sniffer = {
> +	.description	= "BTUSB Sniffer",
> +	.flags		= BTUSB_SNIFFER,
> +};
> +
> +static const struct btusb_driver_info bcm92035 = {
> +	.description	= "BTUSB BCM92035",
> +	.flags		= BTUSB_BCM92035,
> +};
> +
> +static const struct btusb_driver_info broken_isoc = {
> +	.description	= "BTUSB Broken ISOC",
> +	.flags		= BTUSB_BROKEN_ISOC,
> +};
> +
> +static const struct btusb_driver_info wrong_sco_mtu = {
> +	.description	= "BTUSB Wrong SCO MTU",
> +	.flags		= BTUSB_WRONG_SCO_MTU,
> +};
> +
> +static const struct btusb_driver_info ath3012 = {
> +	.description	= "BTUSB Ath3012",
> +	.flags		= BTUSB_ATH3012,
> +};

I do not get why are you doing this. Didn't I mention last time to not
touch the blacklist handling?

You do realize that the exported btusb_probe() does not have to be the
same one as what btusb.ko itself provides as probe callback. Trying to
squeeze the usb_device_id from btusb.ko and eventual external drivers
into the same structure is just bloating the code.

Keep in mind that due to the USB_DEVICE_INFO(0xe0, 0x01, 0x01) matching
rule we need to actually blacklist all vendor drivers in btusb.ko anyway
and thus a simple BTUSB_IGNORE now turns into something nasty like
declaring a btusb_driver_info struct. I rather avoid that.

It is actually pretty important that a public exported btusb_probe()
really only does what we would expect from a default H:2 probe handler
and not any quirk handling. The existing quirks are internal to btusb.ko
and should not be inherited by any vendor driver.

So btusb_driver struct can easily use a btusb_probe_one() function that
does the quirk handling and then call btusb_probe(). Or just something
similar to that extend.

Bottom line, please do not make the code more complicated because it
looks easy now. It will backfire at some point. We need to make handling
vendor drivers easier by keeping the core H:2 driver simple.

Another option here is to have some convenience macros like
BTUSB_DEVICE_IGNORE(0x0a5c, 0x2033) that turn the code readable again.

And while you are at it, please split the mini-driver support changes
from actually modifying the HCI core. I like to have this as two
patches.

Regards

Marcel


