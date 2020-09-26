Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CCBC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D4F2083B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgIZHnY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 03:43:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48372 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZHnX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 03:43:23 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id 38A0CCECE8;
        Sat, 26 Sep 2020 09:50:21 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 1/4] Bluetooth: A2MP: Fix not initializing all members
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200806181714.3216076-1-luiz.dentz@gmail.com>
Date:   Sat, 26 Sep 2020 09:43:20 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CC33E7FA-7AC0-49A1-BEB1-70A51A9DE19F@holtmann.org>
References: <20200806181714.3216076-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes various places where a stack variable is used uninitialized.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/a2mp.c | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

