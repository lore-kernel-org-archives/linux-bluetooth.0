Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88000C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D94C20757
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgJ2Idu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:33:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:52842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgJ2Idj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 04:33:39 -0400
IronPort-SDR: M5B9+Fq/J4g2akk91kP2j4KltpBdkczRzfE7EujcY0mwd9mNLlh+kvOZ4FRBhbTeU0oo8n0+AB
 n7hN3VHtTVVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164883117"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="164883117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 22:28:10 -0700
IronPort-SDR: i5Jp1GUQmhvyM5LR2bHnmt0DpTlKqJdzd9+eW5EZxY4ewmyLQv5vxJOqE4wAY2P11CUBnKBYmf
 LmsCwFLbSf4w==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="323593911"
Received: from jbottles-mobl.amr.corp.intel.com (HELO linux.intel.com) ([10.254.103.214])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 22:28:10 -0700
Date:   Wed, 28 Oct 2020 22:28:08 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: Re: [PATCH 2/3] Bluetooth: btintel: Introducing new btintel read
 version
Message-ID: <20201029052808.GB3990@linux.intel.com>
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
 <20201022082435.31831-3-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022082435.31831-3-sathish.narasimman@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On 2020-10-22 at 13:54:34 +0530, Sathish Narasimman wrote:
> The new btintel read version supports the latest intel read version
> command and also supports the TLV structure parsing. It still
> handles the legacy read version
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 51 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h | 15 +++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index cc8e6c4e3205..ddd3c4bbdd6f 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -476,6 +476,57 @@ static void btintel_parse_tlv(struct sk_buff *skb,
>  	}
>  }
>  
> +int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver)
> +{
> +	struct sk_buff *skb;
> +	struct intel_version *version = &ver->ver;
> +	const u8 param[1] = { 0xFF };
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* The new Intel read version is backward compatible for Thp and CcP
> +	 * type cards. when the controller is in bootloader mode the controller
> +	 * response remains same as old intel_read version. For ThP/CcP cards
> +	 * TLV stucture supports only during the Operation Mode. The best way

misspelled structure

> +	 * to differentiate the read_version response is to check the length
> +	 * parameter and first byte of the payload, which is a fixed value.
> +	 * After the status parameter if the payload starts with 0x37(This is
> +	 * a fixed value) and length of the payload is 10 then it is identified
> +	 * as legacy struct intel_version. In the latest firmweare the support
> +	 * of TLV structure is added during Operational Firmware.
> +	 */
> +	if (skb->len == sizeof(*version) && skb->data[1] == 0x37) {
> +		memcpy(version, skb->data, sizeof(*version));
> +		ver->tlv_format = false;
> +		goto finish;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	ver->tlv_format = true;
> +
> +	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
> +	btintel_parse_tlv(skb, &ver->ver_tlv);
> +
> +finish:
> +	kfree_skb(skb);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_read_version_new);
> +
>  int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
>  {
>  	struct sk_buff *skb;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 09346ae308eb..08406ef935a3 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -132,6 +132,14 @@ struct intel_debug_features {
>  	__u8    page1[16];
>  } __packed;
>  
> +struct btintel_version {
> +	bool tlv_format;
> +	union {
> +		struct intel_version ver; /*Legacy Intel read version*/
> +		struct intel_version_tlv ver_tlv;
> +	};
> +};

Add __packed;

> +
>  #if IS_ENABLED(CONFIG_BT_INTEL)
>  
>  int btintel_check_bdaddr(struct hci_dev *hdev);
> @@ -151,6 +159,7 @@ int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
>  int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
>  int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
>  int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver);
> +int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver);
>  
>  struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
>  				   u16 opcode_write);
> @@ -248,6 +257,12 @@ static inline int btintel_read_version_tlv(struct hci_dev *hdev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int btintel_read_version_new(struct hci_dev *hdev,
> +					   struct btintel_version *ver)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
>  						 u16 opcode_read,
>  						 u16 opcode_write)
> -- 
> 2.17.1
> 

I think you can combine your 3 patches into one patch.

Regards,

Tedd
