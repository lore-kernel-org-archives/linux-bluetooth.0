Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Dec 2022 01:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLJBUV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 20:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJBUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 20:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672657B4C
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 17:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B475CB8282B
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Dec 2022 01:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DD22C433F0;
        Sat, 10 Dec 2022 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670635216;
        bh=wPHLPsDmE0Wr/xm0VP+GLp7mRakgVeK4F8FyfqDLqAc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dl2w3sth9FpkwBLiesysetpxQvfed9IvCkyilsWlUa0h8dpqNOKMZL2DJ8xlWru/f
         f8VjyHgb+ovs2p99t6Q8fvPjy3Knl1twWctoiuNWm/hliTISLvkUNSFD3gYc9VZCAO
         aBU0FRQJEhv3xdP4BlhqRfj+bzjvcfW5Nf7TNz6mImXBa29/P9AUIMMM3x9Amw1b10
         T5ZKNLY5ZGqAERb4yBWjLCzmWo5XWnhmYt8KdVLouKonlnJzj4y6iMS064AKsCK6P2
         HIiZiL4DXaecMwoFvJ5g7EQDhFBLP6/92tGK230y7zD+0PsFqTa3L0198TI5HwdNEd
         6XATTPjsj6I5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B914E1B4D8;
        Sat, 10 Dec 2022 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Avoid circular locking dependency
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167063521609.12528.12154792095768076354.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Dec 2022 01:20:16 +0000
References: <20221207013501.4162096-1-luiz.dentz@gmail.com>
In-Reply-To: <20221207013501.4162096-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Dec 2022 17:35:01 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to avoid circular locking dependency between sock_lock
> and hdev_lock:
> 
> WARNING: possible circular locking dependency detected
> 6.0.0-rc7-03728-g18dd8ab0a783 #3 Not tainted
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Avoid circular locking dependency
    https://git.kernel.org/bluetooth/bluetooth-next/c/9e5cfe86387a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


