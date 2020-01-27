Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AABC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74D6207FD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 10:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgA0KZK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:25:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgA0KZK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 05:25:10 -0500
Received: from localhost (unknown [213.175.37.12])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8BD731513DD3F;
        Mon, 27 Jan 2020 02:25:08 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:25:06 +0100 (CET)
Message-Id: <20200127.112506.1247864116213060981.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-01-26
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200126140123.GA77676@pmessmer-mobl1.ger.corp.intel.com>
References: <20200126140123.GA77676@pmessmer-mobl1.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jan 2020 02:25:09 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sun, 26 Jan 2020 16:01:23 +0200

> Here's (probably) the last bluetooth-next pull request for the 5.6 kernel.
> 
>  - Initial pieces of Bluetooth 5.2 Isochronous Channels support
>  - mgmt: Various cleanups and a new Set Blocked Keys command
>  - btusb: Added support for 04ca:3021 QCA_ROME device
>  - hci_qca: Multiple fixes & cleanups
>  - hci_bcm: Fixes & improved device tree support
>  - Fixed attempts to create duplicate debugfs entries
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
