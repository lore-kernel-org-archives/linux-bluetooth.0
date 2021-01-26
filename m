Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97276C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E21922A85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbhAZRTR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40222 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhAZJS7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 04:18:59 -0500
Received: from marcel-macpro.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id A962DCECE6;
        Tue, 26 Jan 2021 10:25:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v4] Bluetooth: btrtl: Enable WBS for the specific Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210126020434.4911-1-max.chou@realtek.com>
Date:   Tue, 26 Jan 2021 10:17:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, kidman@realtek.com,
        abhishekpandit@chromium.org, josephsih@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <DD1FF7EB-CC31-4E90-B0E6-5E7B86256956@holtmann.org>
References: <20210126020434.4911-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> By this change, it will enable WBS supported on the specific Realtek BT
> devices, such as RTL8822C and RTL8852A.
> In the future, it's able to maintain what the Realtek devices support WBS
> here.
> 
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> ---
> change in v4
> -remove the unnecessary comment to avoid the unaligned starting point.
> ---
> drivers/bluetooth/btrtl.c | 29 +++++++++++++++++++++++------
> 1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 24f03a1f8d57..adcd054313a4 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,6 +38,19 @@
> 	.hci_ver = (hciv), \
> 	.hci_bus = (bus)
> 
> +enum  btrtl_chip_id {

fix the whitespace part here.

> +	CHIP_ID_8723A,
> +	CHIP_ID_8723B,
> +	CHIP_ID_8821A,
> +	CHIP_ID_8761A,
> +	CHIP_ID_8822B = 8,
> +	CHIP_ID_8723D,
> +	CHIP_ID_8821C,
> +	CHIP_ID_8822C = 13,
> +	CHIP_ID_8761B,
> +	CHIP_ID_8852A = 18,
> +};
> +

Regards

Marcel

