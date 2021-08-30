Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D80C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5D760C40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 15:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhH3PEz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:04:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48602 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbhH3PEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 11:04:54 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id E63E2CECC3;
        Mon, 30 Aug 2021 17:03:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Support public address
 configuration for MediaTek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210824154430.27689-1-mark-yw.chen@mediatek.com>
Date:   Mon, 30 Aug 2021 17:03:59 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        michaelfsun@google.com, mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CF258C9C-BB3C-4C10-88B0-F6F3A03303D5@holtmann.org>
References: <20210824154430.27689-1-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> The MediaTek chip support vendor specific HCI command(0xfc1a) to
> change the public address. Add hdev->set_bdaddr handler for MediaTek
> Chip.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60d2fce59a71..41e7c9f28d82 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2200,6 +2200,23 @@ struct btmtk_section_map {
> 	};
> } __packed;
> 
> +static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	struct sk_buff *skb;
> +	long ret;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
> +			   ret);
> +		return ret;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +

this is not a permanent change, correct? Meaning a power cycle will bring back the original BD_ADDR?

Regards

Marcel

