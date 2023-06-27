Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E91EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF0SK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjF0SK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407CE71
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 11:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90469611F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 18:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5CB4C433C0;
        Tue, 27 Jun 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687889422;
        bh=kfiAacQdD7qLCWrdw5MVrFHxdOHYaIiUktgveu5w3Is=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qnh3py2faCSBjAQvGp3cnGrNFaMor7DytEuR4gXwTd4XYF/uyAZ1eZKFFgeN/yiZU
         VR892rDRWYHHuI8AKGjP7NVNgPKMOwIG4gVNnc7BecxCy3y7Oya/cHLvSjgxRy0HWp
         N/hZKdcVFinpgPTrt5iSxkS/QelgbHICkuk4sShYcrG/bVsBUH7i7RF6yz8tGdPFzT
         cPYtZVmqHVS/gRh9f0Xhh3r/3fBPrIKiw/K0LGuPNuAmHZDi+Q3MXFKiN1dPUfuDJ/
         E/7JfSPQ+ti+NoM4OGTkq0L3yGI4pzJP0yDkghfG20LhSEPTorraQuHj17DEF5B5+F
         wsg3mGRGoxFjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA55BE53807;
        Tue, 27 Jun 2023 18:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] af_unix: Followup fixes for SO_PASSPIDFD.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168788942182.15653.17504067646804498753.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 18:10:21 +0000
References: <20230627174314.67688-1-kuniyu@amazon.com>
In-Reply-To: <20230627174314.67688-1-kuniyu@amazon.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander@mihalicyn.com, brauner@kernel.org,
        luiz.von.dentz@intel.com, kuni1840@gmail.com,
        netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 10:43:12 -0700 you wrote:
> This series fixes 2 issues introduced by commit 5e2ff6704a27 ("scm: add
> SO_PASSPIDFD and SCM_PIDFD").
> 
> The 1st patch fixes a warning in scm_pidfd_recv() reported by syzkaller.
> The 2nd patch fixes a regression that bluetooth can't be built as module.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] af_unix: Skip SCM_PIDFD if scm->pid is NULL.
    https://git.kernel.org/netdev/net-next/c/603fc57ab70c
  - [v1,net-next,2/2] net: scm: introduce and use scm_recv_unix helper
    https://git.kernel.org/netdev/net-next/c/a9c49cc2f5b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


