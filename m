Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7755DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 01:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348314AbiDTBM7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbiDTBM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 21:12:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB018E22
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 18:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62D22B81CBB
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 01:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF9DBC385A5;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650417011;
        bh=PokHpaCyaxoF/Spf6T7I0k7qrOp6zn+PgKXfi7LdSCg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H0GG4zP1nrxbQMim3A5jOCLIBjliBr3z/qn9pGW2cwyQEBRwJtQULCW0sWCF0zfNq
         CO8GbDS5WvmnT+Humr09vXN2is9UVzxU3gGn7QHZnF1g2pYPjMT8V3ZZYoWZngG9oG
         LKaXtuwiL8+7WMFdMhQhWxSnjjMIqP6tH3EpeWtKn890YrjcQSkn0yunLY6fn7EchJ
         PJI+o0ztbnNIMIvv/DSpvBS47DKR45YxB7wDIJTv/ewvQDfF/Hv7WZh8zooVQyHvYM
         tihF0JeDrnhNiCeCRT9/NujTgsnWy6f2/G6AifflwYja5rjlzGSqXfxzbIEbQxQDdZ
         jptvO9dgxcpag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C602EE8DD61;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] settings-storage: Document use of StateDirectory
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165041701180.8238.7357947600929839464.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 01:10:11 +0000
References: <20220419183435.2534491-1-luiz.dentz@gmail.com>
In-Reply-To: <20220419183435.2534491-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Apr 2022 11:34:35 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This documents the use of StateDirecory environment variable which
> overwrites the default storage diretory when set.
> ---
>  doc/settings-storage.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ] settings-storage: Document use of StateDirectory
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=832b594a2505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


