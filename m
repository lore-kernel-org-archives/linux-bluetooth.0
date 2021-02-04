Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1417C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88DB64F44
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhBDM4i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:56:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35903 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhBDM4g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 07:56:36 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19B99CED16;
        Thu,  4 Feb 2021 14:03:21 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btintel: Check firmware version before
 download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210203220143.1257924-1-luiz.dentz@gmail.com>
Date:   Thu, 4 Feb 2021 13:55:51 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <87D4E73F-28F3-41C2-AE9F-6AA880043BAD@holtmann.org>
References: <20210203220143.1257924-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This checking the firmware build number, week and years matches and then
> skip the download process.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btintel.c   | 92 +++++++++++++++++++++++++++--------
> drivers/bluetooth/btintel.h   |  5 +-
> drivers/bluetooth/btusb.c     | 28 +++++++----
> drivers/bluetooth/hci_intel.c |  7 ++-
> 4 files changed, 98 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 88ce5f0ffc4b..7853ff4df237 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -24,6 +24,14 @@
> #define ECDSA_OFFSET		644
> #define ECDSA_HEADER_LEN	320
> 
> +#define CMD_WRITE_BOOT_PARAMS	0xfc0e
> +struct cmd_write_boot_params {
> +	u32 boot_addr;
> +	u8  fw_build_num;
> +	u8  fw_build_ww;
> +	u8  fw_build_yy;
> +} _packed;
> +

it should be __packed here. Didn’t know that _packed exists.

> int btintel_check_bdaddr(struct hci_dev *hdev)
> {
> 	struct hci_rp_read_bd_addr *bda;
> @@ -841,7 +849,7 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
> 
> static int btintel_download_firmware_payload(struct hci_dev *hdev,
> 					     const struct firmware *fw,
> -					     u32 *boot_param, size_t offset)
> +					     size_t offset)
> {
> 	int err;
> 	const u8 *fw_ptr;
> @@ -854,20 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
> 	while (fw_ptr - fw->data < fw->size) {
> 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> 
> -		/* Each SKU has a different reset parameter to use in the
> -		 * HCI_Intel_Reset command and it is embedded in the firmware
> -		 * data. So, instead of using static value per SKU, check
> -		 * the firmware data and save it for later use.
> -		 */
> -		if (le16_to_cpu(cmd->opcode) == 0xfc0e) {
> -			/* The boot parameter is the first 32-bit value
> -			 * and rest of 3 octets are reserved.
> -			 */
> -			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
> -
> -			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
> -		}
> -
> 		frag_len += sizeof(*cmd) + cmd->plen;
> 
> 		/* The parameter length of the secure send command requires
> @@ -896,28 +890,88 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
> 	return err;
> }
> 
> +static bool btintel_firmware_version(struct hci_dev *hdev,
> +				     u8 num, u8 ww, u8 yy,
> +				     const struct firmware *fw,
> +				     u32 *boot_addr)
> +{
> +	const u8 *fw_ptr;
> +	u32 frag_len;
> +
> +	fw_ptr = fw->data;
> +	frag_len = 0;
> +
> +	while (fw_ptr - fw->data < fw->size) {
> +		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> +
> +		/* Each SKU has a different reset parameter to use in the
> +		 * HCI_Intel_Reset command and it is embedded in the firmware
> +		 * data. So, instead of using static value per SKU, check
> +		 * the firmware data and save it for later use.
> +		 */
> +		if (le16_to_cpu(cmd->opcode) == CMD_WRITE_BOOT_PARAMS) {
> +			struct cmd_write_boot_params *params;
> +
> +			params = (void *)(fw_ptr + sizeof(*cmd));
> +
> +			bt_dev_dbg(hdev, "Boot Address: 0x%x",
> +				   le32_to_cpu(params->boot_addr));
> +
> +			bt_dev_dbg(hdev, "Firmware Version: %u-%u.%u",
> +				   params->fw_build_num, params->fw_build_ww,
> +				   params->fw_build_yy);
> +
> +			return (num == params->fw_build_num &&
> +				ww == params->fw_build_ww &&
> +				yy == params->fw_build_yy);
> +		}
> +
> +		frag_len += sizeof(*cmd) + cmd->plen;
> +	}
> +
> +	return false;
> +}
> +
> int btintel_download_firmware(struct hci_dev *hdev,
> +			      struct intel_version *ver,
> 			      const struct firmware *fw,
> 			      u32 *boot_param)
> {
> 	int err;
> 
> +	/* Skip download if firmware has the same version */
> +	if (btintel_firmware_version(hdev, ver->fw_build_num, ver->fw_build_ww,
> +				     ver->fw_build_yy, fw, boot_param))
> +		/* Return -EALREADY to indicate that the firmware has already
> +		 * been loaded.
> +		 */
> +		return -EALREADY;
> +

In these cases we put the { } around it to make it visually more clear. And I would actually shorten the comment to “Return here to indicate that the firmware has already been loaded */. The EALREADY is self-explanatory.

> 	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> 	if (err)
> 		return err;
> 
> -	return btintel_download_firmware_payload(hdev, fw, boot_param,
> -						 RSA_HEADER_LEN);
> +	return btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
> }
> EXPORT_SYMBOL_GPL(btintel_download_firmware);
> 
> int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +				     struct intel_version_tlv *ver,
> 				     const struct firmware *fw, u32 *boot_param,
> 				     u8 hw_variant, u8 sbe_type)
> {
> 	int err;
> 	u32 css_header_ver;
> 
> +	/* Skip download if firmware has the same version */
> +	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> +				     ver->min_fw_build_cw, ver->min_fw_build_yy,
> +				     fw, boot_param))
> +		/* Return -EALREADY to indicate that firmware has already been
> +		 * loaded.
> +		 */
> +		return -EALREADY;
> +

Same as above.

> 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
> 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
> 	 * have RSA header of 644 bytes followed by Command Buffer.
> @@ -947,7 +1001,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 		if (err)
> 			return err;
> 
> -		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> +		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
> 		if (err)
> 			return err;
> 	} else if (hw_variant >= 0x17) {
> @@ -968,7 +1022,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 				return err;
> 
> 			err = btintel_download_firmware_payload(hdev, fw,
> -								boot_param,
> 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
> 			if (err)
> 				return err;
> @@ -978,7 +1031,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 				return err;
> 
> 			err = btintel_download_firmware_payload(hdev, fw,
> -								boot_param,
> 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
> 			if (err)
> 				return err;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 6511b091caf5..51f1f2c883b4 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -163,9 +163,10 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
> int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
> int btintel_read_boot_params(struct hci_dev *hdev,
> 			     struct intel_boot_params *params);
> -int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
> -			      u32 *boot_param);
> +int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> +			      const struct firmware *fw, u32 *boot_param);
> int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +				     struct intel_version_tlv *ver,
> 				     const struct firmware *fw,
> 				     u32 *boot_param, u8 hw_variant,
> 				     u8 sbe_type);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4266c057746e..46a6795198da 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2612,14 +2612,18 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
> 	set_bit(BTUSB_DOWNLOADING, &data->flags);
> 
> 	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
> +	err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
> 					       INTEL_HW_VARIANT(ver->cnvi_bt),
> 					       ver->sbe_type);
> 	if (err < 0) {
> -		/* When FW download fails, send Intel Reset to retry
> -		 * FW download.
> -		 */
> -		btintel_reset_to_bootloader(hdev);
> +		/* -EALREADY indicates the firmware has already been loaded */
> +		if (err == -EALREADY)
> +			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> +		else
> +			/* When FW download fails, send Intel Reset to retry
> +			 * FW download.
> +			 */
> +			btintel_reset_to_bootloader(hdev);
> 		goto done;
> 	}
> 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> @@ -2806,12 +2810,16 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> 	set_bit(BTUSB_DOWNLOADING, &data->flags);
> 
> 	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware(hdev, fw, boot_param);
> +	err = btintel_download_firmware(hdev, ver, fw, boot_param);
> 	if (err < 0) {
> -		/* When FW download fails, send Intel Reset to retry
> -		 * FW download.
> -		 */
> -		btintel_reset_to_bootloader(hdev);
> +		/* -EALREADY indicates the firmware has already been loaded */

> +		if (err == -EALREADY)
> +			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> +		else
> +			/* When FW download fails, send Intel Reset to retry
> +			 * FW download.
> +			 */
> +			btintel_reset_to_bootloader(hdev);
> 		goto done;

	if (err == -EALREADY) {
		/* Firmware has already been loaded */
		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
		goto done;
	}

	/* If the firmware download fails, send Intel Reset to retry
	 * the download. */
	btintel_reset_to_bootloader(hdev);
	goto done;


This way it is just a lot easy to read in case we ever need to look at this part of the code again.

> 	}
> 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index b20a40fab83e..7249b91d9b91 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -735,7 +735,7 @@ static int intel_setup(struct hci_uart *hu)
> 	set_bit(STATE_DOWNLOADING, &intel->flags);
> 
> 	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware(hdev, fw, &boot_param);
> +	err = btintel_download_firmware(hdev, &ver, fw, &boot_param);
> 	if (err < 0)
> 		goto done;
> 
> @@ -784,7 +784,10 @@ static int intel_setup(struct hci_uart *hu)
> done:
> 	release_firmware(fw);
> 
> -	if (err < 0)
> +	/* Check if there was an error and if is not -EALREADY which means the
> +	 * firmware has already been loaded.
> +	 */
> +	if (err < 0 && err != -EALREADY)
> 		return err;
> 
> 	/* We need to restore the default speed before Intel reset */

Regards

Marcel

