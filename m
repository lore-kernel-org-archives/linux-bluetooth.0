Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A3C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B41D204EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfARKzI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:55:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55680 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfARKzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:55:07 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id D4974CEE14;
        Fri, 18 Jan 2019 12:02:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: btmrv1: Drop unused GPIO includes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190103123227.30424-1-linus.walleij@linaro.org>
Date:   Fri, 18 Jan 2019 11:55:06 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5DA7AEF5-C0DD-46DB-946E-86C9B571158A@holtmann.org>
References: <20190103123227.30424-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

> I can't see that these drivers use the old GPIO inlcudes in any
> way, drop <linux/gpio.h> and <linux/of_gpio.h>.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> drivers/bluetooth/btmrvl_drv.h | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

