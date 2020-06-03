Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0ECC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B802068D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFCR4U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:56:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47771 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgFCR4U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:56:20 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0D50BCED2F;
        Wed,  3 Jun 2020 20:06:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix an error pointer dereference
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200529095948.GA1304852@mwanda>
Date:   Wed, 3 Jun 2020 19:56:18 +0200
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <95074BC2-C7A8-44F7-9C14-0B82E26D05A9@holtmann.org>
References: <20200529095948.GA1304852@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> When a function like devm_clk_get_optional() function returns both error
> pointers on error and NULL then the NULL return means that the optional
> feature is deliberately disabled.  It is a special sort of success and
> should not trigger an error message.  The surrounding code should be
> written to check for NULL and not crash.
> 
> On the other hand, if we encounter an error, then the probe from should
> clean up and return a failure.
> 
> In this code, if devm_clk_get_optional() returns an error pointer then
> the kernel will crash inside the call to:
> 
> 	clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
> 
> The error handling must be updated to prevent that.
> 
> Fixes: 77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Commit 77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with
> devm_gpiod_get_optional()") changed how qcadev->bt_en is handled as
> well.  From a very strict perspective the new code is buggy because the
> warnings should only be printed for error pointers, but currently errors
> are ignored and warnings are printed for NULL.
> 
> However this bug does not lead to a crash so I have left it as is.
> 
> drivers/bluetooth/hci_qca.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

