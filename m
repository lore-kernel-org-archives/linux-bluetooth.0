Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19257C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 05:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjFGFA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjFGFAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 01:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B07E1721
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 22:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F292663A83
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A9FCC4339C;
        Wed,  7 Jun 2023 05:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686114022;
        bh=ZO2jlGjckUSBt9bnQ1g4uzThdD6UwH7dkpjQwUFb6EM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tip1HI8TdY4jyXLKAW86Xrpxw0GTDpxeGw5JL+uSAGcfrLsDGRGe0bidD1Q8VXrCo
         U+OmE8FysY2AxQHwurM7i82DqM+NMCONhn6WQP1+jK/T6Y/1hSianbLeChY+peCXl6
         M0Q6grqidzaYjAjSVu5vSMSjWNKhmtAh9k0Lh3NWcF8Uqo9dkv0IrAKUmKXcfAbGek
         STNCCYsUolW0OfEe/K7GBENay8XEGzbk6ZyMHv3pL0iqeewo4ZpmCe/GHm7xf75Ghi
         qCstpb+FuGw6Syz3Mcu8EC4z86mlJJgUQL27XMtNnwgYN5iEMgaLcyOS12QhXqwi13
         j2DRLrOYtHcGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19DB5E4F13A;
        Wed,  7 Jun 2023 05:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-06-05
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168611402210.26969.14204667186848677809.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 05:00:22 +0000
References: <20230606003454.2392552-1-luiz.dentz@gmail.com>
In-Reply-To: <20230606003454.2392552-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jun 2023 17:34:54 -0700 you wrote:
> The following changes since commit fb928170e32ebf4f983db7ea64901b1ea19ceadf:
> 
>   Merge branch 'mptcp-addr-adv-fixes' (2023-06-05 15:15:57 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-06-05
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-06-05
    https://git.kernel.org/netdev/net/c/ab39b113e747

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


