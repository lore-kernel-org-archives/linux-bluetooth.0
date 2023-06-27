Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A708EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjF0TCA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjF0TBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 15:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972EF122
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2DF6120F
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 19:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 834ADC433C8;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892513;
        bh=bGvMc1yTWDTMtingXAKSAxWvQtLuTim0DetY04msz+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TW4V6UOvZ5YhON1NiFHfCs3+vixNsfTuZ5V/A17O6UkpjXBHU4RmbmR6FS4Ny4l9F
         5fdKbtyHR9krZys/3VtlrBFHgvis5pHDHXwBkLCGnblI8MIEBLlXYz80GrvU2/XyvP
         ed+HMQFv2EbxPJ790pCGvak5AXT/vlOr7IJLKiY1P6bltHScUC6sy9xQ026gIKbxN8
         WPTQUHtHQqknHL9sNhHHxf4rKoCheNLWT0Qc4jHHH5+dBf8/gTxXm9ZbM60fznlO0L
         WYqsg4ZdDpR9IwozaP7KUW4NHmHFzyPnMvnG+kdasT/I9QtDojV6vWIRrYfKXs8NPc
         M7QNQpsbyFtiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65714E5380A;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] af_unix: Followup fixes for SO_PASSPIDFD.
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168789251341.11348.5241440174968893552.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 19:01:53 +0000
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

This series was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/603fc57ab70c
  - [v1,net-next,2/2] net: scm: introduce and use scm_recv_unix helper
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9c49cc2f5b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


