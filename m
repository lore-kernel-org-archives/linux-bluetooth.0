Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42208C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BB160F94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhHDOjm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:39:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32781 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhHDOjm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:39:42 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id D7088CECD5;
        Wed,  4 Aug 2021 16:39:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] bluetooth: Add Bluetooth part of Realtek 8852AE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210804143641.23913-1-Larry.Finger@lwfinger.net>
Date:   Wed, 4 Aug 2021 16:39:28 +0200
Cc:     "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <14B511B2-94C5-4AA8-888B-74D48A486D85@holtmann.org>
References: <20210804143641.23913-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Larry,

> This Realtek device has both wifi and BT components. The latter reports
> a USB ID of 04ca:4006, which is not in the table.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)

please include /sys/kernel/debug/usb/devices portion of this device in the commit message.

Regards

Marcel

