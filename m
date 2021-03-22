Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB37619B7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhCVQH7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:07:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43263 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhCVQG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 12:06:28 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8EB90CECB0;
        Mon, 22 Mar 2021 17:14:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Remove trailing semicolon in macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1616224773-41847-1-git-send-email-yumeng18@huawei.com>
Date:   Mon, 22 Mar 2021 17:06:25 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4A3E143A-6877-459D-9CB9-834DA298B472@holtmann.org>
References: <1616224773-41847-1-git-send-email-yumeng18@huawei.com>
To:     Meng Yu <yumeng18@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meng,

> 1. remove trailing semicolon in macros;
> 2. fix some coding style.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> ---
> net/bluetooth/smp.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

the patch doesn’t apply to bluetooth-next, please re-base and send again.

Regards

Marcel

