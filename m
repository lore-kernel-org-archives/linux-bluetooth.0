Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6ADC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7502072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKWLcu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:32:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54199 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgKWLct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:32:49 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5F08ACECD0;
        Mon, 23 Nov 2020 12:39:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v2] Bluetooth: btqca: Add support to read FW build version
 for WCN3991 BTSoC
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
Date:   Mon, 23 Nov 2020 12:32:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E0559BAF-630C-4C78-8771-16C3A9952B08@holtmann.org>
References: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Venkata,

> Add support to read FW build version for WCN3991 BTSoC
> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
> drivers/bluetooth/btqca.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  3 +++
> 2 files changed, 60 insertions(+)

please send a version that applies cleanly against bluetooth-next.

Regards

Marcel

