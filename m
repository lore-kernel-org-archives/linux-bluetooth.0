Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90656C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666B4217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeLSQmE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:42:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60926 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSQmE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:42:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9DF514E1F53F;
        Wed, 19 Dec 2018 08:42:03 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:42:03 -0800 (PST)
Message-Id: <20181219.084203.649762030333127251.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2018-12-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181219155246.GA25077@jhedberg-mac01.local>
References: <20181219155246.GA25077@jhedberg-mac01.local>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Dec 2018 08:42:03 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 19 Dec 2018 17:52:46 +0200

> Here's the main bluetooth-next pull request for 4.21:
> 
>  - Multiple fixes & improvements for Broadcom-based controllers
>  - New USB ID for an Intel controller
>  - Support for new Broadcom controller variants
>  - Use DEFINE_SHOW_ATTRIBUTE to simplify debugfs code
>  - Eliminate confusing "last event is not cmd complete" warning message
>  - Added vendor suspend/resume support for H:5 (3-Wire UART) controllers
>  - Various other smaller improvements & fixes
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
