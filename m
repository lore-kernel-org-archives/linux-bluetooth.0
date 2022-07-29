Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8387AC04A68
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiG2AKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiG2AKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762113CC4;
        Thu, 28 Jul 2022 17:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0539C61D10;
        Fri, 29 Jul 2022 00:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF160C43143;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659053415;
        bh=y35Fdgh6FejlYFlfZ6bcds9XoVerdMS3Ft4UlMhbNn0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fg1BrW54kyRZ9oUunTDPFxBcaqKZcqWPnz1aXpYhhEt7UhoRRdbHAwagKzt2fE95N
         /23rb8egnzmOaV6u2Kbvgi12GmuTC1Dh8dtbJeUBpF4+W7xTWgylBaJXo2FChvaGYb
         ZaqfaAtzATZM61GaMKt42t18X8izDtdN13L7qyfM0sLldIVAAlpnaPyiBjfBQpqWiS
         LrtXP7jKaJPH4XucONAbz/M0cnbAANxmefQzx0hx6zd9dSP/Cgl0nr4rPoqKKpzzQg
         vjAFyTpGR1qIrRaiHrDFk65cGEgcs3/Dfxqa6UcTPKGr6tBmU7UhkDWrdSmWOUhXFn
         8H42jb/d99mvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB321C43142;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: mgmt: Fix double free on error path
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165905341489.26440.14880672029696860011.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 00:10:14 +0000
References: <YuAEqGGp/SRNP2Nr@kili>
In-Reply-To: <YuAEqGGp/SRNP2Nr@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     marcel@holtmann.org, mmandlik@google.com, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, mcchou@google.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Jul 2022 18:13:44 +0300 you wrote:
> Don't call mgmt_pending_remove() twice (double free).
> 
> Fixes: 6b88eff43704 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/bluetooth/mgmt.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - Bluetooth: mgmt: Fix double free on error path
    https://git.kernel.org/bluetooth/bluetooth-next/c/b7d8b9c71aa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


