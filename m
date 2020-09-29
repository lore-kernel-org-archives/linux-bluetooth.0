Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FEC47420
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39DA2076D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 20:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgI2UXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2UXM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 16:23:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2002C061755;
        Tue, 29 Sep 2020 13:23:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F1E0145A48FF;
        Tue, 29 Sep 2020 13:06:24 -0700 (PDT)
Date:   Tue, 29 Sep 2020 13:23:10 -0700 (PDT)
Message-Id: <20200929.132310.538725260544973709.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-09-29
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200929110519.GA43102@Dgorle-MOBL1.ger.corp.intel.com>
References: <20200929110519.GA43102@Dgorle-MOBL1.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 29 Sep 2020 13:06:24 -0700 (PDT)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 29 Sep 2020 14:05:19 +0300

> Here's the main bluetooth-next pull request for 5.10:
> 
>  - Multiple fixes to suspend/resume handling
>  - Added mgmt events for controller suspend/resume state
>  - Improved extended advertising support
>  - btintel: Enhanced support for next generation controllers
>  - Added Qualcomm Bluetooth SoC WCN6855 support
>  - Several other smaller fixes & improvements
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thank you.
