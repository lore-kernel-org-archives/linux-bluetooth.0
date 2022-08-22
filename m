Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3AFC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiHVWkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVWkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5143450719
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21336135F
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 491D5C433D6;
        Mon, 22 Aug 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661208015;
        bh=NuVrfbRzOsSQRrd1eKQsLZpf2nkuaLw7spTeE5zQkdc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SXCwSU38eAgYEuXO3Zac75+IK/PDHOYu5ChAdSf+wQZHwnGDgUuWv0yc+Pkwj/DtP
         4V3+F0/k4hE425nTgzpOP4qwu+SBDzk9ku6b8gT7S/0sEqX5R1roGw93RhupVvyH6V
         bsaH0X4vhJRLDM8Kw5HiXf6rWRgmg9mBjB+/Hm3qfGKIUIIMBDyzB3593C6gnoEVuT
         ePDd7puuAYbDfZYmenKo9t3PIEDgp8lXezNmg+RV8cohqeRVlLfm5Fi//xNNNcigx5
         U55p5WrtfJ5XZ3GqHaj+or7OpuKuKuzahBPyhjiNzqd2mQSbSCgh3+HEqM/Vy+lu5Z
         Jhbx4EGEjXq5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 240F0E2A03C;
        Mon, 22 Aug 2022 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bthost: Add destroy callback to bthost_add_iso_hook
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166120801512.10027.17903736832508528637.git-patchwork-notify@kernel.org>
Date:   Mon, 22 Aug 2022 22:40:15 +0000
References: <20220822220025.541691-1-luiz.dentz@gmail.com>
In-Reply-To: <20220822220025.541691-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Aug 2022 15:00:24 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a destroy callback to bthost_add_iso_hook so its user can
> detect when the hook is freed when the connection is disconnected.
> ---
>  emulator/bthost.c  | 8 +++++++-
>  emulator/bthost.h  | 3 ++-
>  tools/iso-tester.c | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] bthost: Add destroy callback to bthost_add_iso_hook
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5bf220eb3b86
  - [BlueZ,2/2] iso-tester: Make use of bthost_add_iso_hook destroy callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=081897da74f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


