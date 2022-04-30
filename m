Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Apr 2022 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382344AbiD3IEO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Apr 2022 04:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345094AbiD3IEI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Apr 2022 04:04:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD1624976;
        Sat, 30 Apr 2022 01:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 218F2B81D16;
        Sat, 30 Apr 2022 08:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7CAAC385B1;
        Sat, 30 Apr 2022 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651305641;
        bh=66ZEaixsb1Qt+EPzED8sXT+Yui692MmuX2beg0i331U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TBr//hQEaA2xzr4bLLJOOOMt66w2yrp9XETZx9vh07wdiN0FOC11qp4KC4GKsKGVB
         Fr7qbXsCF/cQ2nuV1p0Wiyr1QFiS2XYCPTCMSc6Ht+TMHLJiQml+uUMfzNU4zQft6c
         8t596pW+DlHmbUrZPRZNY0zHQMlNAkyOF+Y1BZYN94wCCz5p0n5zWotrHvxM6vn2L1
         XdtIL+wgVVMi3I7qm5HrS0PcWh4T02E7T53gD5sbFr4y2NcWRQrlPL9oHCHadX1fmx
         JkOUAzngivoivMkxKO/FVAv17tavu8I+tASCDCI482oDnVYhfdwaeu4r6W9MlRcyNq
         bi9ckAspDfMKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73F2FEAC09C;
        Sat, 30 Apr 2022 08:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2022-04-27
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165130564147.32506.6655402519578352088.git-patchwork-notify@kernel.org>
Date:   Sat, 30 Apr 2022 08:00:41 +0000
References: <20220427234031.1257281-1-luiz.dentz@gmail.com>
In-Reply-To: <20220427234031.1257281-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 27 Apr 2022 16:40:31 -0700 you wrote:
> The following changes since commit acb16b395c3f3d7502443e0c799c2b42df645642:
> 
>   virtio_net: fix wrong buf address calculation when using xdp (2022-04-26 13:24:44 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-04-27
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2022-04-27
    https://git.kernel.org/bluetooth/bluetooth-next/c/febb2d2fa561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


