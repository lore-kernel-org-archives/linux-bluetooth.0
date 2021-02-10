Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5455DC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1614560233
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 15:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhBJPVO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:21:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35062 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhBJPVL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 10:21:11 -0500
Received: from mac-pro.holtmann.net (p5b3d2ec1.dip0.t-ipconnect.de [91.61.46.193])
        by mail.holtmann.org (Postfix) with ESMTPSA id C432DCECDF;
        Wed, 10 Feb 2021 16:27:55 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 2/6] Bluetooth: btintel: Move operational checks after
 version check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210209233404.2121960-2-luiz.dentz@gmail.com>
Date:   Wed, 10 Feb 2021 16:20:26 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <305CB64A-661D-4C6A-BC0A-ADCF162A940A@holtmann.org>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
 <20210209233404.2121960-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> In order to allow new firmware to be loaded it first needs to check if
> the firmware version on file matches the one loaded if it doesn't then
> it needs to revert to boorloader mode in order to load the new firmware.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btintel.c | 22 +++++++++++
> drivers/bluetooth/btusb.c   | 74 +++++++++++++++----------------------
> 2 files changed, 52 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 153989bd8d5f..ccab05f67df9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -948,6 +948,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
> 		return -EALREADY;
> 	}
> 
> +	/* The firmware variant determines if the device is in bootloader
> +	 * mode or is running operational firmware. The value 0x06 identifies
> +	 * the bootloader and the value 0x23 identifies the operational
> +	 * firmware.
> +	 *
> +	 * If the firmware version has changed that means it needs to be reset
> +	 * to bootloader when operational so the new firmware can be loaded.
> +	 */
> +	if (ver->fw_variant == 0x23)
> +		return -EINVAL;
> +
> 	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> 	if (err)
> 		return err;
> @@ -974,6 +985,17 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 		return -EALREADY;
> 	}
> 
> +	/* The firmware variant determines if the device is in bootloader
> +	 * mode or is running operational firmware. The value 0x03 identifies
> +	 * the bootloader and the value 0x23 identifies the operational
> +	 * firmware.
> +	 *
> +	 * If the firmware version has changed that means it needs to be reset
> +	 * to bootloader when operational so the new firmware can be loaded.
> +	 */
> +	if (ver->img_type == 0x03)
> +		return -EINVAL;
> +
> 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
> 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
> 	 * have RSA header of 644 bytes followed by Command Buffer.
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e896c6702d60..113ff780232f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2469,14 +2469,30 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 	return -EILSEQ;
> }
> 
> -static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> +static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> 					     struct intel_boot_params *params,
> 					     char *fw_name, size_t len,
> 					     const char *suffix)
> {
> +	/* The hardware platform number has a fixed value of 0x37 and
> +	 * for now only accept this single value.
> +	 */
> +	if (ver->hw_platform != 0x37)
> +		return -EINVAL;
> +
> 	switch (ver->hw_variant) {
> 	case 0x0b:	/* SfP */
> 	case 0x0c:	/* WsP */
> +		/* The firmware variant determines if the device is in
> +		 * bootloader mode or is running operational firmware.
> +		 *
> +		 * Version checking cannot be performed in these models since
> +		 * the firmware versioning depends on the firmware being in
> +		 * bootloader mode.
> +		 */
> +		if (ver->fw_variant == 0x23)
> +			return -EALREADY;
> +
> 		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
> 			le16_to_cpu(ver->hw_variant),
> 			le16_to_cpu(params->dev_revid),
> @@ -2493,9 +2509,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> 			suffix);
> 		break;
> 	default:
> -		return false;
> +		return -EINVAL;
> 	}
> -	return true;
> +
> +	return 0;
> }
> 
> static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
> @@ -2550,7 +2567,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
> 	if (ver->img_type == 0x03) {
> 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
> 		btintel_check_bdaddr(hdev);
> -		return 0;
> 	}
> 
> 	/* Check for supported iBT hardware variants of this firmware
> @@ -2693,35 +2709,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> 	if (!ver || !params)
> 		return -EINVAL;
> 
> -	/* The hardware platform number has a fixed value of 0x37 and
> -	 * for now only accept this single value.
> -	 */
> -	if (ver->hw_platform != 0x37) {
> -		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
> -			   ver->hw_platform);
> -		return -EINVAL;
> -	}
> -
> -	/* Check for supported iBT hardware variants of this firmware
> -	 * loading method.
> -	 *
> -	 * This check has been put in place to ensure correct forward
> -	 * compatibility options when newer hardware variants come along.
> -	 */
> -	switch (ver->hw_variant) {
> -	case 0x0b:	/* SfP */
> -	case 0x0c:	/* WsP */
> -	case 0x11:	/* JfP */
> -	case 0x12:	/* ThP */
> -	case 0x13:	/* HrP */
> -	case 0x14:	/* CcP */
> -		break;
> -	default:
> -		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
> -			   ver->hw_variant);
> -		return -EINVAL;
> -	}
> -

why are you removing this? I put this in so that really only supported platforms are tried. We want to fail if you run on hardware that isn’t officially tested with this driver.

Regards

Marcel

