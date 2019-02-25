Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6601C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2382087C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 06:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfBYG1t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:27:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35820 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBYG1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 01:27:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5F1F614E06F72;
        Sun, 24 Feb 2019 22:27:48 -0800 (PST)
Date:   Sun, 24 Feb 2019 22:27:47 -0800 (PST)
Message-Id: <20190224.222747.1583677905953396590.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-02-24
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190224083634.GA82295@jhedberg-mac01.home>
References: <20190224083634.GA82295@jhedberg-mac01.home>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Feb 2019 22:27:48 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sun, 24 Feb 2019 10:36:34 +0200

> Here's the main bluetooth-next pull request for the 5.1 kernel.
> 
>  - Fixes & improvements to mediatek, hci_qca, btrtl, and btmrvl HCI drivers
>  - Fixes to parsing invalid L2CAP config option sizes
>  - Locking fix to bt_accept_enqueue()
>  - Add support for new Marvel sd8977 chipset
>  - Various other smaller fixes & cleanups
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
