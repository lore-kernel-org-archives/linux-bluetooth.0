Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EAB20738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMTSO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:18:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35879 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGMTSO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 15:18:14 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1791CCECCE;
        Mon, 13 Jul 2020 21:28:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/5] Bluetooth: btintel: Define tlv structure for new
 generation Controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200703071212.17046-4-kiran.k@intel.com>
Date:   Mon, 13 Jul 2020 21:18:11 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <06420AF3-C3AE-44A3-95DC-0A99BE845FC5@holtmann.org>
References: <20200703071212.17046-1-kiran.k@intel.com>
 <20200703071212.17046-4-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Define structure used for reading controller information and
> to downloading firmware in tlv format used for new generation
> Intel controllers
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> 
> Changes in v2: None
> Changes in v1:
> - Add tlv structure definition
> 
> 
> drivers/bluetooth/btintel.h | 85 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 0865d2d4aca7..20007da6b9bd 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -6,6 +6,90 @@
>  *  Copyright (C) 2015  Intel Corporation
>  */
> 
> +/* List of tlv type */
> +enum {
> +	INTEL_TLV_CNVI_TOP = 0x10,
> +	INTEL_TLV_CNVR_TOP,
> +	INTEL_TLV_CNVI_BT,
> +	INTEL_TLV_CNVR_BT,
> +	INTEL_TLV_CNVI_OTP,
> +	INTEL_TLV_CNVR_OTP,
> +	INTEL_TLV_DEV_REV_ID,
> +	INTEL_TLV_USB_VENDOR_ID,
> +	INTEL_TLV_USB_PRODUCT_ID,
> +	INTEL_TLV_PCIE_VENDOR_ID,
> +	INTEL_TLV_PCIE_DEVICE_ID,
> +	INTEL_TLV_PCIE_SUBSYSTEM_ID,
> +	INTEL_TLV_IMAGE_TYPE,
> +	INTEL_TLV_TIME_STAMP,
> +	INTEL_TLV_BUILD_TYPE,
> +	INTEL_TLV_BUILD_NUM,
> +	INTEL_TLV_FW_BUILD_PRODUCT,
> +	INTEL_TLV_FW_BUILD_HW,
> +	INTEL_TLV_FW_STEP,
> +	INTEL_TLV_BT_SPEC,
> +	INTEL_TLV_MFG_NAME,
> +	INTEL_TLV_HCI_REV,
> +	INTEL_TLV_LMP_SUBVER,
> +	INTEL_TLV_OTP_PATCH_VER,
> +	INTEL_TLV_SECURE_BOOT,
> +	INTEL_TLV_KEY_FROM_HDR,
> +	INTEL_TLV_OTP_LOCK,
> +	INTEL_TLV_API_LOCK,
> +	INTEL_TLV_DEBUG_LOCK,
> +	INTEL_TLV_MIN_FW,
> +	INTEL_TLV_LIMITED_CCE,
> +	INTEL_TLV_SBE_TYPE,
> +	INTEL_TLV_OTP_BDADDR,
> +	INTEL_TLV_UNLOCKED_STATE
> +};
> +
> +struct intel_tlv {
> +	u8 type;
> +	u8 len;
> +	u8 val[0];
> +} __packed;
> +
> +struct intel_version_tlv {
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

This is not required to be __packed. It is not a on-wire structure. In addition, I would just only include the data fields we currently require or want to show in dmesg.

Regards

Marcel

