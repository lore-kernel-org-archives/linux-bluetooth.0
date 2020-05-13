Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7934C2D0F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5AA206D6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 07:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEMH1n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 03:27:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41077 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgEMH1n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 03:27:43 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0B67BCED08;
        Wed, 13 May 2020 09:37:23 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 2/2] Bluetooth: btusb: Add support for TLV read version
 format and multiple Secure Boot Engines
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200511111041.4500-2-amit.k.bag@intel.com>
Date:   Wed, 13 May 2020 09:27:09 +0200
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        chethan.tumkur.narayan@intel.com,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Kiran K <kiran.k@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <452E90BA-E126-4C64-8CC5-9CC28F49D156@holtmann.org>
References: <20200511111041.4500-1-amit.k.bag@intel.com>
 <20200511111041.4500-2-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> Two FW download flows are implemented.
> 1. For controllers responding to Intel Read Version in Legacy response format
> 2. For controllers responding to Intel Read Version in TLV response format
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> drivers/bluetooth/btintel.c   | 352 +++++++++++++++++++++--
> drivers/bluetooth/btintel.h   | 185 +++++++++++-
> drivers/bluetooth/btusb.c     | 524 ++++++++++++++++++++++++----------
> drivers/bluetooth/hci_ag6xx.c |   4 +-
> drivers/bluetooth/hci_intel.c |   6 +-
> 5 files changed, 888 insertions(+), 183 deletions(-)

this patch is doing to much in a single patch. We need to split this out into more logical small changes.

> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 6a0e2c5a8beb..efe66483d057 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -204,7 +204,8 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
> }
> EXPORT_SYMBOL_GPL(btintel_hw_error);
> 
> -void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
> +void btintel_legacy_version_info(struct hci_dev *hdev,
> +				 struct legacy_intel_version *ver)
> {
> 	const char *variant;
> 
> @@ -224,7 +225,53 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
> 		    ver->fw_build_num, ver->fw_build_ww,
> 		    2000 + ver->fw_build_yy);
> }
> -EXPORT_SYMBOL_GPL(btintel_version_info);
> +EXPORT_SYMBOL_GPL(btintel_legacy_version_info);
> +
> +void btintel_tlv_version_info(struct hci_dev *hdev,
> +			struct tlv_intel_version *ver)
> +{
> +	const char *variant;
> +
> +	switch (ver->img_type) {
> +	case 0x01:
> +		variant = "Bootloader";
> +		break;
> +	case 0x03:
> +		variant = "Firmware";
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u",
> +		    variant, 2000 + (ver->timestamp >> 8),
> +		    ver->timestamp & 0xff, ver->build_type, ver->build_num);
> +}
> +EXPORT_SYMBOL_GPL(btintel_tlv_version_info);
> +
> +void btintel_tlv_boot_info(struct hci_dev *hdev,
> +			   struct tlv_intel_version *ver)
> +{
> +	bt_dev_info(hdev, "Device revision is %u",
> +		    ver->dev_rev_id);
> +
> +	bt_dev_info(hdev, "Secure boot is %s",
> +		    ver->secure_boot ? "enabled" : "disabled");
> +
> +	bt_dev_info(hdev, "OTP lock is %s",
> +		    ver->otp_lock ? "enabled" : "disabled");
> +
> +	bt_dev_info(hdev, "API lock is %s",
> +		    ver->api_lock ? "enabled" : "disabled");
> +
> +	bt_dev_info(hdev, "Debug lock is %s",
> +		    ver->debug_lock ? "enabled" : "disabled");
> +
> +	bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
> +		    ver->min_fw_build_nn, ver->min_fw_build_cw,
> +		    2000 + ver->min_fw_build_yy);
> +}
> +EXPORT_SYMBOL_GPL(btintel_tlv_boot_info);

can we just do btintel_boot_info and btintel_boot_info_tlv. I think that is a lot cleaner and doesn’t require changes to the existing code. In addition adding these two new exported helper function can be a separate patch.

> 
> int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
> 			const void *param)
> @@ -335,11 +382,88 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
> }
> EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
> 
> -int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
> +bool btintel_legacy_get_fw_name(struct legacy_intel_version *ver,
> +				struct intel_boot_params *params,
> +				char *fw_name, size_t len,
> +				const char *suffix)
> +{
> +	/* This is for legacy HCI_Intel_Read_Version command.
> +	 *
> +	 * With this Intel bootloader only the hardware variant and device
> +	 * revision information are used to select the right firmware for SfP
> +	 * and WsP.
> +	 *
> +	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
> +	 *
> +	 * Currently the supported hardware variants are:
> +	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
> +	 *   12 (0x0c) for iBT3.5 (WsP)
> +	 *
> +	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
> +	 * variant, HW revision and FW revision, as these are dependent on CNVi
> +	 * and RF Combination.
> +	 *
> +	 *   17 (0x11) for iBT3.5 (JfP)
> +	 *   18 (0x12) for iBT3.5 (ThP)
> +	 *
> +	 * The firmware file name for these will be
> +	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> +	 *
> +	 */
> +
> +	switch (ver->hw_variant) {
> +	case 0x0b:	/* SfP */
> +	case 0x0c:	/* WsP */
> +		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
> +			le16_to_cpu(ver->hw_variant),
> +			le16_to_cpu(params->dev_revid),
> +			suffix);
> +		break;
> +	case 0x11:	/* JfP */
> +	case 0x12:	/* ThP */
> +	case 0x13:	/* HrP */
> +	case 0x14:	/* CcP */
> +		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
> +			le16_to_cpu(ver->hw_variant),
> +			le16_to_cpu(ver->hw_revision),
> +			le16_to_cpu(ver->fw_revision),
> +			suffix);
> +		break;
> +	default:
> +		return false;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(btintel_legacy_get_fw_name);
> +
> +void btintel_tlv_get_fw_name(struct tlv_intel_version *ver,
> +				char *fw_name, size_t len,
> +				const char *suffix)
> +{
> +	/* This is for legacy HCI_Intel_Read_Version command.
> +	 * The firmware file name for these will be
> +	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
> +	 *
> +	 * Currently the supported hardware variants are:
> +	 * iBT4.2 23 (0x17) for TyP
> +	 * iBT4.2 24 (0x18) for Solar
> +	 */
> +	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> +		INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
> +		INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
> +		INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
> +		INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
> +		suffix);
> +}
> +EXPORT_SYMBOL_GPL(btintel_tlv_get_fw_name);
> +

Same here. Using btintel_get_fw_name and btintel_get_fw_name_tlv and then changing existing code to use it is also a nice patch that can be separate.

> +int btintel_read_version(struct hci_dev *hdev,
> +			 struct legacy_intel_version *ver)

Keep the original struct name and use intel_version_tlv for the new one. It causes less change to existing code. Makes it a lot easier to review.

> {
> 	struct sk_buff *skb;
> 
> -	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
> +	skb = __hci_cmd_sync(hdev, INTEL_READ_VERSION_CMD, 0, NULL,
> +			     HCI_CMD_TIMEOUT);

Do these changes in a separate patch since they are fundamentally just cleanups. I opted against it and used plain opcode numbers since either the function name above made it clear what it is or the comment. And then I could fit everything into a single line.

> 	if (IS_ERR(skb)) {
> 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> 			   PTR_ERR(skb));
> @@ -360,6 +484,54 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
> }
> EXPORT_SYMBOL_GPL(btintel_read_version);
> 
> +int btintel_new_read_version(struct hci_dev *hdev, bool *is_tlv_format,
> +		struct sk_buff **skb)
> +{
> +	u8 param;
> +	u8 status;
> +	u8 tlv_check_octet;
> +
> +	param = 0xFF;
> +
> +	*skb = __hci_cmd_sync(hdev, INTEL_READ_VERSION_CMD, 1, &param,
> +			      HCI_CMD_TIMEOUT);
> +	if (IS_ERR(*skb)) {
> +		bt_dev_err(hdev, "Reading Intel version failed (%ld)",
> +			   PTR_ERR(*skb));
> +		return PTR_ERR(*skb);
> +	}
> +
> +	/* Check status */
> +	status = *((u8 *)((*skb)->data));
> +	if (status) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   status);
> +		kfree_skb(*skb);
> +		return -bt_to_errno(status);
> +	}
> +
> +	/* There are two variants of HCI_Intel_Read_Version_Command_Complete
> +	 * depending on SKU type (legacy and TLV format).If the skb->len
> +	 * parameter is equal to LEGACY_INTEL_VERSION_LEN  AND the first octet
> +	 * after the status parameter is either equal to 0x37 or less than
> +	 * 0x10, then it's the legacy format, otherwise it's the TLV format
> +	 */
> +
> +	/* Fetch the octet after status */
> +	tlv_check_octet = *(((u8 *)((*skb)->data)) + 1);
> +
> +	if ((*skb)->len == LEGACY_INTEL_VERSION_LEN &&
> +		tlv_check_octet == INTEL_PLATFORM) {
> +		bt_dev_dbg(hdev, "Using Legacy Intel Version command");
> +		*is_tlv_format = false;
> +	} else {
> +		bt_dev_dbg(hdev, "Using TLV format Version command");
> +		*is_tlv_format = true;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_new_read_version);
> +

Lets do btintel_read_version_tlv here. And again, can be nicely put into a separate patch.

> /* ------- REGMAP IBT SUPPORT ------- */
> 
> #define IBT_REG_MODE_8BIT  0x00
> @@ -626,12 +798,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btintel_read_boot_params);
> 
> -int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> -			      u32 *boot_param)
> +static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
> +					      const struct firmware *fw)
> {
> 	int err;
> -	const u8 *fw_ptr;
> -	u32 frag_len;
> 
> 	/* Start the firmware download transaction with the Init fragment
> 	 * represented by the 128 bytes of CSS header.
> @@ -639,7 +809,7 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 	err = btintel_secure_send(hdev, 0x00, 128, fw->data);
> 	if (err < 0) {
> 		bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
> -		goto done;
> +		return err;
> 	}
> 
> 	/* Send the 256 bytes of public key information from the firmware
> @@ -648,7 +818,7 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 	err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
> 	if (err < 0) {
> 		bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
> -		goto done;
> +		return err;
> 	}
> 
> 	/* Send the 256 bytes of signature information from the firmware
> @@ -657,15 +827,60 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 	err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
> 	if (err < 0) {
> 		bt_dev_err(hdev, "Failed to send firmware signature (%d)", err);
> -		goto done;
> +		return err;
> +	}
> +	return 0;
> +}

If you split this out, then change the existing code first and then introduce the additional one.

> +
> +static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
> +						const struct firmware *fw)
> +{
> +	int err;
> +
> +	/* Start the firmware download transaction with the Init fragment
> +	 * represented by the 128 bytes of CSS header.
> +	 */
> +	err = btintel_secure_send(hdev, 0x00, 128, fw->data + 644);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
> +		return err;
> +	}
> +
> +	/* Send the 96 bytes of public key information from the firmware
> +	 * as the PKey fragment.
> +	 */
> +	err = btintel_secure_send(hdev, 0x03, 96, fw->data + 644 + 128);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
> +		return err;
> 	}
> 
> -	fw_ptr = fw->data + 644;
> +	/* Send the 96 bytes of signature information from the firmware
> +	 * as the Sign fragment
> +	 */
> +	err = btintel_secure_send(hdev, 0x02, 96, fw->data + 644 + 224);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send firmware signature (%d)",
> +				err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int btintel_download_firmware(struct hci_dev *hdev,
> +				     const struct firmware *fw,
> +				     size_t offset,
> +				     u32 *boot_param)
> +{
> +	const u8 *fw_ptr;
> +	u32 frag_len;
> +	int err;
> +
> +	fw_ptr = fw->data + offset;
> 	frag_len = 0;
> 
> 	while (fw_ptr - fw->data < fw->size) {
> 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> -

Don’t introduce random removal of empty lines. They are here on purpose to keep the code readable.

> 		/* Each SKU has a different reset parameter to use in the
> 		 * HCI_Intel_Reset command and it is embedded in the firmware
> 		 * data. So, instead of using static value per SKU, check
> @@ -675,13 +890,12 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 			/* The boot parameter is the first 32-bit value
> 			 * and rest of 3 octets are reserved.
> 			 */
> -			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
> -
> +			*boot_param = get_unaligned_le32(fw_ptr + frag_len
> +							 + sizeof(*cmd));
> 			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
> 		}
> 
> 		frag_len += sizeof(*cmd) + cmd->plen;
> -
> 		/* The parameter length of the secure send command requires
> 		 * a 4 byte alignment. It happens so that the firmware file
> 		 * contains proper Intel_NOP commands to align the fragments
> @@ -696,18 +910,116 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 				bt_dev_err(hdev,
> 					   "Failed to send firmware data (%d)",
> 					   err);
> -				goto done;
> +				return err;
> 			}
> 
> 			fw_ptr += frag_len;
> 			frag_len = 0;
> 		}
> 	}
> +	return 0;
> +}
> 
> -done:
> -	return err;
> +int btintel_legacy_download_firmware(struct hci_dev *hdev,
> +				const struct firmware *fw,
> +				u32 *boot_param)
> +{
> +	int err;
> +
> +	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> +	if (err)
> +		return err;
> +
> +	err = btintel_download_firmware(hdev, fw, RSA_HEADER_LEN, boot_param);
> +	if (err)
> +		return err;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_legacy_download_firmware);
> +
> +int btintel_tlv_download_firmware(struct hci_dev *hdev,
> +			const struct firmware *fw, u32 *boot_param,
> +			u8 hw_variant, u8 sbe_type)
> +{
> +	int err;
> +	u32 css_header_ver;
> +
> +	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
> +	 * only RSA secure boot engine. Hence, the corresponding sfi file will
> +	 * have RSA header of 644 bytes followed by Command Buffer.
> +	 *
> +	 * iBT hardware variants 0x17, 0x18 onwards support both RSA and ECDSA
> +	 * secure boot engine. As a result, the corresponding sfi file will
> +	 * have RSA header of 644, ECDSA header of 320 bytes followed by
> +	 * Command Buffer.
> +	 *
> +	 * CSS Header byte positions 0x08 to 0x0B represent the CSS Header
> +	 * version: RSA(0x00010000) , ECDSA (0x00020000)
> +	 */
> +	css_header_ver = (fw->data[CSS_HEADER_OFFSET + 3] << 24) |
> +			(fw->data[CSS_HEADER_OFFSET + 2] << 16) |
> +			(fw->data[CSS_HEADER_OFFSET + 1] << 8) |
> +			fw->data[CSS_HEADER_OFFSET];
> +	if (css_header_ver != 0x00010000) {
> +		bt_dev_err(hdev, "Invalid CSS Header version");
> +		return -EINVAL;
> +	}
> +
> +	if (hw_variant <= 0x14) {
> +		if (sbe_type != 0x00) {
> +			bt_dev_err(hdev, "Invalid SBE type for hardware variant (%d)",
> +					hw_variant);
> +			return -EINVAL;
> +		}
> +
> +		err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> +		if (err)
> +			return err;
> +
> +		err = btintel_download_firmware(hdev, fw, RSA_HEADER_LEN,
> +						boot_param);
> +		if (err)
> +			return err;
> +	} else if (hw_variant == 0x17 || hw_variant == 0x18) {
> +		/* Check if CSS header for ECDSA follows the RSA header */
> +		if (fw->data[ECDSA_OFFSET] != 0x06)
> +			return -EINVAL;
> +
> +		/* Check if the CSS Header version is ECDSA(0x00020000) */
> +		css_header_ver = (fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 3] << 24) |
> +				(fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 2] << 16) |
> +				(fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 1] << 8) |
> +				fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET];
> +		if (css_header_ver != 0x00020000) {
> +			bt_dev_err(hdev, "Invalid CSS Header version");
> +			return -EINVAL;
> +		}
> +
> +		if (sbe_type == 0x00) {
> +			err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> +			if (err)
> +				return err;
> +
> +			err = btintel_download_firmware(hdev, fw,
> +					RSA_HEADER_LEN + ECDSA_HEADER_LEN,
> +					boot_param);
> +			if (err)
> +				return err;
> +		} else if (sbe_type == 0x01) {
> +			err = btintel_sfi_ecdsa_header_secure_send(hdev, fw);
> +			if (err)
> +				return err;
> +
> +			err = btintel_download_firmware(hdev, fw,
> +					RSA_HEADER_LEN + ECDSA_HEADER_LEN,
> +					boot_param);
> +			if (err)
> +				return err;
> +		}
> +	}
> +	return 0;
> }
> -EXPORT_SYMBOL_GPL(btintel_download_firmware);
> +EXPORT_SYMBOL_GPL(btintel_tlv_download_firmware);

btintel_download_firmware_tlv.

> 
> void btintel_reset_to_bootloader(struct hci_dev *hdev)
> {
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index a69ea8a87b9b..07e8fc44857d 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -6,7 +6,53 @@
>  *  Copyright (C) 2015  Intel Corporation
>  */
> 
> -struct intel_version {
> +/* List of tlv type */
> +enum {
> +	INTEL_VER_TLV_CNVI_TOP = 0x10,
> +	INTEL_VER_TLV_CNVR_TOP,
> +	INTEL_VER_TLV_CNVI_BT,
> +	INTEL_VER_TLV_CNVR_BT,
> +	INTEL_VER_TLV_CNVI_OTP,
> +	INTEL_VER_TLV_CNVR_OTP,
> +	INTEL_VER_TLV_DEV_REV_ID,
> +	INTEL_VER_TLV_USB_VENDOR_ID,
> +	INTEL_VER_TLV_USB_PRODUCT_ID,
> +	INTEL_VER_TLV_PCIE_VENDOR_ID,
> +	INTEL_VER_TLV_PCIE_DEVICE_ID,
> +	INTEL_VER_TLV_PCIE_SUBSYSTEM_ID,
> +	INTEL_VER_TLV_IMAGE_TYPE,
> +	INTEL_VER_TLV_TIME_STAMP,
> +	INTEL_VER_TLV_BUILD_TYPE,
> +	INTEL_VER_TLV_BUILD_NUM,
> +	INTEL_VER_TLV_FW_BUILD_PRODUCT,
> +	INTEL_VER_TLV_FW_BUILD_HW,
> +	INTEL_VER_TLV_FW_STEP,
> +	INTEL_VER_TLV_BT_SPEC,
> +	INTEL_VER_TLV_MFG_NAME,
> +	INTEL_VER_TLV_HCI_REV,
> +	INTEL_VER_TLV_LMP_SUBVER,
> +	INTEL_VER_TLV_OTP_PATCH_VER,
> +	INTEL_VER_TLV_SECURE_BOOT,
> +	INTEL_VER_TLV_KEY_FROM_HDR,
> +	INTEL_VER_TLV_OTP_LOCK,
> +	INTEL_VER_TLV_API_LOCK,
> +	INTEL_VER_TLV_DEBUG_LOCK,
> +	INTEL_VER_TLV_MIN_FW,
> +	INTEL_VER_TLV_LIMITED_CCE,
> +	INTEL_VER_TLV_SBE_TYPE,
> +	INTEL_VER_TLV_OTP_BDADDR,
> +	INTEL_VER_TLV_UNLOCKED_STATE
> +};
> +
> +struct intel_tlv {
> +	u8 type;
> +	u8 len;
> +	u8 val[0];
> +} __packed;
> +
> +/* Length of legacy HCI_Intel_Read_Version structure*/
> +#define LEGACY_INTEL_VERSION_LEN	10
> +struct legacy_intel_version {
> 	u8 status;
> 	u8 hw_platform;
> 	u8 hw_variant;
> @@ -19,6 +65,46 @@ struct intel_version {
> 	u8 fw_patch_num;
> } __packed;
> 
> +struct tlv_intel_version {
> +	u8	 status;
> +	u32	 cnvi_top;
> +	u32	 cnvr_top;
> +	u32	 cnvi_bt;
> +	u32	 cnvr_bt;
> +	u16	 cnvi_otp;
> +	u16	 cnvr_otp;
> +	u16	 dev_rev_id;
> +	u16	 usb_vid;
> +	u16	 usb_pid;
> +	u16	 pcie_vendor_id;
> +	u16	 pcie_dev_id;
> +	u16	 pcie_subsys_id;
> +	u8	 img_type;
> +	u16	 timestamp;
> +	u8	 build_type;
> +	u32	 build_num;
> +	u8	 fw_build_prod;
> +	u8	 fw_build_hw;
> +	u8	 fw_build_step;
> +	u8	 bt_spec_ver;
> +	u16	 mfg_name;
> +	u16	 hci_rev;
> +	u16	 lmp_sub_ver;
> +	u8	 otp_patch_ver;
> +	u8	 secure_boot;
> +	u8	 key_from_hdr;
> +	u8	 otp_lock;
> +	u8	 api_lock;
> +	u8	 debug_lock;
> +	u8	 min_fw_build_nn;
> +	u8	 min_fw_build_cw;
> +	u8	 min_fw_build_yy;
> +	u8	 limited_cce;
> +	u8	 sbe_type;
> +	bdaddr_t otp_bd_addr;
> +	u8	 unlocked_state;
> +} __packed;
> +
> struct intel_boot_params {
> 	__u8     status;
> 	__u8     otp_format;
> @@ -62,6 +148,29 @@ struct intel_reset {
> 	__le32   boot_param;
> } __packed;
> 
> +#define INTEL_READ_VERSION_CMD		 0xfc05
> +
> +#define INTEL_PLATFORM			 0x37
> +#define INTEL_HW_PLATFORM_MASK           0x0000ff00
> +#define INTEL_HW_VARIANT_MASK            0x003f0000
> +#define INTEL_CNVX_TOP_TYPE_MASK         0x00000fff
> +#define INTEL_CNVX_TOP_STEP_MASK         0x0f000000
> +
> +#define INTEL_HW_PLATFORM(cnvx_bt) ((u8)((cnvx_bt & INTEL_HW_PLATFORM_MASK)  >> 8))
> +
> +#define INTEL_HW_VARIANT(cnvx_bt)  ((u8)((cnvx_bt & INTEL_HW_VARIANT_MASK)   >> 16))
> +
> +#define INTEL_CNVX_TOP_TYPE(cnvx_top)  (cnvx_top & INTEL_CNVX_TOP_TYPE_MASK)
> +
> +#define INTEL_CNVX_TOP_STEP(cnvx_top)  ((cnvx_top & INTEL_CNVX_TOP_STEP_MASK) >> 24)
> +
> +#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)((t << 4) | s)))

Is this endian safe?

> +
> +#define CSS_HEADER_OFFSET	8
> +#define RSA_HEADER_LEN		644
> +#define ECDSA_HEADER_LEN	320
> +#define ECDSA_OFFSET		RSA_HEADER_LEN
> +
> #if IS_ENABLED(CONFIG_BT_INTEL)

I will look at the rest once this is split into more logical small patches.

Regards

Marcel

