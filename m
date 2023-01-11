Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8A1C5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 20:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjAKUKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjAKUKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 15:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97E271
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 12:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC50961E4E
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE07C433F2;
        Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673467817;
        bh=HzIhQ0UtLb/l95mpge8Kh8jnOqSKpJMR2WeFL6Psjlc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JOJj6t6LLkg/2Cs8jcC5RsWjI+aJWwtcbdnItNQaEOjU7osmWRkF59N7orRuD7XM+
         JyZqMIZbtEphrFpwAaH5fcHsMlgilc3FaGW+si4ittKgUJ96Bgb/Levru4SzOgi2Q/
         v1xk44bNK9PPicml+2o+a+un+o0+Sd4OEqbGmjorveUiHEo42/+83CC8iUQr53d5TL
         cvY0HXlYfxe3f8oEJpN3O79h6lryiim2xJwCeg+fUT1uns6HL1wjZDzDLwgHhgYES0
         12CsGFIV6Ct6TF5eb7LH+2KvWCvQsg0YoOzfLmNYpeDnZ5mmWiQyugQHjGYCD5Ir1K
         nKeHk9qRMu76g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07714E50D61;
        Wed, 11 Jan 2023 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Fix possible circular locking dependency
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167346781702.28484.10748896819178620223.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 20:10:17 +0000
References: <20230111012254.3724082-2-luiz.dentz@gmail.com>
In-Reply-To: <20230111012254.3724082-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jan 2023 17:22:54 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to fix the following trace:
> 
> iso-tester/52 is trying to acquire lock:
> ffff8880024e0070 (&hdev->lock){+.+.}-{3:3}, at:
> iso_sock_listen+0x29e/0x440
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Fix possible circular locking dependency
    https://git.kernel.org/bluetooth/bluetooth-next/c/489691e98909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


