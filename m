Return-Path: <SRS0=Ml/a=S4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693CC43218
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Apr 2019 05:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CAC206BA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Apr 2019 05:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfDZFkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:40:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58224 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZFkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Apr 2019 01:40:36 -0400
Received: from localhost (unknown [12.154.31.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DF7E13E9135D;
        Thu, 25 Apr 2019 22:40:35 -0700 (PDT)
Date:   Fri, 26 Apr 2019 01:40:30 -0400 (EDT)
Message-Id: <20190426.014030.1174918828714026956.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-04-25
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190425133810.GB67839@jhedberg-mac01.local>
References: <20190425133810.GB67839@jhedberg-mac01.local>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Apr 2019 22:40:36 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 25 Apr 2019 06:38:10 -0700

> Here's the main bluetooth-next pull request for the 5.2 kernel.
> 
>  - Added support for Mediatek SDIO controllers
>  - Added support for Broadcom BCM2076B1 UART controller
>  - Added support for Marvel SD8987 chipset
>  - Fix buffer overflow bug in hidp protocol
>  - Various other smaller fixes & improvements
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
