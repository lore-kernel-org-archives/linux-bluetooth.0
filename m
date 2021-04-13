Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323C9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E705613C5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbhDMSfZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:35:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48454 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347929AbhDMSfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 14:35:24 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84989CECCC;
        Tue, 13 Apr 2021 20:42:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btusb: fix memory leak
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210413175208.GA560049@LEGION>
Date:   Tue, 13 Apr 2021 20:35:02 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "mark-yw.chen" <mark-yw.chen@mediatek.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        colin.king@canonical.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E4C40E0D-4D06-4E3C-BEA3-079FACEE1A06@holtmann.org>
References: <20210413175208.GA560049@LEGION>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Muhammad,

> If btusb_mtk_submit_wmt_recv_urb returns error, wc should be freed and
> then error should be returned to prevent memory leak.
> 
> Addresses-Coverity: ("Prevent memory leak")
> Fixes: 4cbb375e997d ("Bluetooth: btusb: Fixed too many in-token issue for Mediatek Chip.")
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

