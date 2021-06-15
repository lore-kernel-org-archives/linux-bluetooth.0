Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51683C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3455A61351
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFOTcY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:32:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45339 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOTcX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:32:23 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 04573CECFB;
        Tue, 15 Jun 2021 21:38:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v9 04/10] Bluetooth: btintel: set get_data_path callback
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210608122455.19583-4-kiran.k@intel.com>
Date:   Tue, 15 Jun 2021 21:30:17 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DDBF23B0-10C2-4B4F-8296-8454CD8F7AA6@holtmann.org>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-4-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Read supported offload usecases and set get_data_path callback if
> controller suppports offload codecs.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h | 18 ++++++++++++++++++
> drivers/bluetooth/btusb.c   |  8 ++++++++
> 3 files changed, 62 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e44b6993cf91..95c6a1bef35e 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1272,6 +1272,42 @@ int btintel_set_debug_features(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> 
> +int btintel_get_data_path(struct hci_dev *hdev)
> +{
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(btintel_get_data_path);
> +
> +int btintel_read_offload_usecases(struct hci_dev *hdev,
> +				  struct intel_offload_usecases *usecases)
> +{
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading offload usecases failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len < sizeof(*usecases)) {
> +		err = -EIO;
> +		goto error;
> +	}
> +
> +	if (skb->data[0]) {
> +		err = -bt_to_errno(skb->data[0]);
> +		goto error;
> +	}
> +
> +	memcpy(usecases, skb->data, sizeof(*usecases));
> +error:
> +	kfree_skb(skb);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
> +
> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index d184064a5e7c..9bcc489680db 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -132,6 +132,11 @@ struct intel_debug_features {
> 	__u8    page1[16];
> } __packed;
> 
> +struct intel_offload_usecases {
> +	__u8	status;
> +	__u8	preset[8];
> +} __packed;
> +
> #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
> #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
> #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
> @@ -175,6 +180,9 @@ int btintel_read_debug_features(struct hci_dev *hdev,
> 				struct intel_debug_features *features);
> int btintel_set_debug_features(struct hci_dev *hdev,
> 			       const struct intel_debug_features *features);
> +int btintel_read_offload_usecases(struct hci_dev *hdev,
> +				  struct intel_offload_usecases *usecases);
> +int btintel_get_data_path(struct hci_dev *hdev);
> #else
> 
> static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -307,4 +315,14 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
> 	return -EOPNOTSUPP;
> }
> 
> +static int btintel_read_offload_usecases(struct hci_dev *hdev,
> +					 struct intel_offload_usecases *usecases)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int btintel_get_data_path(struct hci_dev *hdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd561..1e51beec5776 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2952,6 +2952,7 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> 	int err;
> 	struct intel_debug_features features;
> 	struct intel_version_tlv version;
> +	struct intel_offload_usecases usecases;
> 
> 	bt_dev_dbg(hdev, "");
> 
> @@ -3008,6 +3009,13 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> 	/* Set DDC mask for available debug features */
> 	btintel_set_debug_features(hdev, &features);
> 
> +	err = btintel_read_offload_usecases(hdev, &usecases);
> +	if (!err) {
> +		/* set get_data_path callback if offload is supported */
> +		if (usecases.preset[0] & 0x03)
> +			hdev->get_data_path = btintel_get_data_path;
> +	}
> +

I really wonder if this exporting everything single detail to be just used by btusb is really a good idea. Would it be just enough to have a btintel_configure_offload(hdev); helper that does everything and be done with it. There is already too much Intel specifics bleeding into btusb.c and I think we need to correct that going forward.

Regards

Marcel

