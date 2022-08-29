Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D2ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2UKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiH2UKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942F24F32
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C83460B23
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E84FC433D7;
        Mon, 29 Aug 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661803815;
        bh=T4wI+4KZAtNJcrPWFbnu6Nc/gJxUp7fkAhJDJb+aRn4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mQYMMT4Xpz8YdeuiBfRcUHTXlsNS4iqVZE3R1TYgHNQ27+LOjarRgH8SRWzQjq7eK
         6f75zXocMWtIzmjHt0asTimaPSwPULJi0BB9f/advRFdSgT42Lm/MkgxImRwN8PwDU
         HM1itkoSx/OdsfE/p4PBFaFMSkpAfo4GV2ZZ+RSj5FfxW3WM2G5WZ8zjUR1aD4SePv
         7W0bq98uuVZXPGG07m6oRQQU5KMi0aNIsmpKs8VlASgnraKgMASUoYcjFU2NYndjgB
         vJL8Nl1noamDxYypwfB7hNas2nuAahF3Su9pJXkoxRKtU3OfuCjyxjAhHzL2p1M0B/
         gl93uL2Q3llyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EB3CE924D8;
        Mon, 29 Aug 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] client: Add missing return statement in error path
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166180381531.25653.11819144642396140987.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 20:10:15 +0000
References: <20220825203903.3526-1-ceggers@arri.de>
In-Reply-To: <20220825203903.3526-1-ceggers@arri.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Aug 2022 22:39:03 +0200 you wrote:
> Client will SEGFAULT if default_ctrl==NULL
> 
> Fixes: 936ad5ef7b56 ("client: Quit when done with command")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  client/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - client: Add missing return statement in error path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b93d958845b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


