Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFDCCA480
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 16:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiGTQUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGTQUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32CDED8;
        Wed, 20 Jul 2022 09:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08AE161D73;
        Wed, 20 Jul 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 633B4C341D2;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658334017;
        bh=Eq1CrZBYHVgUb8wkqf7U2YxMfT3RrB/v/kRt/ZdO6a4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uqFvl2SIYVZrr50cCP8ivcJgSy8qNpLzifYGLWDtJbiia0m7b7vkCMWaH26/KyxsA
         GptKiGmbLHnRNGe9AZReKo8aUq2KkS1Ht2oDSYF0OSdlF5vKJA6a6Vl/dc4PijQlWh
         bBWyM+yRgQyDzU/N6ziqdOuBZsefDCgFW15OIZKrdmCmq3CjIJ+YfjJmKLyHKS7e03
         2KMHvZTfi2iVdvr49SVIOxr/6Zu2LoHgZLa0D9mGs+nUUD50Ql8hoPfbv4QgEEMt2a
         9IfbBUA8io1DCijMfmtm4oCij6+kOOMYWmAn+ouycj4PhyLh8MN/zHQFbxhpFwaI+0
         BxkghESjiKGJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47294E45200;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: clean up error pointer checking
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165833401728.6265.9737720058353472000.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 16:20:17 +0000
References: <YtflxRosxskh2CoH@kili>
In-Reply-To: <YtflxRosxskh2CoH@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Jul 2022 14:23:49 +0300 you wrote:
> The bt_skb_sendmsg() function can't return NULL so there is no need to
> check for that.  Several of these checks were removed previously but
> this one was missed.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  include/net/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: clean up error pointer checking
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c7ec89ab45e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


