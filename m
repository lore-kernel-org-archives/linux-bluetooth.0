Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE9C63708
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLGVUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Dec 2022 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVUe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Dec 2022 16:20:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588454E402
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 13:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AEE2B82150
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 21:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE6EC4314B;
        Wed,  7 Dec 2022 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670448030;
        bh=S1kx/LFeyIuXBWr3wC4DWo1GS3Cxn7znnqqWmg3W6FM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mzktbzd8TxYTQMgfq05Je1atDZLOzhm7uFTGuVyrsi0wC0n/8n8KJ1Wq1ACdDhSiK
         AAkVHKF6y+rxOLGp6Kn1y4DO1HoG7KQuRjvtEKQvhRDTx7tJ4PY9g2keBfIJ8EtaET
         S/XxR5NQAtQNnRCbEd75fWnds5bFsIH/KtME5jAUX/mLmOn9P/aEHL5aQeuFYFTw+S
         Ww1JuawdvwRXm4mi30ufguFWFctkcECzvUnO0kL0JlJ04eCN7CCyy2SSsN0LQNGVDn
         6jPdfmL3fJ2xqo5dbWW3V92cCLRHzF3/EimzJGtPQNTChaK2Yo9z2fyMq7CpCQ5XzA
         +PYsEltZRbs3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AB2DE29F38;
        Wed,  7 Dec 2022 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] Bluetooth: don't call kfree_skb() under
 spin_lock_irqsave()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167044803056.32577.14108869575726101767.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 21:20:30 +0000
References: <20221207021835.3012559-1-yangyingliang@huawei.com>
In-Reply-To: <20221207021835.3012559-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 7 Dec 2022 10:18:29 +0800 you wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. This patchset is
> replace kfree_skb() with dev_kfree_skb_irq() under
> spin_lock_irqsave().
> 
> v1 -> v2:
>   Replace kfree_skb() with dev_kfree_skb_irq().
> 
> [...]

Here is the summary with links:
  - [v2,1/6] Bluetooth: hci_qca: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/53a3dd1fe59f
  - [v2,2/6] Bluetooth: hci_ll: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/1813c380e222
  - [v2,3/6] Bluetooth: hci_h5: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a1e7f617bc0d
  - [v2,4/6] Bluetooth: hci_bcsp: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0935d021bde3
  - [v2,5/6] Bluetooth: hci_core: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a3381581499f
  - [v2,6/6] Bluetooth: RFCOMM: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/894e4bc8d807

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


