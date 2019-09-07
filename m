Return-Path: <SRS0=PJow=XC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE50AC43331
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Sep 2019 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F721920
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Sep 2019 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394887AbfIGQI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:08:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394881AbfIGQIZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Sep 2019 12:08:25 -0400
Received: from localhost (unknown [88.214.184.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 253F7152F1ADF;
        Sat,  7 Sep 2019 09:08:23 -0700 (PDT)
Date:   Sat, 07 Sep 2019 18:08:22 +0200 (CEST)
Message-Id: <20190907.180822.371453099451603652.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-09-06
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190906172339.GA74057@jmoran1-mobl1.ger.corp.intel.com>
References: <20190906172339.GA74057@jmoran1-mobl1.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Sep 2019 09:08:24 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 6 Sep 2019 20:23:39 +0300

> Here's the main bluetooth-next pull request for the 5.4 kernel.
> 
>  - Cleanups & fixes to btrtl driver
>  - Fixes for Realtek devices in btusb, e.g. for suspend handling
>  - Firmware loading support for BCM4345C5
>  - hidp_send_message() return value handling fixes
>  - Added support for utilizing Fast Advertising Interval
>  - Various other minor cleanups & fixes
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks.
