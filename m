Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B2C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 04:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEREkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 00:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEREkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 00:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD319BE
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 21:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 785BB64C90
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 04:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C750DC4339B;
        Thu, 18 May 2023 04:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684384820;
        bh=30DU1b40Wi9wXb9CWIrXfwWRPOeiLWY8iwPRcD7STQU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bu+Jlqn8SbhFogYrpkW66DeDZ8Nmw20ywDp2dCT2xJAxCvQVmaeNXFWSUv0t+AHr1
         6lVNCJUYy55nkza3FuhtFmkGIw4w1+VqJZ/pdTyH+nvjBlHpKSi4u2Pg9pKx+4hE5E
         6EJk+qhmp1Lo+Fx6g6PPs6HmRW0E71K+w3yoe1unMaX8P0NNeJ5bTdSCL9r2xk0+Ap
         4SMjaLnchkminAzCNmhxXQGrNTcWDq3NPA1YCbfaE7PaURL/krXauaLyeCvHsh4ckc
         oWeFb3wI+AxxNJV+/mbOzCnFXNgX+Wiy1Kx1xxqMJgVKd78OlcdGW91CKntfyqFku8
         UqLgKJx5dX2gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD353C32795;
        Thu, 18 May 2023 04:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: skip CCing netdev for Bluetooth patches
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168438482070.9978.1095770654117083488.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 04:40:20 +0000
References: <20230517014253.1233333-1-kuba@kernel.org>
In-Reply-To: <20230517014253.1233333-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 May 2023 18:42:53 -0700 you wrote:
> As requested by Marcel skip netdev for Bluetooth patches.
> Bluetooth has its own mailing list and overloading netdev
> leads to fewer people reading it.
> 
> Link: https://lore.kernel.org/netdev/639C8EA4-1F6E-42BE-8F04-E4A753A6EFFC@holtmann.org/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: skip CCing netdev for Bluetooth patches
    https://git.kernel.org/netdev/net/c/bfa00d8f98f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


