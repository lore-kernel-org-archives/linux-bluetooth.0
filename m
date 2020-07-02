Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A452088E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgGBNeR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:34:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33689 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgGBNeR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 09:34:17 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 15313CED14;
        Thu,  2 Jul 2020 15:44:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 5/5] Bluetooth: btintel: Parse controller information
 present in TLV format
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200702120315.26768-6-kiran.k@intel.com>
Date:   Thu, 2 Jul 2020 15:34:14 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        chethan.tumkur.narayan@intel.com, kiraank@gmail.com,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0CCCE1DA-3700-4B8C-A75B-D98D07F51782@holtmann.org>
References: <20200702120315.26768-1-kiran.k@intel.com>
 <20200702120315.26768-6-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> New generation Intel controllers returns controller information
> in TLV format. Adding capability to parse and log it for debug purpose
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> drivers/bluetooth/btintel.c | 161 ++++++++++++++++++++++++++++++++----
> drivers/bluetooth/btusb.c   |   4 +-
> 2 files changed, 148 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d0c6576212d7..f0b087d97a83 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -209,27 +209,59 @@ void btintel_version_info(struct hci_dev *hdev, const struct btintel_version *ve
> {
> 	const char *variant;
> 	const struct intel_version *ver;
> +	const struct intel_version_tlv *ver_tlv;
> 
> -	if (version->is_tlv_supported)
> -		return;
> +	if (!version->is_tlv_supported) {
> +		ver = &version->intel_version;
> +
> +		switch (ver->fw_variant) {
> +		case 0x06:
> +			variant = "Bootloader";
> +		break;

The break; has to be indented with the variant =.

> +		case 0x23:
> +			variant = "Firmware";
> +		break;
> +		default:
> +			goto done;
> +		}
> 
> -	ver = &version->intel_version;
> +		bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
> +			    variant, ver->fw_revision >> 4,
> +			    ver->fw_revision & 0x0f, ver->fw_build_num,
> +			    ver->fw_build_ww, 2000 + ver->fw_build_yy);
> +		goto done;
> +	}
> +
> +	ver_tlv = &version->intel_version_tlv;
> 
> -	switch (ver->fw_variant) {
> -	case 0x06:
> +	switch (ver_tlv->img_type) {
> +	case 0x01:
> 		variant = "Bootloader";
> -		break;
> -	case 0x23:
> +		bt_dev_info(hdev, "Device revision is %u", ver_tlv->dev_rev_id);
> +		bt_dev_info(hdev, "Secure boot is %s",
> +			    ver_tlv->secure_boot ? "enabled" : "disabled");
> +		bt_dev_info(hdev, "OTP lock is %s",
> +			    ver_tlv->otp_lock ? "enabled" : "disabled");
> +		bt_dev_info(hdev, "API lock is %s",
> +			    ver_tlv->api_lock ? "enabled" : "disabled");
> +		bt_dev_info(hdev, "Debug lock is %s",
> +			    ver_tlv->debug_lock ? "enabled" : "disabled");
> +		bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
> +			    ver_tlv->min_fw_build_nn, ver_tlv->min_fw_build_cw,
> +			    2000 + ver_tlv->min_fw_build_yy);
> +	break;
> +	case 0x03:
> 		variant = "Firmware";
> -		break;
> +	break;
> 	default:
> -		return;
> +		goto done;
> 	}
> 
> -	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
> -		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
> -		    ver->fw_build_num, ver->fw_build_ww,
> -		    2000 + ver->fw_build_yy);
> +	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
> +		    2000 + (ver_tlv->timestamp >> 8), ver_tlv->timestamp & 0xff,
> +		    ver_tlv->build_type, ver_tlv->build_num);
> +done:
> +	return;
> }
> EXPORT_SYMBOL_GPL(btintel_version_info);
> 
> @@ -346,6 +378,8 @@ int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version)
> {
> 	struct sk_buff *skb;
> 	u8 *data, param, status, check_tlv;
> +	struct intel_version_tlv *ver_tlv;
> +	struct intel_tlv *tlv;
> 
> 	if (!version)
> 		return -EINVAL;
> @@ -373,9 +407,106 @@ int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version)
> 	if (skb->len == sizeof(version->intel_version) && check_tlv == 0x37) {
> 		memcpy(&version->intel_version, skb->data, sizeof(version->intel_version));
> 		version->is_tlv_supported = false;
> -	} else {
> -		version->is_tlv_supported = true;
> +		goto done;
> 	}
> +
> +	bt_dev_info(hdev, "Supports tlv firmware download sequence");
> +	version->is_tlv_supported = true;
> +	ver_tlv = &version->intel_version_tlv;
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	/* Event parameters contatin multiple TLVs. Read each of them
> +	 * and only keep the required data. Also, it use existing legacy
> +	 * version field like hw_platform, hw_variant, and fw_variant
> +	 * to keep the existing setup flow
> +	 */
> +	while (skb->len) {
> +		tlv = (struct intel_tlv *)skb->data;
> +		switch (tlv->type) {
> +		case INTEL_TLV_CNVI_TOP:
> +			ver_tlv->cnvi_top = (tlv->val[3] << 24) |
> +				(tlv->val[2] << 16) |
> +				(tlv->val[1] << 8) |
> +				(tlv->val[0]);

We have get_unaligned functions for that.

> +			break;
> +		case INTEL_TLV_CNVR_TOP:
> +			ver_tlv->cnvr_top = (tlv->val[3] << 24) |
> +				(tlv->val[2] << 16) |
> +				(tlv->val[1] << 8) |
> +				(tlv->val[0]);
> +			break;
> +		case INTEL_TLV_CNVI_BT:
> +			ver_tlv->cnvi_bt = (tlv->val[3] << 24) |
> +				(tlv->val[2] << 16) |
> +				(tlv->val[1] << 8) |
> +				(tlv->val[0]);
> +			break;
> +		case INTEL_TLV_CNVR_BT:
> +			ver_tlv->cnvr_bt = (tlv->val[3] << 24) |
> +				(tlv->val[2] << 16) |
> +				(tlv->val[1] << 8) |
> +				(tlv->val[0]);
> +			break;
> +		case INTEL_TLV_USB_VENDOR_ID:
> +			ver_tlv->usb_vid = (tlv->val[1] << 8) | (tlv->val[0]);
> +			break;
> +		case INTEL_TLV_USB_PRODUCT_ID:
> +			ver_tlv->usb_pid = (tlv->val[1] << 8) | (tlv->val[0]);
> +			break;
> +		case INTEL_TLV_IMAGE_TYPE:
> +			ver_tlv->img_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_TIME_STAMP:
> +			ver_tlv->timestamp = (tlv->val[1] << 8) | (tlv->val[0]);
> +			break;
> +		case INTEL_TLV_BUILD_TYPE:
> +			ver_tlv->build_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_BUILD_NUM:
> +			ver_tlv->build_num = (tlv->val[3] << 24) |
> +				(tlv->val[2] << 16) |
> +				(tlv->val[1] << 8) |
> +				(tlv->val[0]);
> +			break;
> +		case INTEL_TLV_SECURE_BOOT:
> +			ver_tlv->secure_boot = tlv->val[0];
> +			break;
> +		case INTEL_TLV_KEY_FROM_HDR:
> +			ver_tlv->key_from_hdr = tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_LOCK:
> +			ver_tlv->otp_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_API_LOCK:
> +			ver_tlv->api_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_DEBUG_LOCK:
> +			ver_tlv->debug_lock = tlv->val[0];
> +			break;
> +		case INTEL_TLV_MIN_FW:
> +			ver_tlv->min_fw_build_nn = tlv->val[0];
> +			ver_tlv->min_fw_build_cw = tlv->val[1];
> +			ver_tlv->min_fw_build_yy = tlv->val[2];
> +			break;
> +		case INTEL_TLV_LIMITED_CCE:
> +			ver_tlv->limited_cce = tlv->val[0];
> +			break;
> +		case INTEL_TLV_SBE_TYPE:
> +			ver_tlv->sbe_type = tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_BDADDR:
> +			memcpy(&ver_tlv->otp_bd_addr, tlv->val, tlv->len);
> +			break;
> +		default:
> +			/* Ignore rest of information */
> +			break;
> +		}
> +		/* consume the current tlv and move to next*/
> +		skb_pull(skb, tlv->len + sizeof(*tlv));
> +	}
> +done:
> 	kfree_skb(skb);
> 	return 0;
> }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 364da6d44ee3..f30b43e15a26 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2519,13 +2519,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 		return err;
> 	}
> 
> +	btintel_version_info(hdev, &version);
> +
> 	if (version.is_tlv_supported) {
> 		bt_dev_err(hdev, "Firmware download in tlv format is not supported");
> 		return -EOPNOTSUPP;
> 	}
> 
> -	btintel_version_info(hdev, &version);
> -
> 	err = btusb_intel_download_firmware(hdev, &version, &params);
> 	if (err)
> 		return err;

Regards

Marcel

