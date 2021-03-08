Return-Path: <SRS0=kCXZ=IG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C38C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9082A65062
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHJ1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:27:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37440 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCHJ1L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 04:27:11 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9E8F3CED12;
        Mon,  8 Mar 2021 10:34:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 2/2 v3] Bluetooth: btbcm: Obtain and handle reset GPIO
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210305183736.2123083-2-linus.walleij@linaro.org>
Date:   Mon, 8 Mar 2021 10:27:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3EBC4984-E388-46B8-9ECB-068B0CD88F55@holtmann.org>
References: <20210305183736.2123083-1-linus.walleij@linaro.org>
 <20210305183736.2123083-2-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

> Obtain and drive the optional reset GPIO line if this is
> not hardwired in the platform. This is needed on the
> Samsung GT-I9070 mobile phone.
> 
> The invers of power is used, this should be OK to apply
> simultaneously as the power signal according to
> figures 47-51 on pages 159-161 in the BCM4330 datasheet.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Resend with the other patch.
> ChangeLog v1->v2:
> - Rebase on v5.12-rc1
> ---
> drivers/bluetooth/hci_bcm.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

