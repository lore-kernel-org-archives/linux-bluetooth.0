Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FCC001DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Oct 2023 00:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJUAKb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJUAKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 20:10:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8719E
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 17:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 580BCC433C7;
        Sat, 21 Oct 2023 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697847025;
        bh=ZwR8k9Keelm1wx+92uCrPWtNRMKJWMnLBzkhM+bbAOk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YgXCt3pCsdwV/jsbPOGWWAOQ/ejnSJW0wYDtWkrC5IB62eqcl6cmh9neNB7rMufjc
         yE/fs0J8JzLMmRs9wQ0qdeYhrHo5G5qSKka+zP9MzUA+Y2KLsM2G1Z/lD/X2dEEdWj
         XX8Z+FKBivm7vG2xuPi+vgeFF1cUt0+J8Eiv1rZU14eHNZ02XHlaQGxHhygMKBLy+9
         9VO5gMICJJNuL2D0StEkpFZ7tzz7H0DijmuqrLBuuCfq20oBJTyWwXn9ALtXdljg0A
         hUt8BVOaPRaXRQtYoaO6XcsAhkSVvuXx1HiNfug3thN0MkkhyUuhCNNb7v7/rx7y1B
         5Xhol3FgAnuug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36E56C595CB;
        Sat, 21 Oct 2023 00:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: Remove Locations,
 Support Context and Context defines
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169784702522.27915.16087302741935671405.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 00:10:25 +0000
References: <20231020234212.3190403-1-luiz.dentz@gmail.com>
In-Reply-To: <20231020234212.3190403-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Oct 2023 16:42:11 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These values shall come from the upper stack.
> ---
>  src/shared/bap.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/bap: Remove Locations, Support Context and Context defines
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5fd6d8cf905b
  - [BlueZ,v2,2/2] client: Add support for setting Locations, SupportedContext and Context
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e126cf204907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


