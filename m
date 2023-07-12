Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB882C001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGLVKf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGLVKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 17:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7AE1FD2;
        Wed, 12 Jul 2023 14:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B094D61948;
        Wed, 12 Jul 2023 21:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13700C433C8;
        Wed, 12 Jul 2023 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689196225;
        bh=pnILiufobU/rJ+Z0/NTDzLS7q4G7kDmRf8YJsF2aebQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fRB7cg+aXjkRRk5O5DXiWb1yf4WvqPqulJDZdR4N9lR1D1ZDUmTSp/44lqq/G7zAN
         WmQ3BnJvj5xgIbvbpihHI7qlHoqCEGcwvE29piDoCBnC/QyFVvVvvo3+qUeHwRsIsS
         PnBVeCwg6RaUQeWcj8rFHB3pRGzyjyf0QDz2T0mWx1bzsU/aLNzSP25jvoNTMjPPdC
         0Jx5t/dadr+HicCMBXxYhDYkxFSYYQyv6oxUSwJuxGE+XKyTj+jwYftbHoXWwANTcm
         Ck9gwtLNYcfrP66mDPiUf7cTvwkuoMnPD/u8gbTs32+Mkq5wwgplXZ+3ov9k8xGDQg
         kA/diKzP/GHbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F06D1E52508;
        Wed, 12 Jul 2023 21:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_debugfs: Use kstrtobool() instead of
 strtobool()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168919622398.11357.7686000886124475699.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 21:10:23 +0000
References: <58247d1b8105739f0371030a93fb28ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <58247d1b8105739f0371030a93fb28ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Jul 2023 19:41:10 +0200 you wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()
    https://git.kernel.org/bluetooth/bluetooth-next/c/34ffc92ed051

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


