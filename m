Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34729C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDGTlq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGTlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 15:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437B6A47
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 12:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F358651DB
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 19:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD7B4C4339B;
        Fri,  7 Apr 2023 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680896503;
        bh=UXeP8jA2VJLCWMj+LxmO6JcZ2RcDJsLI/X8UfZThR/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WxJW7VOIDAQvfwqdewErUveGrk5mgGYoo259sfRIUA+qH7vBbUbgJjtpNDXMQ3nHI
         SBwxoy6LilUb5ynKwkckfQCyjYe/COdoYxOvISm6HlKVpgyY4TnPV99fXeSnickXGf
         hRbO2QqZtUfBe9s36NvtlLKwo/fpUZj5nX8IBDQORKbzqWTsGzV9VJ2swpGHGmR13q
         4AoZujr1LkJycjvTZI25TU0m15N8riN+ar2nC00PksHiiel7q3HIQE9QbD7kXP2U+/
         RQqnBE1ENxZwLFw1OqdLjjWa/acMWQnIMSk3q0PwkXNIPMHEL84rfwQzCeScNhErFq
         gUi1PiOtky+FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FB0BC395C5;
        Fri,  7 Apr 2023 19:41:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_disconnect_{req,rsp}
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168089650364.19462.11243514647984539590.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 19:41:43 +0000
References: <20230407180201.3229763-1-luiz.dentz@gmail.com>
In-Reply-To: <20230407180201.3229763-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Apr 2023 11:02:01 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Similar to commit d0be8347c623 ("Bluetooth: L2CAP: Fix use-after-free
> caused by l2cap_chan_put"), just use l2cap_chan_hold_unless_zero to
> prevent referencing a channel that is about to be destroyed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Min Li <lm0963hack@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}
    https://git.kernel.org/bluetooth/bluetooth-next/c/cbcb70b9beee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


