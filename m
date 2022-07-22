Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73072CCA489
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiGVUKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiGVUKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564D1BEB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BEA61FFB
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C5CBC341CF;
        Fri, 22 Jul 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520615;
        bh=ZYavhtnUcBHIl7Ii5ocGoAxOVtQFjyD+6/BJMYSzN80=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S2ZDQkJ7FNMSUHX4Cq9JvTbG2bY5K2TP8EURsYmB6+lh046A3Bzcx+ztx/cu0MeOX
         XokuA0YZFGzz9/QnqkctoYrgJRuDX1bdT/yK2UItrXWqQZCT1MRNFslziiB8AWZwUE
         bELJ01uBFKXSza+KntpxPBOXXWkNp1m0O1uiRaZ2r4JPx37CCilqlk2Co3wTMZRLc1
         OdX17oq7Sp3s22WUYP9KkJVGjxpQhuXPzUeQgV053OuJZ9zWmME0CATzuA7eUDbl7h
         7jyiLGq5r/JZSt0YmuAh/mCI1ktcGqjPYjf9CnBKKQS2nlkX4EEfUAmytpDQoMKVbg
         xvAjA4qAdyHIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 690F9E451BC;
        Fri, 22 Jul 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Fix typo in comment
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165852061542.17882.12865724233617050236.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:10:15 +0000
References: <20220720141033.12521-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20220720141033.12521-1-dengshaomin@cdjrlc.com>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Jul 2022 10:10:33 -0400 you wrote:
> Delete the repeated word "that" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/bluetooth/btrtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: btrtl: Fix typo in comment
    https://git.kernel.org/bluetooth/bluetooth-next/c/38f230f1f910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


