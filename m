Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384EC2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0EC20771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgC3St4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:49:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41164 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Stz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 14:49:55 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 895B415C6C87E;
        Mon, 30 Mar 2020 11:49:55 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:49:54 -0700 (PDT)
Message-Id: <20200330.114954.1491102317925579419.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-03-29
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200329213228.GA16750@sharonc1-mobl.ger.corp.intel.com>
References: <20200329213228.GA16750@sharonc1-mobl.ger.corp.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Mar 2020 11:49:55 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 30 Mar 2020 00:32:28 +0300

> Here are a few more Bluetooth patches for the 5.7 kernel:
> 
>  - Fix assumption of encryption key size when reading fails
>  - Add support for DEFER_SETUP with L2CAP Enhanced Credit Based Mode
>  - Fix issue with auto-connected devices
>  - Fix suspend handling when entering the state fails
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks.
