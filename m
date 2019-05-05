Return-Path: <SRS0=kkCe=TF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BFC004C9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 May 2019 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CEB204EC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 May 2019 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEEULW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 May 2019 16:11:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54678 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEEULW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 May 2019 16:11:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 97A7414DAEDCB;
        Sun,  5 May 2019 13:11:21 -0700 (PDT)
Date:   Sun, 05 May 2019 13:11:11 -0700 (PDT)
Message-Id: <20190505.131111.1043127096475376042.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-05-05
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190505191203.GA86553@iliorx-mobl.ger.corp.intel.com>
References: <20190505191203.GA86553@iliorx-mobl.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 May 2019 13:11:21 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sun, 5 May 2019 22:12:03 +0300

> Here's one more bluetooth-next pull request for 5.2:
> 
>  - Fixed Command Complete event handling check for matching opcode
>  - Added support for Qualcomm WCN3998 controller, along with DT bindings
>  - Added default address for Broadcom BCM2076B1 controllers
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
