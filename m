Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1DAECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiISRaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiISRaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E71CFC1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCE2615F8
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 17:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB28C433D7;
        Mon, 19 Sep 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608616;
        bh=48ePgsw+46qV4yHihCNPg91nmcMTeUltXkR0/3095ss=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mM/9cihfPC68it6iHfYwkWeVts5CeCe+xTC3ddKbPtV8SkE0rTuBkbhNMeWX93NCq
         IzwIDRp3psWdUEE/X1McCtclgRPB9k7mMcKNEMTJicr1UzFQF2GbgaSfy7wrUavTU1
         9y1W/pLQ5pciJs1Eg0Cw6ZL56wRpX/thHOQO/vMQHxdb5DVf4jPZSdVw87yIbO+7l+
         ejC3bhBwoTyZUOZQ//78EXnyu4HbXJnnY+Cu8t61TvkcGlDdgbTXy00jcpmJuXIa+P
         DI4k4ytoQ1nGFaL8aPiVWcWfhbcEYgrgFO4JbupCJoQMufu6qMC4sqMmSKGQVpd/hh
         HToBrup1mZ1Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94F72E21ED4;
        Mon, 19 Sep 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166360861658.29822.12630760382749336060.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 17:30:16 +0000
References: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
In-Reply-To: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        schspa@gmail.com,
        syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, jiangshanlai@gmail.com,
        tj@kernel.org, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 2 Sep 2022 20:23:48 +0900 you wrote:
> syzbot is reporting attempt to schedule hdev->cmd_work work from system_wq
> WQ into hdev->workqueue WQ which is under draining operation [1], for
> commit c8efcc2589464ac7 ("workqueue: allow chained queueing during
> destruction") does not allow such operation.
> 
> The check introduced by commit 877afadad2dce8aa ("Bluetooth: When HCI work
> queue is drained, only queue chained work") was incomplete.
> 
> [...]

Here is the summary with links:
  - Bluetooth: use hdev->workqueue when queuing hdev->{cmd,ncmd}_timer works
    https://git.kernel.org/bluetooth/bluetooth-next/c/deee93d13d38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


