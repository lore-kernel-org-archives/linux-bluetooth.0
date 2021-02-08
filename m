Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1CFC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26D164E16
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 13:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhBHN4j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:56:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36647 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhBHN4V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 08:56:21 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f5d2.dip0.t-ipconnect.de [79.249.245.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 369E8CED06;
        Mon,  8 Feb 2021 15:03:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v1] Bluetooth: hci_qca:Fixed issue during suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1612539436-8498-1-git-send-email-gubbaven@codeaurora.org>
Date:   Mon, 8 Feb 2021 14:55:33 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org,
        abhishekpandit@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <83976EDA-6F40-44CC-BE4C-2405BC2B2EEB@holtmann.org>
References: <1612539436-8498-1-git-send-email-gubbaven@codeaurora.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Venkata,

> If BT SoC is running with ROM FW then just return in
> qca_suspend function as ROM FW does not support
> in-band sleep.
> 
> Fixes: 2be43abac5a8 ("Bluetooth: hci_qca: Wait for timeout during suspend")
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
> drivers/bluetooth/hci_qca.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

