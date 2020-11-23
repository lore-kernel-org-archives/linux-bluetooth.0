Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90FC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBAE20758
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgKWLvu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:51:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48542 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgKWLvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:51:50 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 02097CECCF;
        Mon, 23 Nov 2020 12:58:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btmtksdio: Add the missed release_firmware()
 in mtk_setup_firmware()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201117024332.165771-1-jingxiangfeng@huawei.com>
Date:   Mon, 23 Nov 2020 12:51:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, matthias.bgg@gmail.com,
        Mark-YW.Chen@mediatek.com, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9917F51E-C0C5-45AA-903A-DA3C10398F95@holtmann.org>
References: <20201117024332.165771-1-jingxiangfeng@huawei.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jing,

> mtk_setup_firmware() misses to call release_firmware() in an error
> path. Jump to free_fw to fix it.
> 
> Fixes: 737cd06072a7 ("Bluetooth: btmtksdio: fix up firmware download sequence")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
> drivers/bluetooth/btmtksdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

