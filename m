Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E8C19F21
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 03:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiG0DAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiG0DAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 23:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5A38A6;
        Tue, 26 Jul 2022 20:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 436A4B81F1B;
        Wed, 27 Jul 2022 03:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3579C433D7;
        Wed, 27 Jul 2022 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658890814;
        bh=7AFVNaDSDw1A2oO25p+5fmMX/eSSmBx5TZ7UPV88uAQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KE+lHIq8AE7u41MUZ2QAeeMm3jzbyB74os2j/SkC9rRFhdZzag28A0TCmWkNyxPcx
         qr+Vxr5i5su28Ca5IL1W6lMHy27nJZubWQAYYqjoc++eudJcU/U7GT/aPReMbQvzXD
         ItasdqCPTDkVr39mkH2LAj5E3fD0DOMCLlgpBq5KEHGA+TtzcR+WiHldRyqEwQrBjp
         iWKwmWdw9/QaiMu1sSmas5oEBcy+5kZdcjFQ5FbrknCGzXa7TJ0D/U1QEMwC2cfpHG
         AsEzIIdfok2NIHH+NVeZ8jxbd5okI2e4mqYFNH+NWdSbSUftzPPrMp1cVghxATMC7P
         drDqJIVc/oaLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC459C43143;
        Wed, 27 Jul 2022 03:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2022-07-26:
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165889081389.32406.9689230770179515714.git-patchwork-notify@kernel.org>
Date:   Wed, 27 Jul 2022 03:00:13 +0000
References: <20220726221328.423714-1-luiz.dentz@gmail.com>
In-Reply-To: <20220726221328.423714-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Jul 2022 15:13:28 -0700 you wrote:
> The following changes since commit 9b134b1694ec8926926ba6b7b80884ea829245a0:
> 
>   bridge: Do not send empty IFLA_AF_SPEC attribute (2022-07-26 15:35:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-07-26
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2022-07-26:
    https://git.kernel.org/netdev/net/c/e53f52939731

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


