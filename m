Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E937C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 05:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiCDFK7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 00:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiCDFK6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 00:10:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B817E36F;
        Thu,  3 Mar 2022 21:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF5E61B7F;
        Fri,  4 Mar 2022 05:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E64D6C340F0;
        Fri,  4 Mar 2022 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646370610;
        bh=1oAEoAybRxvzYK4cdHb/DaE5zyuOWBL/TAWV22fHxpA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rzJNU54LWfcdwZAq3rRuXqqrW9/VmXO5fdgMdUeP+rApMsKJJi97LtdKlxLPxIntQ
         CrECMTP8IhenJ7f2lVqFrHt2frL+Py8HFRR4as8RBSXhE6AXmINfWuvQLdgRgLSTX7
         q8ftdGiW918FuU4o51wEJ0N/4ChqDQVTqB6NgttlYQcUeU6x9oCCHmauSINK2Gx68w
         Wl9ryZnNwY5iIeL9H7EKDbTNHmGRynymSsBcfxu8aTXmJB0A7/8jHOHiekPvIWcZmg
         oZm7TYxweU33SOVaGtWxzaywsksj/z6j7DRJSPERwANXk3d6H/2e06n5a4nue6RHw2
         +bSje8Zic9Q2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAAE7E7BB08;
        Fri,  4 Mar 2022 05:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2022-03-03
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164637060982.7623.2431046217416492091.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Mar 2022 05:10:09 +0000
References: <20220303210743.314679-1-luiz.dentz@gmail.com>
In-Reply-To: <20220303210743.314679-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Mar 2022 13:07:43 -0800 you wrote:
> The following changes since commit f8e9bd34cedd89b93b1167aa32ab8ecd6c2ccf4a:
> 
>   Merge branch 'smc-fix' (2022-03-03 10:34:18 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-03-03
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2022-03-03
    https://git.kernel.org/netdev/net/c/9f3956d6595a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


