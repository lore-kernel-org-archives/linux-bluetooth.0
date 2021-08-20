Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4783A6101A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhHTMxK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240278AbhHTMxJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 08:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A2DAB610FA;
        Fri, 20 Aug 2021 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629463951;
        bh=1xOQvOsMamdQCR2nC8c1fOq/WXkAqasGi2J5GBhLcYU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ejZSd2Mpbrm8SsQ2LN25he+HB2/BQzeat1ZEgQHAOZbEzfwtgDD5gmmPA/QwbPOLV
         I+6vP/XKePnx2tJzYIWK7bK8hmDRpnCBh5SzWm0DE2qYu3gHrZkyQrKxibH3AIJv1b
         vzqoMHP14SMHLpdTbruLlQc5rLeN8kuPPGSVoQ1ZAHtEliyQVDha8chZiCCZNsgtth
         9Os6m+w85qS5f+v3IKyA1LtGbg0rc6YCMvmm4DKL3B2uS9rHpYbunX7ShvHRB7wBh5
         ctHcvpJer1iPHoebQOZ9dHz2/PU+zZ2eXweMXiph72Sz9daFXUW2AXw3BnewyL+6Wx
         Iy4TAOM4viG5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2021-08-19
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162946395163.27725.12954173688510893089.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Aug 2021 12:52:31 +0000
References: <20210819222307.242695-1-luiz.dentz@gmail.com>
In-Reply-To: <20210819222307.242695-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (refs/heads/master):

On Thu, 19 Aug 2021 15:23:07 -0700 you wrote:
> The following changes since commit 4431531c482a2c05126caaa9fcc5053a4a5c495b:
> 
>   nfp: fix return statement in nfp_net_parse_meta() (2021-07-22 05:46:03 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2021-08-19
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2021-08-19
    https://git.kernel.org/netdev/net-next/c/e61fbee7be4b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


