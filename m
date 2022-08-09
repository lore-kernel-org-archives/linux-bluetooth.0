Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E81C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 04:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiHIEKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 00:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiHIEKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 00:10:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A42AC1;
        Mon,  8 Aug 2022 21:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9CF14CE12CE;
        Tue,  9 Aug 2022 04:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A47AEC433B5;
        Tue,  9 Aug 2022 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660018214;
        bh=eih6jg1A7o/tFh0QBdatZVqe4c06S+DuAWXOHkxzktk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oCmnwmH/rlYZpKjIVuNC3dHhHaiEJU6uABBIG1Vm4NfXGbx8JSefZyDqvQoUFamnS
         Yo+4VVlJaFC6h8ZlvlwYhu+lXwN832KJonCGyqPnZorRF2KQzfDwlSCtzDjahMs8lr
         bfPNgEJPg/zTXN+15fYC5IVOPgxwyPgYhDxv2Uy7GkyZyduBZ76SWS95EA2+/GrG2w
         6g5Cd4Iy3PSJv9Vqk5e5lEUZwfMmnq+302/fCGB3evky9tPJnk+Vo15QXV8Q4QyyEw
         PtWZ8nPl3HtkPXwXT7Cl6kE81sm7gB2CzAEUc6Sc1jdlPiuufXXvd16+p20mQA/EZZ
         0p0YfYzKnCvdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ABF2C43142;
        Tue,  9 Aug 2022 04:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2022-08-08
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166001821456.10896.13343405023059413138.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 04:10:14 +0000
References: <20220809001224.412807-1-luiz.dentz@gmail.com>
In-Reply-To: <20220809001224.412807-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Aug 2022 17:12:24 -0700 you wrote:
> The following changes since commit 2e64fe4624d19bc71212aae434c54874e5c49c5a:
> 
>   selftests: add few test cases for tap driver (2022-08-05 08:59:15 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-08-08
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2022-08-08
    https://git.kernel.org/netdev/net/c/b8c3bf0ed2ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


