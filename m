Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C92CDB483
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 16:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjJQQk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Oct 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjJQQk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Oct 2023 12:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AFAAB
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Oct 2023 09:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4458C433AB;
        Tue, 17 Oct 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697560825;
        bh=4+jP/eFCGMbvP+43pT0m0aTsPT52PQDtEdTV+HMgxuA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JnpdVeTga5TyRQbsFtQ5Y+zNXwbol72w5fRTh/hOTGcMNAfxIC6agCc4pRnejZRts
         Rl1k+W3lAFUDLZqiq7Muokvx46Tt5zrGpYg2jExhRfXqi+wVLjPIHvpqPq15wlHu4L
         b8q/ID1Hd0+011fH5Bf+t1o18iu73GkfhQVfWwlcElHufrR391MjbkMySy7jJv/fY8
         gpEs3h0+b7a6zF1mGhPhDsRvt7Rhwa8eUzUofYv1Gmp57hbd04IjTMjAu0H5t54s6a
         44XMrljYNBWZwquUbaVSkbOvJw8c9arpE2EMUczlG3SZppLVeRWOKPb8GpAULDdIcI
         V4zyoKSRQsk/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF46E4E9DD;
        Tue, 17 Oct 2023 16:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mesh: Fix check for active scan when using generic
 IO
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169756082558.3529.13485872109332370256.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 16:40:25 +0000
References: <20231017002123.43533-1-inga.stotland@gmail.com>
In-Reply-To: <20231017002123.43533-1-inga.stotland@gmail.com>
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     brian.gix@gmail.com, luiz.von.dentz@intel.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Mon, 16 Oct 2023 17:21:23 -0700 you wrote:
> This modifies the check for an active scan in generic IO:
> the bug has been introduced during earlier code refactoring.
> 
> Fixes: https://github.com/bluez/bluez/issues/625
> ---
>  mesh/mesh-io-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] mesh: Fix check for active scan when using generic IO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c757e8eeef6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


