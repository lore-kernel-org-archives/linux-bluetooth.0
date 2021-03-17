Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E1C64F67
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 14:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCQOWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:22:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46251 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhCQOWK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 10:22:10 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id C41D3CED16;
        Wed, 17 Mar 2021 15:29:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Fix incorrect status handling in LE PHY UPDATE
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210317112214.12622-1-ayush.garg@samsung.com>
Date:   Wed, 17 Mar 2021 15:22:07 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        anupam.r@samsung.com, nitin.j@samsung.com
Content-Transfer-Encoding: 7bit
Message-Id: <48C8F317-F4FB-4E90-B0D9-ECC6EC07F094@holtmann.org>
References: <CGME20210317112220epcas5p40e3a942da73f819d20679cf03710860c@epcas5p4.samsung.com>
 <20210317112214.12622-1-ayush.garg@samsung.com>
To:     Ayush Garg <ayush.garg@samsung.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ayush,

> Skip updation of tx and rx PHYs values, when PHY Update
> event's status is not successful.
> 
> Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
> ---
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

