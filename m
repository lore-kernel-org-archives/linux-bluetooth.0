Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78DC619B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhCWPHO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 11:07:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45655 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhCWPGv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 11:06:51 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id B05AECECE4;
        Tue, 23 Mar 2021 16:14:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] Bluetooth: Remove trailing semicolon in macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1616480576-5249-1-git-send-email-yumeng18@huawei.com>
Date:   Tue, 23 Mar 2021 16:06:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1207403F-0891-4A64-9942-215D31441DB6@holtmann.org>
References: <1616480576-5249-1-git-send-email-yumeng18@huawei.com>
To:     Meng Yu <yumeng18@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meng,

> remove trailing semicolon in macros and coding style fix.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> ---
> 
> Changes in v2
> -Re-base in bluetooth-next 
> 
> net/bluetooth/smp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

