Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C044C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBAF64F78
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhBBQ3q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:29:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43662 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbhBBQ1l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 11:27:41 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19E24CECDE;
        Tue,  2 Feb 2021 17:34:23 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix memory leak in
 btusb_mtk_wmt_recv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210202013913.15324-1-zjp734690220@163.com>
Date:   Tue, 2 Feb 2021 17:26:55 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus.Elfring@web.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0C7BC6BB-9FC7-4857-8DDF-DA1FC56E15B7@holtmann.org>
References: <20210202013913.15324-1-zjp734690220@163.com>
To:     Jupeng Zhong <zjp734690220@163.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jupeng,

> In btusb_mtk_wmt_recv if skb_clone fails, the alocated skb should be
> released.
> 
> Omit the labels “err_out” and “err_free_skb” in this function
> implementation so that the desired exception handling code
> would be directly specified in the affected if branches.
> 
> Fixes: a1c49c434e15 ("btusb: Add protocol support for MediaTek MT7668U USB devices")
> Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
> ---
> drivers/bluetooth/btusb.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)

patch does not apply cleanly to bluetooth-next tree. Please rebase.

Regards

Marcel

