Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2133C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF72123118
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAFHuv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:50:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42715 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFHuv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 02:50:51 -0500
Received: from marcel-macbook.holtmann.net (p5b3d23d0.dip0.t-ipconnect.de [91.61.35.208])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9A6D1CED0F;
        Wed,  6 Jan 2021 08:57:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_h5: Add support for binding RTL8723DS
 with device tree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210102214116.1098030-1-johnny86@gmx.de>
Date:   Wed, 6 Jan 2021 08:50:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B3488D5C-B436-42E6-B488-96E5E8E84463@holtmann.org>
References: <20210102214116.1098030-1-johnny86@gmx.de>
To:     John-Eric Kamps <johnny86@gmx.de>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John-Eric,

> RTL8723DS could be handled by btrtl-driver, so add ability to bind it
> using device tree.
> 
> Signed-off-by: John-Eric Kamps <johnny86@gmx.de>
> ---
> drivers/bluetooth/hci_h5.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

