Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF4C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 20:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIZUUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiIZUUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 16:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF14BA6B
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 13:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4180612B8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EC8C433B5;
        Mon, 26 Sep 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664223616;
        bh=kD7qJ7RrkD4KTL+HsUXRLnbPKOKHKXPpNl2jTGfSs/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uD1liidcBB4/zOWyaQduwyUSTs9vaGsoldXMFAATUb/T782rfXNiiAP0Jgr4AeExd
         W/jd6pBy9bPVGOtcj7AKAqbvYGQ8JNCRNDWStwe82oUn52IDMQ+FilkwiXKk1llMej
         bmDmgbN864+SLznuZy+JHmlSjD8mrckg64Slhbcz5VC5AiK1BB/fCVhtBejdB7p/3z
         qgjG73G+5nEi+hjbqXtEdUqBCVRHcKIEyOGKFxbXHJWYh5N0+0+3/jVUQoRygdQsiA
         5gO1M8O4nQ6wXeVA+vldm5xOnf79j+k27CknW5vmVgfNZfqEolE8axA+WLQxK9wPEU
         Uw12tBkTPp9EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A71C070C8;
        Mon, 26 Sep 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Mesh: Fix heartbeat publication/subscription
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166422361593.9012.15598409160746667095.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Sep 2022 20:20:15 +0000
References: <20220926130110.2146-1-isak.westin@loytec.com>
In-Reply-To: <20220926130110.2146-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Mon, 26 Sep 2022 15:01:06 +0200 you wrote:
> Hi,
> 
> These patches include some fixes to the heartbeat publication and subscription procedures.
> Found during following PTS tests:
> - MESH/NODE/CFG/HBS/*
> - MESH/NODE/CFG/HBP/*
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] mesh: Correct u32 to u8 log transformation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b569e3d14a3
  - [BlueZ,2/4] mesh: Reply to HB pub set with same fields
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ef221ca0205
  - [BlueZ,3/4] mesh: Correct HB sub state updates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=902389f3e7a3
  - [BlueZ,4/4] mesh: Clear HB sub status field if disabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d763bfa4d089

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


