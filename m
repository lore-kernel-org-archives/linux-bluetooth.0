Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF20C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLPAaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 19:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPAaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 19:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207C1AF2F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 16:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7365CB81B58
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 00:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15813C433F0;
        Fri, 16 Dec 2022 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671150617;
        bh=twRqghigB53tzmP8cga4oxUhp/5pCZg3TeLD4yNdcFQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JVuiqBzy6zErOKe197mddM22ceVFD580GGFsfKUjZ+z1Lzqo7VFbkSsGHEStOB8XY
         +rrxxxcCXbqzLGssEUTPW2/e12GZJAo5a316Ljhym+yb1yYvLneRrqi5KXAEDpLxE2
         hoo4W4Cj2O/NHCtAc4eP0Yovp+67j95W/fESZBs8Afob21/RM3dhzWILBKBXecs1z7
         5MP3Zs1bVyn01TL4LiZklo9N0D/r2TVJO0Nv0tz2cuuX4pP/lal5BiWa8M5WBqgWai
         o0dLmzqnFGqHi6O/KFAobKWY6Dud0aXxBcU5rziEi5NwdJ1kcqcX06Hybh6+pvmsu9
         prUmtpXeVzB8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F40CEE4D028;
        Fri, 16 Dec 2022 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] client/player: Make transport.send non-blocking
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167115061699.13704.7726371644356520264.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Dec 2022 00:30:16 +0000
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Dec 2022 13:10:33 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes transport.send command non-blocking by using timerfd
> callback to initiate the transfers.
> ---
>  client/player.c | 205 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 138 insertions(+), 67 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/5] client/player: Make transport.send non-blocking
    (no matching commit)
  - [BlueZ,v2,2/5] shared/shell: Add bt_shell_echo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b8c87ccc248
  - [BlueZ,v2,3/5] client/player: Use bt_shell_echo to print transfer progress
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e51d6c5f2e51
  - [BlueZ,v2,4/5] client/player: Print transport progress
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=318b1a19cb74
  - [BlueZ,v2,5/5] client/player: Fix transport.send/receice tab completion
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1270afa5aa1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


