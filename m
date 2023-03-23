Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5754C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCWXKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWXKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 19:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99EF970;
        Thu, 23 Mar 2023 16:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE28628EF;
        Thu, 23 Mar 2023 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 087D7C4339B;
        Thu, 23 Mar 2023 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679613019;
        bh=RpKZl9cfpDDFRTiw5ECB24P6zez4Y7DT5psVlUPERBk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XkzGv6Tt4a8ZBg1vlKNYrTfmxY+YdyY5YEwucu+QSAkinlHHhxayznohZs96sYIex
         xzIf2I335eQLE6hBs6AaBU5rkQS4XqwVh1vfJKccswOvJPx7plaG+I4cI5qEbCoCgJ
         I2S8jMcs+/qeR4ZkyPCrx4iiN8borES+ttNPvOzRK0347Dw3idmPMPYf5mKM3nmi/G
         jQtd7WjyYd6C4mxOmTcYBZhWzDPX1tf+K7Y+oBvlyNZ0djdKVP5SL3EazVCTgO8koU
         qJjhQ6dx3Ete1wjdJuAMFBsm5/jqVrNl77crcsPRDItzgdTvlWvbi2n7EOpX5D82Zz
         O3N5Q7eKCX5Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEC59E4F0D7;
        Thu, 23 Mar 2023 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-03-23
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167961301890.6837.12837135622614371884.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 23:10:18 +0000
References: <20230323202335.3380841-1-luiz.dentz@gmail.com>
In-Reply-To: <20230323202335.3380841-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Mar 2023 13:23:35 -0700 you wrote:
> The following changes since commit bb765a743377d46d8da8e7f7e5128022504741b9:
> 
>   mlxsw: spectrum_fid: Fix incorrect local port type (2023-03-22 15:50:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-03-23
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-03-23
    https://git.kernel.org/netdev/net/c/2e63a2dfe73f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


