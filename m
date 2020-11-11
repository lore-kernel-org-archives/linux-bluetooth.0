Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B8C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C728F2064B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKKJzL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:55:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44315 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJzK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 04:55:10 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8DF1BCECFC;
        Wed, 11 Nov 2020 11:02:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH][v2] Bluetooth: hci_qca: resolve various warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201111045538.GA90261@fedora-project>
Date:   Wed, 11 Nov 2020 10:55:05 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <054F4CD9-1A1B-41EB-8C18-EB02CC3E9E56@holtmann.org>
References: <20201111045538.GA90261@fedora-project>
To:     Nigel Christian <nigel.l.christian@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nigel,

> Replace symbolic permissions with octal values. Use usleep_range
> for small msec values due to the fact that msleep() less than 
> 20ms may have unexpected behavior/sleep longer.
> 
> - https://lkml.org/lkml/2016/8/2/1945
> - Documentation/timers/timers-howto.rst
> 
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

