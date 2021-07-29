Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5333C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F10B6044F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhG2TVQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:21:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59178 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2TVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:21:15 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 44961CED1F;
        Thu, 29 Jul 2021 21:21:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 02/11] Bluetooth: btintel: Add combined setup and
 shutdown functions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-3-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:21:10 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <62EE712F-7876-4820-871B-404B6EA01B72@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-3-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> There are multiple setup and shutdown functions for Intel device and the
> setup function to use is depends on the USB PID/VID, which makes
> difficult to maintain the code and increases the code size.
> 
> This patch adds combined setup and shutdown functions to provide a
> single entry point for all Intel devices and choose the setup functions
> based on the information read with HCI_Intel_Read_Version command.
> 
> Starting from TyP device, for HCI_Intel_Read_Version command, the
> command parameter and response are changed even though OCF remains
> same. Luckly the legacy devices still can handle the command without
> error even if it has a extra parameter, so it uses the new command
> format to support both legacy and new (tlv based) format.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 196 ++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h |  12 +++
> 2 files changed, 208 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e44b6993cf91..a23304435814 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -236,6 +236,8 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
> 	 * compatibility options when newer hardware variants come along.
> 	 */
> 	switch (ver->hw_variant) {
> +	case 0x07:	/* WP - Legacy ROM */
> +	case 0x08:	/* StP - Legacy ROM */
> 	case 0x0b:      /* SfP */
> 	case 0x0c:      /* WsP */
> 	case 0x11:      /* JfP */
> @@ -250,9 +252,15 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
> 	}
> 
> 	switch (ver->fw_variant) {
> +	case 0x01:
> +		variant = "Legacy ROM 2.5";
> +		break;
> 	case 0x06:
> 		variant = "Bootloader";
> 		break;
> +	case 0x22:
> +		variant = "Legacy ROM 2.x";
> +		break;
> 	case 0x23:
> 		variant = "Firmware";
> 		break;
> @@ -483,6 +491,98 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
> }
> EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> 
> +static int btintel_parse_version_tlv(struct hci_dev *hdev,
> +				     struct intel_version_tlv *version,
> +				     struct sk_buff *skb)
> +{
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	/* Event parameters contatin multiple TLVs. Read each of them
> +	 * and only keep the required data. Also, it use existing legacy
> +	 * version field like hw_platform, hw_variant, and fw_variant
> +	 * to keep the existing setup flow
> +	 */
> +	while (skb->len) {
> +		struct intel_tlv *tlv;
> +
> +		tlv = (struct intel_tlv *)skb->data;
> +		switch (tlv->type) {
> +		case INTEL_TLV_CNVI_TOP:
> +			version->cnvi_top = get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVR_TOP:
> +			version->cnvr_top = get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVI_BT:
> +			version->cnvi_bt = get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVR_BT:
> +			version->cnvr_bt = get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_DEV_REV_ID:
> +			version->dev_rev_id = get_unaligned_le16(tlv->val);
> +			break;
> +		case INTEL_TLV_IMAGE_TYPE:
> +			version->img_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_TIME_STAMP:
> +			/* If image type is Operational firmware (0x03), then
> +			 * running FW Calendar Week and Year information can
> +			 * be extracted from Timestamp information
> +			 */
> +			version->min_fw_build_cw = tlv->val[0];
> +			version->min_fw_build_yy = tlv->val[1];
> +			version->timestamp = get_unaligned_le16(tlv->val);
> +			break;
> +		case INTEL_TLV_BUILD_TYPE:
> +			version->build_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_BUILD_NUM:
> +			/* If image type is Operational firmware (0x03), then
> +			 * running FW build number can be extracted from the
> +			 * Build information
> +			 */
> +			version->min_fw_build_nn = tlv->val[0];
> +			version->build_num = get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_SECURE_BOOT:
> +			version->secure_boot = tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_LOCK:
> +			version->otp_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_API_LOCK:
> +			version->api_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_DEBUG_LOCK:
> +			version->debug_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_MIN_FW:
> +			version->min_fw_build_nn = tlv->val[0];
> +			version->min_fw_build_cw = tlv->val[1];
> +			version->min_fw_build_yy = tlv->val[2];
> +			break;
> +		case INTEL_TLV_LIMITED_CCE:
> +			version->limited_cce = tlv->val[0];
> +			break;
> +		case INTEL_TLV_SBE_TYPE:
> +			version->sbe_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_BDADDR:
> +			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
> +			break;
> +		default:
> +			/* Ignore rest of information */
> +			break;
> +		}
> +		/* consume the current tlv and move to next*/
> +		skb_pull(skb, tlv->len + sizeof(*tlv));
> +	}
> +
> +	return 0;
> +}
> +
> int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
> {
> 	struct sk_buff *skb;
> @@ -1272,6 +1372,102 @@ int btintel_set_debug_features(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> 
> +int btintel_setup_combined(struct hci_dev *hdev)
> +{
> +	const u8 param[1] = { 0xFF };
> +	struct intel_version ver;
> +	struct intel_version_tlv ver_tlv;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/* Starting from TyP device, the command parameter and response are
> +	 * changed even though the OCF for HCI_Intel_Read_Version command
> +	 * remains same. The legacy devices can handle even if the
> +	 * command has a parameter and returns a correct version information.
> +	 * So, it uses new format to support both legacy and new format.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	/* Check the status */
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* For Legacy device, check the HW platform value and size */
> +	if (skb->data[1] == 0x37 && skb->len == sizeof(ver)) {

while the command status is guaranteed, everything after that is not. So you might want to do the length check first. And then look for 0x37.

> +		bt_dev_dbg(hdev, "Read the legacy Intel version information");
> +
> +		memcpy(&ver, skb->data, sizeof(ver));
> +
> +		/* Display version information */
> +		btintel_version_info(hdev, &ver);
> +
> +		/* Identify the device type based on the read version */

Initially I added some comments on that we filter on hw_variant on purpose to enable forward compatibility. It would be good to keep having such a statement.

> +		switch (ver.hw_variant) {
> +		case 0x07:	/* WP */
> +		case 0x08:	/* StP */
> +			/* Legacy ROM product */
> +			/* TODO: call setup routine for legacy rom product */
> +			break;
> +		case 0x0b:      /* SfP */
> +		case 0x0c:      /* WsP */
> +		case 0x11:      /* JfP */
> +		case 0x12:      /* ThP */
> +		case 0x13:      /* HrP */
> +		case 0x14:      /* CcP */
> +			/* TODO: call setup routine for bootloader product */
> +			break;
> +		default:
> +			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
> +				   ver.hw_variant);
> +			return -EINVAL;
> +		}
> +
> +		return err;
> +	}
> +

Now this eliminates the hard limit to a given hw_platform like we had before.

So I think you really need to be careful to not assume it is a TLV based system. We need to have some extra checks here before we continue into the TLV world.

> +	/* For TLV type device, parse the tlv data */
> +	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
> +
> +	/* Display version information of TLV type */
> +	btintel_version_info_tlv(hdev, &ver_tlv);
> +
> +	/* TODO: Need to filter the device for new generation */
> +	/* TODO: call setup routine for tlv based bootloader product */
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btintel_setup_combined);
> +
> +int btintel_shutdown_combined(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +
> +	/* Send HCI Reset to the controller to stop any BT activity which
> +	 * were triggered. This will help to save power and maintain the
> +	 * sync b/w Host and controller
> +	 */
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "HCI reset during shutdown failed");
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
> +
> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index d184064a5e7c..68ffa84fa87a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -165,6 +165,8 @@ int btintel_read_boot_params(struct hci_dev *hdev,
> 			     struct intel_boot_params *params);
> int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> 			      const struct firmware *fw, u32 *boot_param);
> +int btintel_setup_combined(struct hci_dev *hdev);
> +int btintel_shutdown_combined(struct hci_dev *hdev);
> int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 				     struct intel_version_tlv *ver,
> 				     const struct firmware *fw,
> @@ -283,6 +285,16 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
> 	return -EOPNOTSUPP;
> }
> 
> +static inline int btintel_setup_combined(struct hci_dev *hdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int btintel_shutdown_combined(struct hci_dev *hdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
> 						   const struct firmware *fw,
> 						   u32 *boot_param,

Regards

Marcel

