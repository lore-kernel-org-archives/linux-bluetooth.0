Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC3C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C532C64F72
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhBBQ2h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:28:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42590 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhBBQZy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 11:25:54 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id CDA8DCECE0;
        Tue,  2 Feb 2021 17:32:37 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix typo and correct the log print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210202022443.33228-1-zjp734690220@163.com>
Date:   Tue, 2 Feb 2021 17:25:10 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <20560FEB-E326-4409-9006-5E8CEBFF9849@holtmann.org>
References: <20210202022443.33228-1-zjp734690220@163.com>
To:     Jupeng Zhong <zjp734690220@163.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jupeng,

> Change "deivice" to "device"
> 
> Correct "Unsupported support hardware variant (%08x)" to
> "Unsupported hardware variant (%08x)"
> 
> Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
> ---
> drivers/bluetooth/btusb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch doesn’t not apply cleanly to bluetooth-next tree. Please rebase.

Regards

Marcel

