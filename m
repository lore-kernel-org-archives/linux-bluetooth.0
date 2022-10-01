Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A34C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 00:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiJAAkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 20:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiJAAkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 20:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93983F19
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 17:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 621C9B82ACC
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 00:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0239BC433D6;
        Sat,  1 Oct 2022 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664584815;
        bh=Lp2qKvDX0odJm7yNHv+04Vvcp1zdjfliG3hNCwDyJ8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fq2k4itSV8bVZ0zf3KSZrd3NuRYBVpbFiKHtFdYzR8JdGUqgH3w31Lmx7Bfrvz8fP
         UhF/+vfszwEAIcfbU4f3yEE5Wt2HAl7MiP7uEGTxkTyoTRLkvBXEonG597Rxl5p0xK
         yL3RxwFyxHefGIxXpXmDYgODAMyg0zdmcOk5HuajaI870xI5DzSZcCsiAENvr876t7
         ZH53TnYmzYh7KgV54JnQt8oKl0X9ddQsNSjWs6RgF4Z1BdULI20iKnrR1B27lQj3o+
         eKMYrkyk8Xj7KQrJ2VWs//xtV6iCjIgxbfaoTfUfZxUnqGBqrUkKZn6HAduGt2aHMM
         Q1SiJrww1F99w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7295E49FA5;
        Sat,  1 Oct 2022 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix user-after-free
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166458481487.9280.13450269965240397959.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Oct 2022 00:40:14 +0000
References: <20220929203241.4140795-1-luiz.dentz@gmail.com>
In-Reply-To: <20220929203241.4140795-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Sep 2022 13:32:41 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This uses l2cap_chan_hold_unless_zero() after calling
> __l2cap_get_chan_blah() to prevent the following trace:
> 
> Bluetooth: l2cap_core.c:static void l2cap_chan_destroy(struct kref
> *kref)
> Bluetooth: chan 0000000023c4974d
> Bluetooth: parent 00000000ae861c08
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_waiter_is_first
> kernel/locking/mutex.c:191 [inline]
> BUG: KASAN: use-after-free in __mutex_lock_common
> kernel/locking/mutex.c:671 [inline]
> BUG: KASAN: use-after-free in __mutex_lock+0x278/0x400
> kernel/locking/mutex.c:729
> Read of size 8 at addr ffff888006a49b08 by task kworker/u3:2/389
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix user-after-free
    https://git.kernel.org/bluetooth/bluetooth-next/c/35fcbc4243aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


