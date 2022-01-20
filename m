Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA66C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 10:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359785AbiATKOB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:14:01 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:32943 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359784AbiATKOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 05:14:00 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id AEDCFCECF1;
        Thu, 20 Jan 2022 11:13:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM
 products
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220120075004.293700-1-hj.tedd.an@gmail.com>
Date:   Thu, 20 Jan 2022 11:13:58 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D75FCA2E-2843-4C14-BF0D-3AFDE0FA1C8E@holtmann.org>
References: <20220120075004.293700-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch adds the flag to identify the Intel legacy ROM products that
> don't support WBS like WP and StP.
> 
> Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 10 +++++++---
> drivers/bluetooth/btintel.h |  1 +
> drivers/bluetooth/btusb.c   |  6 ++++++
> 3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 1a4f8b227eac..225ed0373e9d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2428,10 +2428,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> 
> 			/* Apply the device specific HCI quirks
> 			 *
> -			 * WBS for SdP - SdP and Stp have a same hw_varaint but
> -			 * different fw_variant
> +			 * WBS for SdP - For the Legacy ROM products, only SdP
> +			 * supports the WBS. But the version information is not
> +			 * enough to use here because the StP2 and SdP have same
> +			 * hw_variant and fw_variant. So, this flag is set by
> +			 * the transport driver(btusb) based on the HW info
> +			 * (idProduct)
> 			 */
> -			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
> +			if (!btintel_test_flag(hdev, INTEL_NO_WBS_SUPPORT))
> 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> 					&hdev->quirks);
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index c9b24e9299e2..084a5e8dce39 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -152,6 +152,7 @@ enum {
> 	INTEL_BROKEN_INITIAL_NCMD,
> 	INTEL_BROKEN_SHUTDOWN_LED,
> 	INTEL_ROM_LEGACY,
> +	INTEL_NO_WBS_SUPPORT,

please keep it as INTEL_ROM_LEGACY_NO_WBS or INTEL_ROM_LEGACY_NO_WBS_SUPPORT. It is better to make clear that this is only for our ROM products. Especially since above it is in the section for just the ROM products.

Regards

Marcel

