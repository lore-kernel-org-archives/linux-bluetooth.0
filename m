Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A7C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D682120756
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKKLCr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:02:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55612 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKLCr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 06:02:47 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id E64CCCECFD;
        Wed, 11 Nov 2020 12:09:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v7 2/4] Bluetooth: btusb: Define a function to construct
 firmware filename
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1602678517-9912-2-git-send-email-kiran.k@intel.com>
Date:   Wed, 11 Nov 2020 12:02:45 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <10C24267-486C-40F1-8328-2FAD3FD71C5A@holtmann.org>
References: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
 <1602678517-9912-2-git-send-email-kiran.k@intel.com>
To:     Kiran K <kiraank@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Define a new function to construct firmware/ddc filename for new
> generation Intel controllers
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btintel.h |  6 ++++++
> drivers/bluetooth/btusb.c   | 19 +++++++++++++++++--
> 2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 09346ae..c4e28a8 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -132,6 +132,12 @@ struct intel_debug_features {
> 	__u8    page1[16];
> } __packed;
> 
> +#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
> +#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
> +#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
> +#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
> +#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
> +

how is the endian safe?

> #if IS_ENABLED(CONFIG_BT_INTEL)
> 
> int btintel_check_bdaddr(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2e40885..ac532dd 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2360,6 +2360,21 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> 	return true;
> }
> 
> +static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
> +						 char *fw_name, size_t len,
> +						 const char *suffix)
> +{
> +	/* The firmware file name for new generation controllers will be
> +	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
> +	 */
> +	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> +		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
> +					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
> +		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
> +					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
> +		 suffix);
> +}
> +
> static int btusb_intel_download_firmware(struct hci_dev *hdev,
> 					 struct intel_version *ver,
> 					 struct intel_boot_params *params,
> @@ -2783,8 +2798,8 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> 
> 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> 
> -	/* TODO: Insert function call here to get the ddc file name */
> -
> +	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
> +					     "ddc");
> 	/* Once the device is running in operational mode, it needs to
> 	 * apply the device configuration (DDC) parameters.

Regards

Marcel

