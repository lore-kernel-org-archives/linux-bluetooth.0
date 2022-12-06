Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B8AC4708C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLFRuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLFRuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 12:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66E209BB
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 09:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9596BB81AFB
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E2AAC433C1;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670349017;
        bh=FhV/sR87xrTNgXWx0sYeX2lVssRl5mzGqIF3TaIC140=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GUZCoTWW8LVFzuX7ZCOoSZBO8lT7Qh5C+Vvy5niRiPofqcJqH6W8zXBuX5qzqzUzg
         y5OL10wOeeJVR4cdpJX6eiUI0dL5HGn3KvRNi+e5AN/iDGzHwmcoYfUSSC8YLyMVen
         3gvje/IfTWtEFPpIpQCmRV0LNYU7PtLiZiK74QISQf6vbjmVXmj0+qCP/FRObszPZX
         5uJZdmgM9RinG7EbIheW7uOT3TS0w1xCTtVtAKkuluaKSdUdiNLUv/3DXH5CpUFCP0
         YeR0oxRBl2i/pPqXMCDLUpcDZ2z/9iIS2ZuW9GoSqOvIfdN7aTGTfrfrOgyMEAx8WE
         7uWsnIgGwG0pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35277E56AA5;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: don't call kfree_skb() under
 spin_lock_irqsave()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167034901721.25798.9447572227827738583.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 17:50:17 +0000
References: <20221206125910.2170554-1-yangyingliang@huawei.com>
In-Reply-To: <20221206125910.2170554-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 6 Dec 2022 20:59:10 +0800 you wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So replace kfree_skb()
> with dev_kfree_skb_irq() under spin_lock_irqsave().
> 
> Fixes: 803b58367ffb ("Bluetooth: btusb: Implement driver internal packet reassembly")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: don't call kfree_skb() under spin_lock_irqsave()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0dff4eccb2ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


