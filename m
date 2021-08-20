Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D65C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 11:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991C9610CB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 11:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbhHTLrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:47:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51044 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhHTLrP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 07:47:15 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 839684D0F197C;
        Fri, 20 Aug 2021 04:46:34 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:46:29 +0100 (BST)
Message-Id: <20210820.124629.2213659775230733647.davem@davemloft.net>
To:     luiz.dentz@gmail.com
Cc:     kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2021-08-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210819222307.242695-1-luiz.dentz@gmail.com>
References: <20210819222307.242695-1-luiz.dentz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 20 Aug 2021 04:46:35 -0700 (PDT)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Aug 2021 15:23:07 -0700

> The following changes since commit 4431531c482a2c05126caaa9fcc5053a4a5c495b:
> 
>   nfp: fix return statement in nfp_net_parse_meta() (2021-07-22 05:46:03 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2021-08-19
> 

There was a major merge conflict with the deferred hci cleanup fix that came in via
'net'.  Please double check my conflict resolution.

Thanks.

