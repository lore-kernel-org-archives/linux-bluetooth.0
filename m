Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A07C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiKNWKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiKNWKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 17:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E717581
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 14:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF17C60EF4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F6F3C433B5;
        Mon, 14 Nov 2022 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668463816;
        bh=yZWGJlleZe1JxVHmR8nL/KhHs4EkzW3FJZakqP8FDro=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a2PKUTU8d+kaSJjs55ngrO1IMY6KxC1uM3dXSNKB41FqNskogLCQIrUU/iacqWrB6
         WZQ7PEjUGebX1SBQqRSnp+QTZfRtjnQ1rgs7KGVBF1SFJDfn1/b7FtI2JXl0C2tNRg
         jjDFGKd/z7k+kz6h65ulO2Ko/nLUhHEciSw7/4BoBKuDpU0sTp/Mo+OrKaOWCuLHtd
         +c2tdYr8hTM+R+uFVGzICbz5kEiHHgIFMmQVyECL95YRt24h10xxEmPmh0kKNZVq5N
         WoyS90aDu9pJfow5mPX3CDYQr7TxJKj+crylTMH363gci8e/rkEZ9S/rcQgwnGClgD
         Tbpq1a0VhLRQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1403CE50D98;
        Mon, 14 Nov 2022 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] Bluetooth: hci_bcm4377: Fix missing
 pci_disable_device() on error in bcm4377_probe()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166846381607.12666.15812413449033645915.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 22:10:16 +0000
References: <20221112090437.3591380-1-yangyingliang@huawei.com>
In-Reply-To: <20221112090437.3591380-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev,
        luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 12 Nov 2022 17:04:37 +0800 you wrote:
> pci_disable_device() need be called while module exiting, switch to use
> pcim_enable(), pci_disable_device() will be called in pcim_release()
> after probe() failure.
> 
> Fixes: ab80b2cec05f ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> [...]

Here is the summary with links:
  - [-next] Bluetooth: hci_bcm4377: Fix missing pci_disable_device() on error in bcm4377_probe()
    https://git.kernel.org/bluetooth/bluetooth-next/c/ba174481be42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


