Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C71EC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 19:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjC2Tvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjC2Tvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 15:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144F768B
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 12:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5945261DEE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 19:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B88F3C4339C;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119423;
        bh=0EB5d0i3b5tyjt1g/JqYszdrgAa3+c1z4P4I8QDbdtU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k1TlDjqx3ZgzIwmxiFATn5rt/EvURBcj3RODTwlK3gavMQgN1C2opLnRvfqm+S4WC
         H69TwERmis8imQVraziJby7STqTkdcX6+5w18I33r+RD9O7wvk0E/hpkgQGsl7UU+X
         9DU5aO0gXXo/NXBuIZyGWkmra77zBPedmhUEIS4o4YBbl0wLLBpGR0Pb7KgywdjatK
         W0OIPLlCxDPDbHFJl4aCmSPT9XslqJIBW6gunWUKdzSU+cwoDP+CHPPp0VjaVs0E0z
         rCInwoHciy4BLMGmx7tg0y7/IdWTJsJSeZNr7C/d9axSoeMO353gOWKxfPkWYHal2w
         GtmPDckk1dThg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A459FC41612;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168011942366.31352.15310894564852597542.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 19:50:23 +0000
References: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
In-Reply-To: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
To:     Chethan T N <chethan.tumkur.narayan@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Mar 2023 11:48:13 +0530 you wrote:
> This patch shall enable the LE States quirks by default on all
> Intel controller from Solar products on wards.
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - Bluetooth: btintel: Fix: Add LE States quirk form Solar onwards
    https://git.kernel.org/bluetooth/bluetooth-next/c/5b23f8375a36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


