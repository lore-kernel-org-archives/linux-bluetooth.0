Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDBC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCNTu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNTuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6810B158B7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22FD4B81BA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB1D4C4339C;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678823419;
        bh=r5XQa5RvsHbuS78M4uL/Xa/NQ/RpYrD5o3RwxQlvIaU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PjaYvBFOrhZuzbPxUNY3gwGhmnprIfU7jC16ok9/b3rUbnQxqJeQdQk+0pxpQxBex
         gTbJk3Fo7APcryUetZcaAwAeKLktjcyXWpFeylfnd/LIBvOggnKseZZK6/pbpubS+v
         K+1lsMqebKpxodemA5NbCh3i7zVmQIHtL7puj9vZGu2kBFBs9aQ+HDe2RNb0KRcgQg
         WQyNCSu9zRWChfgkTUz0eoxlOdAON9Qurn9tRMuLxdedzLewR/Ow4bfgYTytMDBP3X
         YluWpiKWVw/JwQ6YdQ0sHlP0p7EVZkV3ILAybQjC3wxJuzOcj4P1MV/QrW0zXhdtH0
         bXsfRamUvhH9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 954BFE50D65;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] Btmon: Fix handling not complete packets
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167882341960.5310.13189620230834104699.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 19:50:19 +0000
References: <20230311233640.103858-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20230311233640.103858-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?q?=C5=81ukasz_Rymanowski_=3Clukasz=2Erymanowski=40codecoup=2Epl=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Mar 2023 00:36:39 +0100 you wrote:
> When for security reasons or any other, packets in the btsnoop logs are
> not complete, then Included length is smaller then Original size.
> 
> For the moment, Bluez always assumes to get complete packets.
> If it not happen, then it stops decoding after fist packet which
> Original size is bigger then Included lenght. e.g.
> In the file where we had some ISO packets but with payload = 0,
> btmon ended like that:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] btmon: Fix decoding truncated data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ae44c74aaf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


