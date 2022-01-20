Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB23C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 07:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiATHzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:55:01 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57307 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbiATHzA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 02:55:00 -0500
Received: from [192.168.0.2] (ip5f5aeaa6.dynamic.kabel-deutschland.de [95.90.234.166])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD48C61EA191E;
        Thu, 20 Jan 2022 08:54:58 +0100 (CET)
Message-ID: <cd830242-8d22-915b-6ec9-db95d3739ec7@molgen.mpg.de>
Date:   Thu, 20 Jan 2022 08:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM
 products
Content-Language: en-US
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-bluetooth@vger.kernel.org
References: <20220120075004.293700-1-hj.tedd.an@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220120075004.293700-1-hj.tedd.an@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Tedd,


Thank you for the patch.

Am 20.01.22 um 08:50 schrieb Tedd Ho-Jeong An:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>

As this seems to be a regression, please describe the failure case, and 
how to reproduce it.

> This patch adds the flag to identify the Intel legacy ROM products that
> don't support WBS like WP and StP.

Please add, why the quirk is only for to 0x07dc and 0x0a2a, and how it 
was tested.

> Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 10 +++++++---
>   drivers/bluetooth/btintel.h |  1 +
>   drivers/bluetooth/btusb.c   |  6 ++++++
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 1a4f8b227eac..225ed0373e9d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2428,10 +2428,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   
>   			/* Apply the device specific HCI quirks
>   			 *
> -			 * WBS for SdP - SdP and Stp have a same hw_varaint but
> -			 * different fw_variant
> +			 * WBS for SdP - For the Legacy ROM products, only SdP
> +			 * supports the WBS. But the version information is not
> +			 * enough to use here because the StP2 and SdP have same
> +			 * hw_variant and fw_variant. So, this flag is set by
> +			 * the transport driver(btusb) based on the HW info

Please add a space before (.

> +			 * (idProduct)
>   			 */
> -			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
> +			if (!btintel_test_flag(hdev, INTEL_NO_WBS_SUPPORT))
>   				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>   					&hdev->quirks);
>   
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index c9b24e9299e2..084a5e8dce39 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -152,6 +152,7 @@ enum {
>   	INTEL_BROKEN_INITIAL_NCMD,
>   	INTEL_BROKEN_SHUTDOWN_LED,
>   	INTEL_ROM_LEGACY,
> +	INTEL_NO_WBS_SUPPORT,
>   
>   	__INTEL_NUM_FLAGS,
>   };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c30d131da784..566501e64c5a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
>   #define BTUSB_QCA_WCN6855	0x1000000
>   #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
>   #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
> +#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
>   
>   static const struct usb_device_id btusb_table[] = {
>   	/* Generic Bluetooth USB device */
> @@ -385,9 +386,11 @@ static const struct usb_device_id blacklist_table[] = {
>   	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>   	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_NO_WBS_SUPPORT |
>   						     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
>   						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
>   	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> +						     BTUSB_INTEL_NO_WBS_SUPPORT |
>   						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
>   	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> @@ -3737,6 +3740,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		hdev->send = btusb_send_frame_intel;
>   		hdev->cmd_timeout = btusb_intel_cmd_timeout;
>   
> +		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
> +			btintel_set_flag(hdev, INTEL_NO_WBS_SUPPORT);
> +
>   		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
>   			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
>   


Kind regards,

Paul
