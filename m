Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00736C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED4C2053B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFCRmX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:42:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48206 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCRmX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:42:23 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1E3C1CED2C;
        Wed,  3 Jun 2020 19:52:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Add support to Intel read supported
 feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200603101523.12547-1-kiran.k@intel.com>
Date:   Wed, 3 Jun 2020 19:42:20 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Ps@vger.kernel.org, AyappadasX <AyappadasX.Ps@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E929E0E0-E28A-4874-B168-A5E03C40F1F8@holtmann.org>
References: <20200603101523.12547-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> The command shall read the Intel controller supported
> feature. Based on the supported features addtional debug
> configuration shall be enabled.
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Ps, AyappadasX <AyappadasX.Ps@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> drivers/bluetooth/btintel.c | 34 ++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h | 14 ++++++++++++++
> drivers/bluetooth/btusb.c   |  8 +++++++-
> 3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 6a0e2c5a8beb..09e697b92426 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -754,6 +754,40 @@ void btintel_reset_to_bootloader(struct hci_dev *hdev)
> }
> EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
> 
> +int btintel_read_supported_features(struct hci_dev *hdev,
> +	struct intel_supported_features *supported_features)
> +{
> +	struct sk_buff *skb;
> +	u8 page_no = 1;
> +
> +	/* Intel controller supports two pages, each page is of 128-bit
> +	 * feature bit mask. And each bit defines specific feature support
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
> +		HCI_INIT_TIMEOUT);

Please get the coding style right first. We have plenty of examples in the same file on how to do this.

Regards

Marcel

