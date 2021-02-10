Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB51C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3624E64E3B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 18:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhBJSxy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:53:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:61651 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234099AbhBJSwX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 13:52:23 -0500
IronPort-SDR: erimwT1eRgbVFrDY6ZtTcCY/lSyVl2fBkOzui9y2R+FRMr5t1yurX18MhqR3ayMP/aVJJCp5Go
 XopI0qGlxf7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179575120"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="179575120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:50:36 -0800
IronPort-SDR: f1dXPjW/4ghBI1sBZK+vN5vPFkz4c075WcH5e/Iz8eu5p/ykK6tYw8T8i5qaDggyWDfucx5rrO
 ICm+0DgGbMDQ==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="436769473"
Received: from wmays-mobl.amr.corp.intel.com ([10.255.231.21])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:50:36 -0800
Message-ID: <027d8851051d084bd3108782c0c3f389a4711be1.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 10 Feb 2021 10:50:36 -0800
In-Reply-To: <20210210165916.2148856-1-luiz.dentz@gmail.com>
References: <20210210165916.2148856-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, 2021-02-10 at 08:59 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks the firmware build number, week and year matches with
> repective version loaded and then skip the download process.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Add patch that mover checks for operational mode after the version
> checking.
> v3: Fix not checking for operation mode before using btintel_read_boot_params
> since some models depend on that to contruct the fw filename. Also attempt to
> cleanup duplicated code.
> v4: Fix forwarding -EALREADY when firmware has already been loaded.
> 
>  drivers/bluetooth/btintel.c   | 96 +++++++++++++++++++++++++++--------
>  drivers/bluetooth/btintel.h   |  5 +-
>  drivers/bluetooth/btusb.c     | 18 ++++++-
>  drivers/bluetooth/hci_intel.c |  7 ++-
>  4 files changed, 100 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 88ce5f0ffc4b..89f85d54ca64 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -24,6 +24,14 @@
>  #define ECDSA_OFFSET		644
>  #define ECDSA_HEADER_LEN	320
>  
> +#define CMD_WRITE_BOOT_PARAMS	0xfc0e
> +struct cmd_write_boot_params {
> +	u32 boot_addr;
> +	u8  fw_build_num;
> +	u8  fw_build_ww;
> +	u8  fw_build_yy;
> +} __packed;
> +
>  int btintel_check_bdaddr(struct hci_dev *hdev)
>  {
>  	struct hci_rp_read_bd_addr *bda;
> @@ -841,7 +849,7 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
>  
>  static int btintel_download_firmware_payload(struct hci_dev *hdev,
>  					     const struct firmware *fw,
> -					     u32 *boot_param, size_t offset)
> +					     size_t offset)
>  {
>  	int err;
>  	const u8 *fw_ptr;
> @@ -854,20 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
>  	while (fw_ptr - fw->data < fw->size) {
>  		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
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
>  		frag_len += sizeof(*cmd) + cmd->plen;
>  
>  		/* The parameter length of the secure send command requires
> @@ -896,28 +890,92 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
>  	return err;
>  }
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

Looping with all constant value may causes an buffer overflow if the file
doesn't have "CMD_WRITE_BOOT_PARAMS" for some reason.

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

The params doesn't point the right value since the fw_ptr never updates in the loop.
This might cause reloading the firmware even if fw version is same since it alwasy return false.

> +
> +			bt_dev_info(hdev, "Boot Address: 0x%x",
> +				   le32_to_cpu(params->boot_addr));
> +
> +			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
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
>  int btintel_download_firmware(struct hci_dev *hdev,
> +			      struct intel_version *ver,
>  			      const struct firmware *fw,
>  			      u32 *boot_param)
>  {
>  	int err;
>  
> +	/* Skip download if firmware has the same version */
> +	if (btintel_firmware_version(hdev, ver->fw_build_num, ver->fw_build_ww,
> +				     ver->fw_build_yy, fw, boot_param)) {
> +		bt_dev_info(hdev, "Firmware already loaded");
> +		/* Return -EALREADY to indicate that the firmware has already
> +		 * been loaded.
> +		 */
> +		return -EALREADY;
> +	}
> +
>  	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
>  	if (err)
>  		return err;
>  
> -	return btintel_download_firmware_payload(hdev, fw, boot_param,
> -						 RSA_HEADER_LEN);
> +	return btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
>  }
>  EXPORT_SYMBOL_GPL(btintel_download_firmware);
>  
>  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +				     struct intel_version_tlv *ver,
>  				     const struct firmware *fw, u32 *boot_param,
>  				     u8 hw_variant, u8 sbe_type)
>  {
>  	int err;
>  	u32 css_header_ver;
>  
> +	/* Skip download if firmware has the same version */
> +	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> +				     ver->min_fw_build_cw, ver->min_fw_build_yy,
> +				     fw, boot_param)) {
> +		bt_dev_info(hdev, "Firmware already loaded");
> +		/* Return -EALREADY to indicate that firmware has already been
> +		 * loaded.
> +		 */
> +		return -EALREADY;
> +	}
> +
>  	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
>  	 * only RSA secure boot engine. Hence, the corresponding sfi file will
>  	 * have RSA header of 644 bytes followed by Command Buffer.
> @@ -947,7 +1005,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  		if (err)
>  			return err;
>  
> -		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> +		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
>  		if (err)
>  			return err;
>  	} else if (hw_variant >= 0x17) {
> @@ -968,7 +1026,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  				return err;
>  
>  			err = btintel_download_firmware_payload(hdev, fw,
> -								boot_param,
>  								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
>  			if (err)
>  				return err;
> @@ -978,7 +1035,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  				return err;
>  
>  			err = btintel_download_firmware_payload(hdev, fw,
> -								boot_param,
>  								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
>  			if (err)
>  				return err;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 6511b091caf5..51f1f2c883b4 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -163,9 +163,10 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
>  int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
>  int btintel_read_boot_params(struct hci_dev *hdev,
>  			     struct intel_boot_params *params);
> -int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
> -			      u32 *boot_param);
> +int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> +			      const struct firmware *fw, u32 *boot_param);
>  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +				     struct intel_version_tlv *ver,
>  				     const struct firmware *fw,
>  				     u32 *boot_param, u8 hw_variant,
>  				     u8 sbe_type);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 66ada8217797..c92060e7472c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2623,10 +2623,17 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
>  	set_bit(BTUSB_DOWNLOADING, &data->flags);
>  
>  	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
> +	err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
>  					       INTEL_HW_VARIANT(ver->cnvi_bt),
>  					       ver->sbe_type);
>  	if (err < 0) {
> +		if (err == -EALREADY) {
> +			/* Firmware has already been loaded */
> +			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> +			err = 0;
> +			goto done;
> +		}
> +
>  		/* When FW download fails, send Intel Reset to retry
>  		 * FW download.
>  		 */
> @@ -2817,8 +2824,15 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>  	set_bit(BTUSB_DOWNLOADING, &data->flags);
>  
>  	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware(hdev, fw, boot_param);
> +	err = btintel_download_firmware(hdev, ver, fw, boot_param);
>  	if (err < 0) {
> +		if (err == -EALREADY) {
> +			/* Firmware has already been loaded */
> +			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> +			err = 0;
> +			goto done;
> +		}
> +
>  		/* When FW download fails, send Intel Reset to retry
>  		 * FW download.
>  		 */
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index b20a40fab83e..7249b91d9b91 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -735,7 +735,7 @@ static int intel_setup(struct hci_uart *hu)
>  	set_bit(STATE_DOWNLOADING, &intel->flags);
>  
>  	/* Start firmware downloading and get boot parameter */
> -	err = btintel_download_firmware(hdev, fw, &boot_param);
> +	err = btintel_download_firmware(hdev, &ver, fw, &boot_param);
>  	if (err < 0)
>  		goto done;
>  
> @@ -784,7 +784,10 @@ static int intel_setup(struct hci_uart *hu)
>  done:
>  	release_firmware(fw);
>  
> -	if (err < 0)
> +	/* Check if there was an error and if is not -EALREADY which means the
> +	 * firmware has already been loaded.
> +	 */
> +	if (err < 0 && err != -EALREADY)
>  		return err;
>  
>  	/* We need to restore the default speed before Intel reset */

