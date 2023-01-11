Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CFC54EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjAKUK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjAKUKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 15:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD63276
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 12:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE41A61E4F
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30B4BC433D2;
        Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673467817;
        bh=k37/30KPvcgEaBPuOhJlszLmViJfQFBC0Npt4kb4t4E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZWSY2+CYOkbBSd7lK1zWewBNiFCrk4TB/6RJWODxU03dprM1wmhcXbu1d5UGip8KH
         gf1X2GsXObhRW9+Ga/APmS+4I38bx08eMMa9Sf6TIMOj+OQY0Aj5MRhWWas+Ei2J32
         9Gzl5qoyhqB3PEl6Eh1aMCXw/40B/YqJxesC7ltT0VOEeGYBKOhkSV1XbEqQR1rejk
         cv0xJgjJcy79M9M4sb7XxLKtsD24pijR/j1IZekVbUybm6Jl4prgtuROr64OvSScg4
         G54KvrE2s7kXh8Oxrx6C51zuHd593ARPABvMrfrq301QOop7lKaScZIB0ETE/8FlUX
         v16xInPHTXlyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FBF8E4D026;
        Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Fix Invalid wait context
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167346781705.28484.3986664007099253159.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 20:10:17 +0000
References: <20230111012254.3724082-1-luiz.dentz@gmail.com>
In-Reply-To: <20230111012254.3724082-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jan 2023 17:22:53 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace caused by attempting to lock
> cmd_sync_work_lock while holding the rcu_read_lock:
> 
> kworker/u3:2/212 is trying to lock:
> ffff888002600910 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at:
> hci_cmd_sync_queue+0xad/0x140
> other info that might help us debug this:
> context-{4:4}
> 4 locks held by kworker/u3:2/212:
>  #0: ffff8880028c6530 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
>  process_one_work+0x4dc/0x9a0
>  #1: ffff888001aafde0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
>  at: process_one_work+0x4dc/0x9a0
>  #2: ffff888002600070 (&hdev->lock){+.+.}-{3:3}, at:
>  hci_cc_le_set_cig_params+0x64/0x4f0
>  #3: ffffffffa5994b00 (rcu_read_lock){....}-{1:2}, at:
>  hci_cc_le_set_cig_params+0x2f9/0x4f0
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Fix Invalid wait context
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd18e1680ee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


