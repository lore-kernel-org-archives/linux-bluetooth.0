Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: ath3k: workaround the compatibility issue with xHCI controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422474752-26871-1-git-send-email-adam.lee@canonical.com>
Date: Wed, 28 Jan 2015 12:10:21 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0731CFAA-B45A-4DC2-8579-1A4E5E7707F3@holtmann.org>
References: <1422474752-26871-1-git-send-email-adam.lee@canonical.com>
To: Adam Lee <adam.lee@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> BugLink: https://bugs.launchpad.net/bugs/1400215
> 
> ath3k devices fail to load firmwares on xHCI buses, but work well on
> EHCI, this might be a compatibility issue between xHCI and ath3k chips.
> As my testing result, those chips will work on xHCI buses again with
> this patch.
> 
> This workaround is from Qualcomm, they also did some workarounds in
> Windows driver.
> 
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> ---
> drivers/bluetooth/ath3k.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 1ee27ac..98ae0b1 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -174,6 +174,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
> #define USB_REQ_DFU_DNLOAD	1
> #define BULK_SIZE		4096
> #define FW_HDR_SIZE		20
> +#define TIMEGAP_US		100
> 
> static int ath3k_load_firmware(struct usb_device *udev,
> 				const struct firmware *firmware)
> @@ -205,6 +206,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
> 	pipe = usb_sndbulkpipe(udev, 0x02);
> 
> 	while (count) {
> +		/* workaround the compatibility issue with xHCI controller*/
> +		usleep_range(TIMEGAP_US - 50, TIMEGAP_US);
> +

why are you using a usleep_range() here. Why not just sleep for 100us.

Regards

Marcel

