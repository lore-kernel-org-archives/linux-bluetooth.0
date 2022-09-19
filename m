Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEEBECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiISRkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiISRkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6B36874
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978CB61CF3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 17:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA004C433D7;
        Mon, 19 Sep 2022 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663609215;
        bh=d61BfuvGi59wAnDrAOjyMSfxq6oA3dSeBpNOtIfxcfo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TJtR+CESKfoxqZagkLGNt+QtQ4x0W6yslOBwcE0JoHTpJZDngGr05LSUdAG6jvAq8
         ivQ7y/3cBK4s+P6DnKZSIaM3VoTbuPMH1EejVroMhEikddDYEsvxG2c8hyEwPKS5B2
         G04iE3j3St2m7pa9w6F3wH5a+TBNAlOmyVL1tT8Rk2DN3yGbt5vNVbq1BKq4e+rMHM
         gVjpzwfrG7w8psVoiMvpzYx67aJr/wkpmNKK+Em0mKoR867SgtIlFYnhz0lGwjjbW2
         GKEfqWZFsMn/d/8p8TXqgpe2dWZiVR/UCIXR/OFGpIf/wSjHaX72bq0CHhmBfv5v0K
         Kx5mmEn2nS+Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE08DE21ED4;
        Mon, 19 Sep 2022 17:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem()
 failure
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166360921484.3099.15829097107385180514.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 17:40:14 +0000
References: <376d3dd4-725a-a212-2701-09a80b7d3915@I-love.SAKURA.ne.jp>
In-Reply-To: <376d3dd4-725a-a212-2701-09a80b7d3915@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ronald@innovation.ch, lukas@wunner.de,
        syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Aug 2022 23:58:12 +0900 you wrote:
> syzbot is reporting NULL pointer dereference at hci_uart_tty_close() [1],
> for rcu_sync_enter() is called without rcu_sync_init() due to
> hci_uart_tty_open() ignoring percpu_init_rwsem() failure.
> 
> While we are at it, fix that hci_uart_register_device() ignores
> percpu_init_rwsem() failure and hci_uart_unregister_device() does not
> call percpu_free_rwsem().
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem() failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/3124d320c22f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


