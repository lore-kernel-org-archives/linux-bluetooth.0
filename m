Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D3C25B45
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Oct 2023 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJWSWV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Oct 2023 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJWSWT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Oct 2023 14:22:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BB8E
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 11:22:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87960C433CB;
        Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698085337;
        bh=gCocC57bN++I+SiJ/wsjOvqaMIL1UALdkJ9ct+aDoTY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u+XNa7c4aFmAhMKuZUkhTtLo01zVF37FVZ3196QE97s6zSqA3bca/2jfpMpGylkCb
         T1fu3D2T6XKvGXKSEGTlf4xLUwY9EnZykcNNy33ufPrnTP0My4n4ex93JRX9Cn1LBd
         a0/d6fwMAy6IJeuz+a0fZ/FlkXV8rvdPsBfbbaU1VODzwdPin+Uv9Bf/jhU+atBhTN
         2cfRN8wTgCPK/6AM1iDQ1MEBHfQxjXr5+GccDx6tqVNCY71IybO+42xagbgr1xiWU0
         E7uEaVkIFaYK2A4rR3twGB4al8Vy7jTdsWOksAf5CjMpwaXcgies1dM+vW+Ajvdv3d
         1bn7vS7e6yxxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D441E4CC13;
        Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-10-13
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169808533744.4238.5845846756303484819.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 18:22:17 +0000
References: <20231014031336.1664558-1-luiz.dentz@gmail.com>
In-Reply-To: <20231014031336.1664558-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:13:36 -0700 you wrote:
> The following changes since commit a950a5921db450c74212327f69950ff03419483a:
> 
>   net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-10-13
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b10740ce74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


