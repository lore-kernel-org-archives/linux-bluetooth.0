Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CBF64E2E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 13:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBCNh2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 08:37:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47044 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBCNhB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 08:37:01 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01E61CECFC;
        Wed,  3 Feb 2021 14:43:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix typo and correct the log print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210203080612.36904-1-zjp734690220@163.com>
Date:   Wed, 3 Feb 2021 14:36:11 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <28DBD65D-7252-48FF-8A40-276883BA7ED8@holtmann.org>
References: <20210203080612.36904-1-zjp734690220@163.com>
To:     zjp734690220@163.com
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
> v3: update bluetooth-next tree and regenerate the patch
> v2: correct the log print and update the patch From: and Signed-off-by:
> ---
> drivers/bluetooth/btusb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

this must have been caught up again in between other patches, but it does not apply cleanly anymore. Please rebase again.

Regards

Marcel

