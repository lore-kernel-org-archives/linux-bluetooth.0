Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF02C4742C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB882072C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKKKyv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:54:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50029 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKKKyu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 05:54:50 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B3A3CECFC;
        Wed, 11 Nov 2020 12:01:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH][next] Bluetooth: btrtl: fix incorrect skb allocation
 failure check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201110123915.3356601-1-colin.king@canonical.com>
Date:   Wed, 11 Nov 2020 11:54:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0DA7A8C1-07AA-4342-A16A-FEB5C5825C76@holtmann.org>
References: <20201110123915.3356601-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> Currently the check for a failed bt_skb_alloc allocation is incorrectly
> checking using IS_ERR and this can lead to a null pointer dereference. Fix
> this by checking for a null pointer return using the !skb idiom.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 1996d9cad6ad ("Bluetooth: btrtl: Ask 8821C to drop old firmware")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btrtl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

