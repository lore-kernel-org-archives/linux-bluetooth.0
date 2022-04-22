Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 09:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446123AbiDVJdO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446098AbiDVJdF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 05:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880DD4EF6E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 02:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212B361D94
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E2E9C385B6;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650619812;
        bh=oHj9UzeX5TTh/jY7tBFy4tmuwcotJtPCjmQ1aT5XzoE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gv1gckuuZs8QIb96kQLhST4Mw/MVoNudcL5zfhgz8fic7diA+fp4op2T0eiIvsblt
         4rys4RtPTsFuD6lO7MXwHK2MKpdiTL6kYfLdFXJdsy7raL2iL0stimJ/eSJt73p9GL
         NUXsz0MeWjYbNkOt0N76eWhvt/wGGp5XyDq7ZdUKW6w7lMbm5xWweWv92QiYXuH8Fo
         H8m24A2XRLvBlYD5LFBWxPKeSQY5jrmG0qHXfcnPMl8XLGPkTGF2i0W24VWnPpiH42
         aknt3lP4BfYxZJrkBB1Fg4CSM4ryyFE11p7bagG/ZnfONDqJLHtxuBUt+8et2Dvs/L
         tbODs9L7Ih8Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C157E8DD85;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: use hdev lock in activate_scan for
 hci_is_adv_monitoring
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165061981237.24106.5638198039269621064.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 09:30:12 +0000
References: <20220407180651.14871-1-dossche.niels@gmail.com>
In-Reply-To: <20220407180651.14871-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        howardchung@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu,  7 Apr 2022 20:06:52 +0200 you wrote:
> hci_is_adv_monitoring's function documentation states that it must be
> called under the hdev lock. Paths that leads to an unlocked call are:
> discov_update => start_discovery => interleaved_discov => active_scan
> and: discov_update => start_discovery => active_scan
> 
> The solution is to take the lock in active_scan during the duration of
> the call to hci_is_adv_monitoring.
> 
> [...]

Here is the summary with links:
  - Bluetooth: use hdev lock in activate_scan for hci_is_adv_monitoring
    https://git.kernel.org/bluetooth/bluetooth-next/c/e05c3c0e1b45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


