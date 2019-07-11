Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8509FC74A42
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6727721019
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGKHF3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:05:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60750 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfGKHF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 03:05:28 -0400
Received: from [192.168.23.168] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8EAACF2B8;
        Thu, 11 Jul 2019 09:13:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] Bluetooth: btusb: Fix error return code in
 btusb_mtk_setup_firmware()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190710061222.141247-1-weiyongjun1@huawei.com>
Date:   Thu, 11 Jul 2019 09:05:25 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <44F125E4-F492-4F33-9E50-F10CE11C09BC@holtmann.org>
References: <20190710061222.141247-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wei,

> Fix to return error code -EINVAL from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> drivers/bluetooth/btusb.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

