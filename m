Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 14:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiFCOaQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFCOaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 10:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33614C42B;
        Fri,  3 Jun 2022 07:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E31D617B8;
        Fri,  3 Jun 2022 14:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C99EBC34115;
        Fri,  3 Jun 2022 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654266613;
        bh=cL4qE2iRzT0xOYU4TvM0a+oTGcBqs57YFySGH2gBdLs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X3ghMwLRTrutWlHkznIguQRbZvSOmhwBwclAfTOA1T20D13XmOgf2bWLToXG/7HDH
         bUQ2rWFfFzPB7qA2nMwxyz+BFTeseLqD7NR5ye/nFJv0qsK+qiixPHWq16yxojU3iO
         5eN+jkzNi0McebKYxpLog2Zd7MftJffl39QKutVYNnTFyHGbzKy7go/9b8DAUl00Ir
         EOJKHky+evHAzAOXjMftYB+gzDhI0jaAY0QrxzgftwFiJe8R2S63Zl5sDJByDTA+yX
         RaQq8ShvnqD46dYfCuxVlQG3LO0HSCs9vUzVtL0B0R9iXTpEv1oomoVn/Fq3saN3q7
         /JfC2wG85mUnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABA39F03945;
        Fri,  3 Jun 2022 14:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: When HCI work queue is drained,
 only queue chained work
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165426661369.25346.7610455116995225922.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Jun 2022 14:30:13 +0000
References: <20220603081914.42512-1-schspa@gmail.com>
In-Reply-To: <20220603081914.42512-1-schspa@gmail.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+63bed493aebbf6872647@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri,  3 Jun 2022 16:19:14 +0800 you wrote:
> The HCI command, event, and data packet processing workqueue is drained
> to avoid deadlock in commit
> 76727c02c1e1 ("Bluetooth: Call drain_workqueue() before resetting state").
> 
> There is another delayed work, which will queue command to this drained
> workqueue. Which results in the following error report:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: When HCI work queue is drained, only queue chained work
    https://git.kernel.org/bluetooth/bluetooth-next/c/dba7abaead13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


