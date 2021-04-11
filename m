Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B78C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 11:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECF0610A7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 11:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhDKL5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:57:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51663 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhDKL5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Apr 2021 07:57:11 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id B0B0FCECF3;
        Sun, 11 Apr 2021 14:04:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH][next] Bluetooth: virtio_bt: add missing null pointer
 check on alloc_skb call return
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210409165314.671165-1-colin.king@canonical.com>
Date:   Sun, 11 Apr 2021 13:56:52 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4EC34C12-20A9-4EB2-B699-332F0CE3A38F@holtmann.org>
References: <20210409165314.671165-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> The call to alloc_skb with the GFP_KERNEL flag can return a null sk_buff
> pointer, so add a null check to avoid any null pointer deference issues.
> 
> Addresses-Coverity: ("Dereference null return value")
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/virtio_bt.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

