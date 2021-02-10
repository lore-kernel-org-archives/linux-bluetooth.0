Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE895C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 04:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CC164E25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBJEjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 23:39:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:41812 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBJEjD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 23:39:03 -0500
IronPort-SDR: Q6Ay4g392bO96VjhNUHKUul5oR7nbnRsbQHbCkOVapJ+f4sC7UijCj0wBisBcTfFfLlXiOWJIA
 EJPt+ftQYlGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182077149"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182077149"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 20:37:17 -0800
IronPort-SDR: sRL/fY8f4ZgQzx28jNN8vnE1Rskqm0YNJr+NJ/UOdzEPJ3B+XcT7Dube8RTgDC6ScCvP9caVKC
 UgsEc1CL7oTg==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="488479483"
Received: from acquinto-mobl.amr.corp.intel.com ([10.251.24.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 20:37:17 -0800
Message-ID: <fbacbb20e9c1863f9f52d8889061ead0b5563830.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/6] Bluetooth: btintel: Move operational checks
 after version check
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Feb 2021 20:37:16 -0800
In-Reply-To: <20210209233404.2121960-2-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
         <20210209233404.2121960-2-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 2021-02-09 at 15:34 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In order to allow new firmware to be loaded it first needs to check if
> the firmware version on file matches the one loaded if it doesn't then
> it needs to revert to boorloader mode in order to load the new firmware.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 22 +++++++++++
>  drivers/bluetooth/btusb.c   | 74 +++++++++++++++----------------------
>  2 files changed, 52 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 153989bd8d5f..ccab05f67df9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -948,6 +948,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
>  		return -EALREADY;
>  	}
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
>  	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
>  	if (err)
>  		return err;
> @@ -974,6 +985,17 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  		return -EALREADY;
>  	}
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
>  	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
>  	 * only RSA secure boot engine. Hence, the corresponding sfi file will
>  	 * have RSA header of 644 bytes followed by Command Buffer.
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e896c6702d60..113ff780232f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2469,14 +2469,30 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
>  	return -EILSEQ;
>  }
>  
> -static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> +static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
>  					     struct intel_boot_params *params,
>  					     char *fw_name, size_t len,
>  					     const char *suffix)
>  {
> +	/* The hardware platform number has a fixed value of 0x37 and
> +	 * for now only accept this single value.
> +	 */
> +	if (ver->hw_platform != 0x37)
> +		return -EINVAL;
> +
>  	switch (ver->hw_variant) {
>  	case 0x0b:	/* SfP */
>  	case 0x0c:	/* WsP */
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
>  		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
>  			le16_to_cpu(ver->hw_variant),
>  			le16_to_cpu(params->dev_revid),
> @@ -2493,9 +2509,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
>  			suffix);
>  		break;
>  	default:
> -		return false;
> +		return -EINVAL;
>  	}
> -	return true;
> +
> +	return 0;
>  }
>  
>  static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
> @@ -2550,7 +2567,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
>  	if (ver->img_type == 0x03) {
>  		clear_bit(BTUSB_BOOTLOADER, &data->flags);
>  		btintel_check_bdaddr(hdev);
> -		return 0;
>  	}
>  
>  	/* Check for supported iBT hardware variants of this firmware
> @@ -2693,35 +2709,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>  	if (!ver || !params)
>  		return -EINVAL;
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
>  	btintel_version_info(hdev, ver);
>  
>  	/* The firmware variant determines if the device is in bootloader
> @@ -2740,16 +2727,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>  	if (ver->fw_variant == 0x23) {
>  		clear_bit(BTUSB_BOOTLOADER, &data->flags);
>  		btintel_check_bdaddr(hdev);
> -		return 0;
> -	}
> -
> -	/* If the device is not in bootloader mode, then the only possible
> -	 * choice is to return an error and abort the device initialization.
> -	 */
> -	if (ver->fw_variant != 0x06) {
> -		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
> -			   ver->fw_variant);
> -		return -ENODEV;
> +		/* Proceed to download to check if the version matches */
> +		goto download;
>  	}
>  
>  	/* Read the secure boot parameters to identify the operating
> @@ -2777,6 +2756,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>  		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>  	}
>  
> +download:
>  	/* With this Intel bootloader only the hardware variant and device
>  	 * revision information are used to select the right firmware for SfP
>  	 * and WsP.
> @@ -2800,7 +2780,13 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>  	 */
>  	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
>  						sizeof(fwname), "sfi");
> -	if (!err) {

There is one more place to change the handling of return code for this function.

err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
					sizeof(ddcname), "ddc");
if (!err) {
	bt_dev_err(hdev, "Unsupported Intel firmware naming");
} else {



> +	if (err < 0) {
> +		if (err == -EALREADY) {
> +			/* Firmware has already been loaded */
> +			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> +			goto done;
> +		}
> +
>  		bt_dev_err(hdev, "Unsupported Intel firmware naming");
>  		return -EINVAL;
>  	}

