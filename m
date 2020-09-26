Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0369C4727F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35002087E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgIZHna (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 03:43:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60930 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZHna (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 03:43:30 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id B279BCECE8;
        Sat, 26 Sep 2020 09:50:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 4/4] Bluetooth: MGMT: Fix not checking if BT_HS is enabled
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200806181714.3216076-4-luiz.dentz@gmail.com>
Date:   Sat, 26 Sep 2020 09:43:28 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <693B5FA6-8AF7-4E2C-834F-6CC4EB758E2A@holtmann.org>
References: <20200806181714.3216076-1-luiz.dentz@gmail.com>
 <20200806181714.3216076-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This checks if BT_HS is enabled relecting it on MGMT_SETTING_HS instead
> of always reporting it as supported.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

