Return-Path: <SRS0=Oh6E=RF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F0C4360F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 21:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042AF2086D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 21:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCBV4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:56:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42820 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfCBV4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Mar 2019 16:56:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9110B145F438D;
        Sat,  2 Mar 2019 13:56:17 -0800 (PST)
Date:   Sat, 02 Mar 2019 13:56:14 -0800 (PST)
Message-Id: <20190302.135614.281806988747107355.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-03-02
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190302200057.GA22165@arejment-mobl.ger.corp.intel.com>
References: <20190302200057.GA22165@arejment-mobl.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 02 Mar 2019 13:56:17 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 2 Mar 2019 21:00:57 +0100

> Here's one more bluetooth-next pull request for the 5.1 kernel:
> 
>  - Added support for MediaTek MT7663U and MT7668U UART devices
>  - Cleanups & fixes to the hci_qca driver
>  - Fixed wakeup pin behavior for QCA6174A controller
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
