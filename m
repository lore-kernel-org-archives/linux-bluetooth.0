Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH 1/3] Bluetooth: btmrvl: use cal-data from device-tree instead of conf file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383257311-1430-1-git-send-email-bzhao@marvell.com>
Date: Fri, 1 Nov 2013 22:33:43 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mike Frysinger <vapier@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <39C7BB16-B89A-465E-BB9D-09374FA877C6@holtmann.org>
References: <1383257311-1430-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> The cal-data is platform dependent. It's simpler and more feasible
> to use device tree based cal-data instead of configuration file
> based cal-data.
> 
> This patch remove configuration file based cal-data downloading
> and replace it using cal-data from device tree.
> 
> Cc: Mike Frysinger <vapier@chromium.org>
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Signed-off-by: Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  4 --
> drivers/bluetooth/btmrvl_main.c | 92 ++++++++---------------------------------
> drivers/bluetooth/btmrvl_sdio.c |  9 +---
> drivers/bluetooth/btmrvl_sdio.h |  2 -
> 4 files changed, 18 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index f9d1833..be76851 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -23,8 +23,6 @@
> #include <linux/bitops.h>
> #include <linux/slab.h>
> #include <net/bluetooth/bluetooth.h>
> -#include <linux/ctype.h>
> -#include <linux/firmware.h>
> 
> #define BTM_HEADER_LEN			4
> #define BTM_UPLD_SIZE			2312
> @@ -43,8 +41,6 @@ struct btmrvl_thread {
> struct btmrvl_device {
> 	void *card;
> 	struct hci_dev *hcidev;
> -	struct device *dev;
> -	const char *cal_data;
> 
> 	u8 dev_type;
> 
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index 5cf31c4..a17812d 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -19,7 +19,7 @@
>  **/
> 
> #include <linux/module.h>
> -
> +#include <linux/of.h>
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>

here now it becomes tricky. Does this now depend on CONFIG_OF as well?

What happens to x86 systems that generally do not use open firmware or device tree. Do they still work? Which kind of devices need the calibration data anyway? All of them? Just the ones without EEPROM?

You need to pretty much verbose in your commit message on what is going on. And I get the feeling that you have to handle the case where CONFIG_OF is not selected.

Regards

Marcel

