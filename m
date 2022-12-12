Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiLLXAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiLLXAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 18:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE314D27;
        Mon, 12 Dec 2022 15:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3FEE61269;
        Mon, 12 Dec 2022 23:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237EDC433D2;
        Mon, 12 Dec 2022 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670886021;
        bh=pWkydMleKblT4xnk02+nT+1GNSy/ZZ9Y6/Nuobz73Zs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=afzFuhPJhyF/W3N8x4VF/NcJFsx6JCOQZJ0PHMHNkqbbsbDETZkf1+4TDrMi4zXL/
         PTFyYZPYCgZj+u9mkzkATNKb9ZpV0AGEYRDQC/mqBDeW7fIG9CJ+nnkV2Nt8aF15Dw
         jR8/kMWUNvEao+e50WB4LK/CqvbEMBTXMmSKDpm05NUZkv34pbGRVx4F/0B9/px088
         9CNOy9jKGarZ0Gv0FsQFpTMbVAsBRP29FpLTg9YpIKV6Ubx826qqWhG+45PR1NRq20
         2Vjsoss4ly2XiqC0mVnXsy42Ztc44uu8SWUfnWMHQxeQkvAmb1RZaIPcZau1t/SFJz
         0kLkpMtJ/f28Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01122E21EF1;
        Mon, 12 Dec 2022 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2022-12-12
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167088602100.14719.9192068861810724705.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Dec 2022 23:00:21 +0000
References: <20221212222322.1690780-1-luiz.dentz@gmail.com>
In-Reply-To: <20221212222322.1690780-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Dec 2022 14:23:22 -0800 you wrote:
> The following changes since commit 15eb1621762134bd3a0f81020359b0c7745d1080:
> 
>   dt-bindings: net: Convert Socionext NetSec Ethernet to DT schema (2022-12-12 13:03:45 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2022-12-12
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2022-12-12
    https://git.kernel.org/netdev/net-next/c/4cc58a087ddd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


