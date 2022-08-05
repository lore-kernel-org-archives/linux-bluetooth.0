Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92FC25B08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 22:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiHEWUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiHEWUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 18:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDFF52
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 15:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8897060C3D
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 22:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9A1AC433D6;
        Fri,  5 Aug 2022 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659738012;
        bh=E5qQSi6Zy9ok8loNBFzDOPkKuu06Mq1pC3QKmZhsPwM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iQ4PnpnkWF6QazlKh9bxdgdnLZ5+BUa5cz0TolN716xsWyc9dEH2NBuX1d28m8WbP
         8A5eFUwC5k8+2Hg5ka+NdcHhRZZc1nt6U3hQHzWbc/mOYsEu2+b/fv1dlsQ14TLrSh
         E1Vzy5jrGNYTSR0vtAOvryQVlEWlgU5hdPGocYD7VKmI44nCJpn5JX4IGhjQLxSIC6
         BJ+T5pEMkG6/7ml+1lSKjGIrdDDmkfGgnxm6KcEMm1SUD/KxbUT+0bIF9DMAphxDob
         PigmOR4fOSFqqpjNHjV+oxUsIyHCLEN7hEy2tiM3KWPKN35IF9qeOUPPbpmi4ujatD
         p4FLh+bedgHaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA2DC43142;
        Fri,  5 Aug 2022 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH (urgent)] Bluetooth: don't try to cancel uninitialized works
 at mgmt_index_removed()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165973801277.7863.14272701506314358950.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 22:20:12 +0000
References: <244af2fe-5340-9e63-a354-d5ab7d155dc4@I-love.SAKURA.ne.jp>
In-Reply-To: <244af2fe-5340-9e63-a354-d5ab7d155dc4@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     brian.gix@intel.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 5 Aug 2022 16:12:18 +0900 you wrote:
> syzbot is reporting attempt to cancel uninitialized work at
> mgmt_index_removed() [1], for calling cancel_delayed_work_sync() without
> INIT_DELAYED_WORK() is not permitted.
> 
> INIT_DELAYED_WORK() is called from mgmt_init_hdev() via chan->hdev_init()
>  from hci_mgmt_cmd(), but cancel_delayed_work_sync() is unconditionally
> called from mgmt_index_removed().
> 
> [...]

Here is the summary with links:
  - [(urgent)] Bluetooth: don't try to cancel uninitialized works at mgmt_index_removed()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0659969095f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


