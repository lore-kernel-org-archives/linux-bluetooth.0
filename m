Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbhKXO4f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:56:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47846 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348525AbhKXO4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 09:56:34 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9C0A8CED24;
        Wed, 24 Nov 2021 15:53:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 2/4] Bluetooth: btmtksdio: handle runtime pm only when
 sdio_func is available
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <07cd9db8ef295bfe3e6b42796ccb8c9fb59dd9ba.1637360076.git.objelf@gmail.com>
Date:   Wed, 24 Nov 2021 15:53:23 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <74A2D0D6-6A65-4832-BAFC-BCBA68F8DE78@holtmann.org>
References: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
 <07cd9db8ef295bfe3e6b42796ccb8c9fb59dd9ba.1637360076.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sean,

> Runtime pm ops is not aware the sdio_func status that is probably
> being disabled by btmtksdio_close. Thus, we are only able to access the
> sdio_func for the runtime pm operations only when the sdio_func is
> available.
> 
> Fixes: 7f3c563c575e7 ("Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth")
> Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
> Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 4f3412ad8fca..4c46c62e4623 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1037,6 +1037,9 @@ static int btmtksdio_runtime_suspend(struct device *dev)
> 	if (!bdev)
> 		return 0;
> 
> +	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
> +		return 0;
> +
> 	sdio_claim_host(bdev->func);
> 
> 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
> @@ -1064,6 +1067,9 @@ static int btmtksdio_runtime_resume(struct device *dev)
> 	if (!bdev)
> 		return 0;
> 
> +	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
> +		return 0;
> +
> 	sdio_claim_host(bdev->func);
> 
> 	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);

I dislike looking at HCI_RUNNING since that check should be removed from a driver. Do you really need it? I mean, a driver should now if it is running or not.

Regards

Marcel

