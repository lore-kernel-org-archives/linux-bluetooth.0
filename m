Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F545ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiINUK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINUKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 16:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB91160
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80E5F61EDD
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDC78C4347C;
        Wed, 14 Sep 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663186215;
        bh=stVRc1yS+SOK2i5XhtLCYosmNa7H/zyiLN+LsWBTwIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b11CITgF1WHzIJmEV9yPJE5FCYnDLVzgH3TIXs96emL/a5opvbH+jJgv9iu9zVaaO
         AAbP9NGKN4tFlFqS551wuedO2Wz8ORESszIsagHpeGX3e/5x57FPjsS4VdkOZoKy6M
         Qu3sbqfaASPhvaJlAIZphyhLqBCyHmFidmZlvhwxRTMFazixopdnOKoNBX/hw8K7ec
         +XJdWLE3loJfCYSw+mXsEBTWSwi+OMAVp+dfEwYHQ2qh+euscDmg5rhA1yUje2xKME
         HAJKaqMdAkBhsuGTCTq+rr93j7K8OjQgEdxhp7a+nWBBflx6b+skfJZUPuZH+vnT07
         SyoPrxol2/oow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9E8EC73FEB;
        Wed, 14 Sep 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: avoid hci_dev_test_and_set_flag() in
 mgmt_init_hdev()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166318621582.18930.5263572054834552054.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Sep 2022 20:10:15 +0000
References: <f6de02d1-dcda-0383-739d-27484b4d5c63@I-love.SAKURA.ne.jp>
In-Reply-To: <f6de02d1-dcda-0383-739d-27484b4d5c63@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        syzbot+844c7bf1b1aa4119c5de@syzkaller.appspotmail.com,
        linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Sep 2022 01:21:42 +0900 you wrote:
> syzbot is again reporting attempt to cancel uninitialized work
> at mgmt_index_removed() [1], for setting of HCI_MGMT flag from
> mgmt_init_hdev() from hci_mgmt_cmd() from hci_sock_sendmsg() can
> race with testing of HCI_MGMT flag from mgmt_index_removed() from
> hci_sock_bind() due to lack of serialization via hci_dev_lock().
> 
> Since mgmt_init_hdev() is called with mgmt_chan_list_lock held, we can
> safely split hci_dev_test_and_set_flag() into hci_dev_test_flag() and
> hci_dev_set_flag(). Thus, in order to close this race, set HCI_MGMT flag
> after INIT_DELAYED_WORK() completed.
> 
> [...]

Here is the summary with links:
  - Bluetooth: avoid hci_dev_test_and_set_flag() in mgmt_init_hdev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f74ca25d6d66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


