Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50701C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2342E613C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347752AbhDMStW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:49:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40776 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347747AbhDMStW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 14:49:22 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id A2801CECCC;
        Tue, 13 Apr 2021 20:56:44 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: support link statistics
 telemetry events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210413101812.323079-1-josephsih@chromium.org>
Date:   Tue, 13 Apr 2021 20:48:59 +0200
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        josephsih@google.com,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2D46F127-6669-4394-B3D5-1677D4BF72EE@holtmann.org>
References: <20210413101812.323079-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch supports the link statistics telemetry events for
> Intel controllers
> 
> To avoid the overhead, this debug feature is disabled by default.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - fix the long line in the commit message
> 
> Changes in v2:
> - take care of intel_newgen as well as intel_new
> - fix the long lines in mgmt.c
> 
> drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
> drivers/bluetooth/btusb.c   | 18 ------------------
> 2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e44b6993cf91..de1dbdc01e5a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
> int btintel_set_debug_features(struct hci_dev *hdev,
> 			       const struct intel_debug_features *features)
> {
> -	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
> +	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
> 			0x00, 0x00, 0x00 };
> +	u8 period[5] = { 0x04, 0x91, 0x02, 0x01, 0x00 };
> +	u8 trace_enable = 0x02;
> 	struct sk_buff *skb;
> 
> 	if (!features)
> @@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
> 			   PTR_ERR(skb));
> 		return PTR_ERR(skb);
> 	}
> +	kfree_skb(skb);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> 
> +	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> 	kfree_skb(skb);
> +
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 192cb8c191bc..f29946f15f59 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2811,7 +2811,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	u32 boot_param;
> 	char ddcname[64];
> 	int err;
> -	struct intel_debug_features features;
> 
> 	BT_DBG("%s", hdev->name);
> 
> @@ -2865,14 +2864,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 		btintel_load_ddc_config(hdev, ddcname);
> 	}
> 
> -	/* Read the Intel supported features and if new exception formats
> -	 * supported, need to load the additional DDC config to enable.
> -	 */
> -	btintel_read_debug_features(hdev, &features);
> -
> -	/* Set DDC mask for available debug features */
> -	btintel_set_debug_features(hdev, &features);
> -
> 	/* Read the Intel version information after loading the FW  */
> 	err = btintel_read_version(hdev, &ver);
> 	if (err)
> @@ -2911,7 +2902,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> 	u32 boot_param;
> 	char ddcname[64];
> 	int err;
> -	struct intel_debug_features features;
> 	struct intel_version_tlv version;
> 
> 	bt_dev_dbg(hdev, "");
> @@ -2961,14 +2951,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> 	 */
> 	btintel_load_ddc_config(hdev, ddcname);
> 
> -	/* Read the Intel supported features and if new exception formats
> -	 * supported, need to load the additional DDC config to enable.
> -	 */
> -	btintel_read_debug_features(hdev, &features);
> -
> -	/* Set DDC mask for available debug features */
> -	btintel_set_debug_features(hdev, &features);
> -
> 	/* Read the Intel version information after loading the FW  */
> 	err = btintel_read_version_tlv(hdev, &version);
> 	if (err)

so I don’t like this kind of removing and adding things at the same time. Please separate these patches properly.

Regards

Marcel

