Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA73C4708F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6504613D7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 20:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFBUIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:08:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57512 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBUIs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 16:08:48 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 54465CED09;
        Wed,  2 Jun 2021 22:15:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH -next] Bluetooth: btmtkuart: using
 pm_runtime_resume_and_get instead of pm_runtime_get_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210531142450.30779-1-zhangqilong3@huawei.com>
Date:   Wed, 2 Jun 2021 22:07:03 +0200
Cc:     Sean Wang <sean.wang@mediatek.com>, matthias.bgg@gmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F0355112-A984-4DB7-8164-1B261745AB2C@holtmann.org>
References: <20210531142450.30779-1-zhangqilong3@huawei.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhang,

> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
> drivers/bluetooth/btmtkuart.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

