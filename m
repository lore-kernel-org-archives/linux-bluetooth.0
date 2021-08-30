Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD026C4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB66060C3F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhH3PIx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:08:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35273 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhH3PIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 11:08:52 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id BAD0CCEC82;
        Mon, 30 Aug 2021 17:07:55 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix boot address
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210820115808.15895-1-kiran.k@intel.com>
Date:   Mon, 30 Aug 2021 17:07:55 +0200
Cc:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7E8C3893-19CD-44D6-B224-A3434F65BA95@holtmann.org>
References: <20210820115808.15895-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Cache Boot address present in firmware file which
> is later used Intel_Soft_Reset command to bring
> controller from boot mode to operational mode.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> drivers/bluetooth/btintel.c | 31 +++++++++++++------------------
> 1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index f1705b46fc88..80d6dd7ae51a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1037,8 +1037,9 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
> 
> 			params = (void *)(fw_ptr + sizeof(*cmd));
> 
> -			bt_dev_info(hdev, "Boot Address: 0x%x",
> -				    le32_to_cpu(params->boot_addr));
> +			*boot_addr = le32_to_cpu(params->boot_addr);
> +
> +			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
> 

so this hunk looks good and is described in the commit message.

> 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
> 				    params->fw_build_num, params->fw_build_ww,
> @@ -1071,9 +1072,6 @@ int btintel_download_firmware(struct hci_dev *hdev,
> 		/* Skip version checking */
> 		break;
> 	default:
> -		/* Skip reading firmware file version in bootloader mode */
> -		if (ver->fw_variant == 0x06)
> -			break;
> 
> 		/* Skip download if firmware has the same version */
> 		if (btintel_firmware_version(hdev, ver->fw_build_num,
> @@ -1114,19 +1112,16 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
> 	int err;
> 	u32 css_header_ver;
> 
> -	/* Skip reading firmware file version in bootloader mode */
> -	if (ver->img_type != 0x01) {
> -		/* Skip download if firmware has the same version */
> -		if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> -					     ver->min_fw_build_cw,
> -					     ver->min_fw_build_yy,
> -					     fw, boot_param)) {
> -			bt_dev_info(hdev, "Firmware already loaded");
> -			/* Return -EALREADY to indicate that firmware has
> -			 * already been loaded.
> -			 */
> -			return -EALREADY;
> -		}
> +	/* Skip download if firmware has the same version */
> +	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> +				     ver->min_fw_build_cw,
> +				     ver->min_fw_build_yy,
> +				     fw, boot_param)) {
> +		bt_dev_info(hdev, "Firmware already loaded");
> +		/* Return -EALREADY to indicate that firmware has
> +		 * already been loaded.
> +		 */
> +		return -EALREADY;
> 	}

This part however isn’t.

Regards

Marcel

