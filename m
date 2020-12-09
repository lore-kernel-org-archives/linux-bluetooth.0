Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD64BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 00:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849B723B55
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgLIAB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgLIAB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 19:01:28 -0500
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45546C0613CF;
        Tue,  8 Dec 2020 16:00:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 9DD564D248DBF;
        Tue,  8 Dec 2020 16:00:47 -0800 (PST)
Date:   Tue, 08 Dec 2020 16:00:46 -0800 (PST)
Message-Id: <20201208.160046.1210704223846709688.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-12-07
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20201207150915.GA10957@johnypau-MOBL2.ger.corp.intel.com>
References: <20201207150915.GA10957@johnypau-MOBL2.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 08 Dec 2020 16:00:47 -0800 (PST)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 7 Dec 2020 17:09:15 +0200

> Hi Dave, Jakub,
> 
> Here's the main bluetooth-next pull request for the 5.11 kernel.
> 
>  - Updated Bluetooth entries in MAINTAINERS to include Luiz von Dentz
>  - Added support for Realtek 8822CE and 8852A devices
>  - Added support for MediaTek MT7615E device
>  - Improved workarounds for fake CSR devices
>  - Fix Bluetooth qualification test case L2CAP/COS/CFD/BV-14-C
>  - Fixes for LL Privacy support
>  - Enforce 16 byte encryption key size for FIPS security level
>  - Added new mgmt commands for extended advertising support
>  - Multiple other smaller fixes & improvements
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
