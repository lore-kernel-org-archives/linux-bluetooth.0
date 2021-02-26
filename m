Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253DC433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F0B64F0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBZUVh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:21:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45046 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhBZUTe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:19:34 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33845CECF0;
        Fri, 26 Feb 2021 21:26:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Fix incorrect type in assignment
 and uninitialized symbol
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210223062740.12067-1-mark-yw.chen@mediatek.com>
Date:   Fri, 26 Feb 2021 21:18:35 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Sean.Wang@mediatek.com,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <92470858-9C75-4F77-AC70-B56DEE423255@holtmann.org>
References: <20210223062740.12067-1-mark-yw.chen@mediatek.com>
To:     Mark Chen <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> Warnings: drivers/bluetooth/btusb.c:3775 btusb_mtk_setup() error:
> uninitialized symbol 'fw_version'.
> -> add initial value for fw_version.
> 
> Warnings: sparse: sparse: incorrect type in assignment (different base
> types)
> -> add le32_to_cpu to fix incorrect type in assignment.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

