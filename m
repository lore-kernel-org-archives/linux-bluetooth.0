Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CCCDB465
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 01:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJQBK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJQBKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 21:10:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1059B
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 18:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16EABC433C9;
        Tue, 17 Oct 2023 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697505024;
        bh=DdeqRcKlBQ/+BhS/2gKujHNhtsc3mNA2gqQ3eKEHjBE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CVTyKhN45x6gD+6WyeV5uv5oF+/XraBRSJJrhbIGjskEoYDcsM+Xsm3/mxcWJRa4P
         GFk3NY/+oD+A0pw8xT8jZsLq7h5rJTXi2yxikRx43O/6ahqDomEAM+hqT4RJK3LL2x
         DR2emnqBG9v1fbIvYDNbnPenV/s71+M0alosLi17Sjf6W6B4MgM+9Ql4rbWLyWIUhs
         J00bmsO2jVrAVM3XHP4Md67qf9nZRqSeGxHDeAPbiWDZCCGMk4FqJYLHcDAn1hMacV
         dIzSYqx9meIeGEJPwFvnYxMqK0nkKpo40nZPh6xZbdtx7DRLhsow6AMhJUyRZ4uazY
         eUz9XoZJasLog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC16EC4316B;
        Tue, 17 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-10-13
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169750502395.8129.10858482508717627477.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 01:10:23 +0000
References: <20231014031336.1664558-1-luiz.dentz@gmail.com>
In-Reply-To: <20231014031336.1664558-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:13:36 -0700 you wrote:
> The following changes since commit a950a5921db450c74212327f69950ff03419483a:
> 
>   net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-10-13
    https://git.kernel.org/netdev/net/c/2b10740ce74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


