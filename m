Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB7CCDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 19:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442210AbjJLTk3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442172AbjJLTk3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 15:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B4BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 12:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184BEC433C8;
        Thu, 12 Oct 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139626;
        bh=7wEmYLUwgBVaYqNYEbWx04sZpL4zzzBFVfD5xBzUad8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ASmVRhS+1ZE6lL0s25+DHhK5nMohHVq6bGB5HVpRpgZbwkeNWzzQwvAcwbyzO0TSy
         JJ2/f6obZmDEWBQMaOl6ehrNu6Bru8+QardH0KZBz0oYAQNP865vkmTDheqwHoA5Iv
         06jHIfE+CxT8RRnPlQRW2uoVqPhMXcn8L1ayDLApkbjyfO8B1eEi+UMHa5VoCknZ9l
         ht1gheb5s+tpICbHNa/cmcDKqnOPU1S9JjLlSAhO87D9+Sb1O97lvQC+X4ItEG3SIl
         Z24OcLkc2fwJ2jXx9CFmh9S0qpcgTeeaIkb7X08o2m7FGL77eZncxoGf/RBKQSOgM3
         T6ltXZ716lIUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED467E11F41;
        Thu, 12 Oct 2023 19:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: ISO: Miscellaneous fixes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169713962596.24492.5763602810655406111.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 19:40:25 +0000
References: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Oct 2023 17:24:06 +0300 you wrote:
> Currently, slave bis hcons and pa sync hcons are marked with the
> same flags, so they are handled the same at cleanup.
> 
> The first commit makes it so that closing all bis hcons will
> trigger BIG Terminate Sync, while closing all bises and the
> pa sync hcon will also trigger PA Terminate Sync.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: ISO: Fix bcast listener cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/5473a1017dd7
  - [2/2] Bluetoth: ISO: Fix broadcast event handling
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


