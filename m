Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EAAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 May 2022 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiEWVuQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 May 2022 17:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiEWVuP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 May 2022 17:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21179FCC;
        Mon, 23 May 2022 14:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F18161523;
        Mon, 23 May 2022 21:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9105AC34115;
        Mon, 23 May 2022 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653342613;
        bh=B7PqofgKRAmGuJm4x1MAU+rWOBg5MMmRoo8+jyNcSZo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MH7aEKXPlXIXVPkIgxZ3N0DF9EtdI2CZYul+GvJIJDO9fjGR1xMLC6dwHDX72EkMm
         CkbsohcWst+eS2vrfAhfCFkiyCgc/VSAE3GNVbGIIZp1NaaubEbpLpUhFtkszbJHzV
         bZtk6qQRkbvzsAZ3NhDqphT0tdwpzfVEkbQGEDHWJ0ZFXLnErtwpjn+cOQe/MPs6ES
         j7VGy+CY1Edg+VCEtP5Kl00qaPivmmwHGG3q3G15gKSqaSu2UhcqSybxxXf1SZrmuT
         5eDWUGSG31CJAHOqAZoWsRIFYDgxlun+N6Nhss/edTwREJxdRw+7JiMSmMrNNSz9R4
         44bJwtE17CEaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73A54EAC081;
        Mon, 23 May 2022 21:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2022-05-23
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165334261346.27567.16619263163153903951.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 21:50:13 +0000
References: <20220523204151.3327345-1-luiz.dentz@gmail.com>
In-Reply-To: <20220523204151.3327345-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 May 2022 13:41:51 -0700 you wrote:
> The following changes since commit 49bb39bddad214304bb523258f02f57cd25ed88b:
> 
>   selftests: fib_nexthops: Make the test more robust (2022-05-13 11:59:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2022-05-23
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2022-05-23
    https://git.kernel.org/netdev/net-next/c/b1e6738a2185

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


