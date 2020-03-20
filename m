Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F9C4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 04:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4920722
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 04:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCTEd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:33:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgCTEd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 00:33:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 399E71590C684;
        Thu, 19 Mar 2020 21:33:56 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:33:55 -0700 (PDT)
Message-Id: <20200319.213355.948621670202695571.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-03-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200319192841.GA11720@aleibman-mobl1.ger.corp.intel.com>
References: <20200319192841.GA11720@aleibman-mobl1.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Mar 2020 21:33:56 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 19 Mar 2020 21:28:41 +0200

> Here's the main bluetooth-next pull request for the 5.7 kernel.
> 
>  - Added wideband speech support to mgmt and the ability for HCI drivers
>    to declare support for it.
>  - Added initial support for L2CAP Enhanced Credit Based Mode
>  - Fixed suspend handling for several use cases
>  - Fixed Extended Advertising related issues
>  - Added support for Realtek 8822CE device
>  - Added DT bindings for QTI chip WCN3991
>  - Cleanups to replace zero-length arrays with flexible-array members
>  - Several other smaller cleanups & fixes
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.

