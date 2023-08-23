Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BEDC3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjHWXum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbjHWXu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086010DB
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E036252C
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1881DC433C7;
        Wed, 23 Aug 2023 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692834624;
        bh=LmS6mMLVGUrZDDOjg+5ERrb8U7u8R5UM2KRxIduho+0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nk9m3LOqgW6SkvU3G9f6hIXvbAYeEk1hVL0O93T5LDYiRoz7iDNu2jtT9Q+pig79N
         LlMRYPB7IZTx/8IQ3ySPw8vHA8JY/X8ZjxkG1AXRflvIY8+LszOZiPpc4owIjPe3sy
         rzJDi1FrYcIb7DkbxaB9kjXmsztTlITKhyAswAHZAHQztT9xCJKJFHF2FqzvQPuA7X
         Pok8UUXhg9FGkWqpx2/MgWy/9j8iY+aMt/qRA/wbuDK5+q59rGKmLX0+seVl1+oy7n
         RatJTtFzcMfS/Yanu1Md4VU47LjJuxdMLfxVFPqKKzRQlZr27a02i30SGf9PagBgV8
         q21bDapQmWcZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFD5BC4314B;
        Wed, 23 Aug 2023 23:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] Bluetooth: btusb: Do not call kfree_skb() under
 spin_lock_irqsave()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169283462397.23213.17051496366715451456.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 23:50:23 +0000
References: <20230823034638.1281539-1-ruanjinjie@huawei.com>
In-Reply-To: <20230823034638.1281539-1-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, hychao@chromium.org,
        sathish.narasimman@intel.com, amit.k.bag@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Aug 2023 11:46:37 +0800 you wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with hardware interrupts being disabled.
> So replace kfree_skb() with dev_kfree_skb_irq() under
> spin_lock_irqsave(). Compile tested only.
> 
> Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endpoints")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [-next] Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/feed554a67ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


