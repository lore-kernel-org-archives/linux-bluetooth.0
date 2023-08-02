Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C9C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 21:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHBVAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHBVAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740AF2701
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 14:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0830D61AFD
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 21:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EBF0C433C8;
        Wed,  2 Aug 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691010022;
        bh=OfKsmfvcSbFi3mqIyGLF5iKJKTln5B2fdmzYbD/CFoE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OPuEtjM6RKKXyV/KSx4K7pedPI93IMUhLWY+kQW73e8JmpYMICYA29XueRhaOHoXd
         KdAk6S1cckqAyZlmVAMqMV39YVAzTvqI3n+xaDeEG6L1pGS60lx/R8xL0SFo7p5/Cm
         DyhpDU9D7GrNhT4hzW60t0Clfp9bVzYrsKnTMHyCOPqTsdmCLNlRp6WsILDGu/A/ny
         crcmZCs8mz5HE43EtvysCSjpSdvsH+Dwwu2IbnMNkVDDDaM/YWJBrToU8Glszb75Zs
         UOzE77Cz8t0qnGKRxj5hK4lBtkoqkpu8OsN7GZ6mk6zOjXiDa3YbGscwRkkLeF5qSG
         +jxyCVaXjpVbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CE19E270D3;
        Wed,  2 Aug 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Move btusb_recv_event_intel to btintel
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169101002237.16544.12661960738546066670.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:00:22 +0000
References: <20230720221954.517948-1-luiz.dentz@gmail.com>
In-Reply-To: <20230720221954.517948-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Jul 2023 15:19:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> btusb_recv_event_intel is specific to Intel controllers therefore it
> shall be placed inside btintel.c so btusb don't have a mix of vendor
> specific code with the generic parts.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Move btusb_recv_event_intel to btintel
    https://git.kernel.org/bluetooth/bluetooth-next/c/458853310845

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


