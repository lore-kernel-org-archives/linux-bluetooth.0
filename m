Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E6E748E9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJANU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjJANU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 09:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CFC4
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 06:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B54C433C9;
        Sun,  1 Oct 2023 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696166422;
        bh=FnIePasQhhmc7IrL9A8wKG+W4nEtSF5xqNAHh3fCmcE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TCM1Zkwj/OdHt6pWbc8ggZmIjjb9eXBJki15QObteLWZ/Ukn47FR2U36Wb3hyxNUp
         1Sqf+kX5ro96MqGjMhZNqFH6gpOqtQKs/Gq2LdVS1HaI/yZqjui45t+4RdUCqhzI9R
         xYhXeFL4gNEQyrn0Kbq3jMER6y4Yaht/YfALiAuF41nenHLByO5M+ENzo0v2f4oS92
         axE2I8gBHggEpjwfgNYd0qj081lQEcv1xp8fgSC5c0bk01gbq0/JMqHWyIgjKZSnIT
         OBmjVsq3ESe1/8C5xqXnHHuDrG5ukoXr2YdRDBD5cZ72+twIKdhAHuYKuse7WsxYb0
         uiSn2Ty6JmMVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3A4DE29AFE;
        Sun,  1 Oct 2023 13:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-09-20
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169616642279.6903.15788617870560020661.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 13:20:22 +0000
References: <20230920181344.571274-1-luiz.dentz@gmail.com>
In-Reply-To: <20230920181344.571274-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Sep 2023 11:13:44 -0700 you wrote:
> The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c214:
> 
>   net/handshake: Fix memory leak in __sock_create() and sock_alloc_file() (2023-09-20 11:54:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-09-20
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-09-20
    https://git.kernel.org/netdev/net/c/c15cd642d437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


