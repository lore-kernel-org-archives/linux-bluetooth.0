Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C662C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE4B2312D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 12:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLVMY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 07:24:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53777 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgLVMY1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 07:24:27 -0500
Received: from [172.20.10.2] (tmo-113-220.customers.d1-online.com [80.187.113.220])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94327CED20;
        Tue, 22 Dec 2020 13:31:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Remove duplicate newlines from logging
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <45b260bfe6a3d3c11c48e76dd5de7fa40665154c.camel@perches.com>
Date:   Tue, 22 Dec 2020 13:23:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <81334976-F36B-42B9-8687-4D03E394E657@holtmann.org>
References: <45b260bfe6a3d3c11c48e76dd5de7fa40665154c.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joe,

> The bt_dev_<level> macros already append a newline.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> The "No memory" message could be removed as bt_skb_alloc already does
> a dump_stack() on allocation failure.
> 
> drivers/bluetooth/btusb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

