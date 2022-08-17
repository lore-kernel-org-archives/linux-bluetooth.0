Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E483C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 18:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiHQSwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiHQSwb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 14:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE2A3D69
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 11:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A06E661445
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 18:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06F9AC433D6;
        Wed, 17 Aug 2022 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660762349;
        bh=snVhvXy2J9yUvvHYp35gxzFejq7aXtf522B3htlu+so=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FQeRZJ8XNw42iAuCavRpic+fY+0t4/0rebBwHiBI4Hcw6Syjcz3oNrYkxg/xYLoTu
         193nhL1R5Ebv27nAC0e6/si0OmiaTBPQSCfCWkLH9VIbtTb0Nbnb6vxiq5fAmO2FP7
         Gxo0HuwSO4r/KQbr6zWJxEnucwDfjUZcClmm0cA/Q1n8p2FmBc13qbGPMfgM6pX5gH
         DbuEp6IoX54hEEZjBpHd408O+/mK1jTNQKiv5YwMBlrLcDJkfqQSgd00XYM4supfQn
         MXdQJwsgFwWvtvaegWNw36xbkdoKIjjbwWg4wal+7GZkIRS2NBHX74QU3N9ZI5Z4Y0
         dZThNZwM5Q3Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8AD2E2A052;
        Wed, 17 Aug 2022 18:52:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix suspend performance regression
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166076234888.20898.12412192646011139658.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Aug 2022 18:52:28 +0000
References: <20220811212435.273142-1-luiz.dentz@gmail.com>
In-Reply-To: <20220811212435.273142-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Aug 2022 14:24:35 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to fix suspend performance when there is no connections by
> not updating the event mask.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix suspend performance regression
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e9f7d8bd56f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


