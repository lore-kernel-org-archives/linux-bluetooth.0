Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D41C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 04:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiCEEBD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 23:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiCEEBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 23:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C148880;
        Fri,  4 Mar 2022 20:00:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21AA760BA8;
        Sat,  5 Mar 2022 04:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 782AFC340F2;
        Sat,  5 Mar 2022 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646452813;
        bh=RYRoCc0u1T6iMc/DZso69zPDghopuIsRjhZ4Ctd1wjs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FothVqxpJjTTvlPa2WLyERgX/9/9T0VIiBgWZh2Bn6VRJN0nCAz4AsbKfclT6b7nD
         uldoMTJ3/akL3mvuzvLlrFyGLmr+5YuXoFv/qaksrmZmp6zhy48wGc1iZxUekD58am
         o59aUarMkUIYBNrddKiHf8hj3PzQx7b++8Kaz+ij9DpKS3ALmEv2Jb3c5WmzETpMZE
         CTXKWxI8mqk+LBwtLbpGiZHFR+EzAaD/0Uc6ivyAnaprEV6stcLTTfWlbZDabQb5qI
         1FPvNbuAu2PwaWjAneu1AfeI/L/nZA6fs6lVKcH9JWC+hyO6Yg6I84XKkFRAOytw4f
         ywU/Etb320ffw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49666EAC095;
        Sat,  5 Mar 2022 04:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2022-03-04
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164645281329.6499.15953012485641203766.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Mar 2022 04:00:13 +0000
References: <20220304193919.649815-1-luiz.dentz@gmail.com>
In-Reply-To: <20220304193919.649815-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Mar 2022 11:39:19 -0800 you wrote:
> The following changes since commit 1039135aedfc5021b4827eb87276d7b4272024ac:
> 
>   net: ethernet: sun: Remove redundant code (2022-03-04 13:07:54 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2022-03-04
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2022-03-04
    https://git.kernel.org/netdev/net-next/c/2bc0a832fad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


