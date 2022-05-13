Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 22:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384803AbiEMWAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384799AbiEMWAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 18:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897454BF0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 15:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E25A4B831EF
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 22:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB187C34100;
        Fri, 13 May 2022 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652479219;
        bh=SaVm2xbv15g/7c8NhKjTaGytMa7XuSHdktuFo4MRrAE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qk5ULtXrdDSAWPrhlWGVtldlFR0tUB5lJTaYME6WqBvFtBqVVVL2ExSZ9zCy9Re9C
         xLJCyXysKIJSePj2DEesKY3kULQpkQaC9DqM6HS+p3LeQSULB0Yq100/Ur1tSzSWBN
         pHP59f15gTC+zmAz4i88yjymC4n2iGVroW1c3BsWffBez31VxuvEDGv7v11cYNFjM2
         qbfiuVh+kBvJDr94uFBGfJr2FoFnXgjqBkLgLAvB7K7WwuHQs2pfd8HmveP02dj86W
         7zMyD8FlBSzq6mq4kX3mDuRv0WlKRkyWktr3O5PSODh3NAOZR8nwuhmwGGqfz/PrB9
         lUnfKkFn+o7uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B351E8DBDA;
        Fri, 13 May 2022 22:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix enabling wake support without RPA
 Resolution
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165247921950.21318.13482223182726677837.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 22:00:19 +0000
References: <20220512234835.1042988-1-luiz.dentz@gmail.com>
In-Reply-To: <20220512234835.1042988-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 May 2022 16:48:35 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If device uses RPA it shall only enable wakeup if RPA Resolution has
> been enabled otherwise it cannot be programmed in the acceptlist which
> can cause suspend to fail.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix enabling wake support without RPA Resolution
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a4b67f9caa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


