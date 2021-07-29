Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8A860C3F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhG2ThL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:37:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55193 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2ThK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:37:10 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 405E8CED1E;
        Thu, 29 Jul 2021 21:37:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 06/11] Bluetooth: btintel: Fix the LED is not turning
 off immediately
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-7-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:37:05 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <713867AE-9A06-4854-B897-2610AC8D5B09@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-7-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> Some platforms have an issue with BT LED when the interface is
> down or BT radio is turned off, which takes 5 seconds to BT LED
> goes off. This command turns off the BT LED immediately.
> 
> This patch sends the Intel vendor command to turn off the LED.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 17 +++++++++++++++++
> drivers/bluetooth/btintel.h |  1 +
> drivers/bluetooth/btusb.c   | 11 +++++++++--
> 3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 65ecf2ae9a10..4e72d806387c 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1757,7 +1757,9 @@ EXPORT_SYMBOL_GPL(btintel_setup_combined);
> 
> int btintel_shutdown_combined(struct hci_dev *hdev)
> {
> +	struct btintel_data *intel = hci_get_priv(hdev);
> 	struct sk_buff *skb;
> +	int ret;
> 
> 	/* Send HCI Reset to the controller to stop any BT activity which
> 	 * were triggered. This will help to save power and maintain the
> @@ -1770,6 +1772,21 @@ int btintel_shutdown_combined(struct hci_dev *hdev)
> 	}
> 	kfree_skb(skb);
> 
> +
> +	/* Some platforms have an issue with BT LED when the interface is
> +	 * down or BT radio is turned off, which takes 5 seconds to BT LED
> +	 * goes off. This command turns off the BT LED immediately.
> +	 */
> +	if (test_bit(INTEL_BROKEN_LED, &intel->flags)) {
> +		skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			ret = PTR_ERR(skb);
> +			bt_dev_err(hdev, "turning off Intel device LED failed");
> +			return ret;
> +		}
> +		kfree_skb(skb);
> +	}
> +
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 29b678364a79..4a35762c3220 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -144,6 +144,7 @@ struct intel_debug_features {
> #define INTEL_FIRMWARE_FAILED		3
> #define INTEL_BOOTING			4
> #define INTEL_BROKEN_READ_VERSION	5
> +#define INTEL_BROKEN_LED		6
> 
> struct btintel_data {
> 	unsigned long flags;
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a64473c525eb..8f87c600d026 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -63,6 +63,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_INTEL_NEWGEN	0x2000000
> #define BTUSB_INTEL_COMBINED	0x4000000
> #define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
> +#define BTUSB_INTEL_BROKEN_LED	0x10000000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -378,13 +379,16 @@ static const struct usb_device_id blacklist_table[] = {
> 						     BTUSB_VALID_LE_STATES },
> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
> -						     BTUSB_INTEL_BROKEN_READ_VERSION },
> +						     BTUSB_INTEL_BROKEN_READ_VERSION |
> +						     BTUSB_INTEL_BROKEN_LED },
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> -						     BTUSB_INTEL_BROKEN_READ_VERSION },
> +						     BTUSB_INTEL_BROKEN_READ_VERSION |
> +						     BTUSB_INTEL_BROKEN_LED },
> 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_INTEL_BROKEN_READ_VERSION |
> +						     BTUSB_INTEL_BROKEN_LED |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
> 						     BTUSB_WIDEBAND_SPEECH |

this is something you need to learn from the HCI_Intel_Read_Version information. This should not bleed into the USB driver.

Regards

Marcel

