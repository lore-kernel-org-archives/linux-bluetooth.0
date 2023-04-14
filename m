Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F49DC77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDNUK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDNUKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283265BC;
        Fri, 14 Apr 2023 13:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E71AC64A27;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 469E3C4339C;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681503020;
        bh=hQdeyryshxMX3gP79v9URObTlnSUTWPJeXG4jKAbYqE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z6fH6CjrD61alup84nqkH5aYjDwi3VMTJd6ouBb2yTgVJJVe+k9l5bG72kYrXYYMt
         8k6WI/KI2o31vJYydp9DXrLAGdVFv0s0ms8kf+LeJ40wBWudrOXfzXjIBeelsI1dSC
         73umoMTIh85o2ZsVlBLE7jtLUqmBN5sXeUC9/oyWgqivDEYBUQXo5ghReRBGXtp/AY
         JZUOVbMXP1DBNLjP3iM8PTDMhlFHSW0hSaJBkebYewxIemC+xjAKFjA16/hIjoS5oN
         nZq52oVFqSm2nczRtg1LLauYXWLC3GNZGqyzjrISOe+O+pyrTnN8jQ6UV2rqSou6o3
         BykntO7df/+cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32B68E52441;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix inconsistent indenting
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150302020.15322.4989643441506620146.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 20:10:20 +0000
References: <20230409130229.2670-1-u202212060@hust.edu.cn>
In-Reply-To: <20230409130229.2670-1-u202212060@hust.edu.cn>
To:     Lanzhe Li <u202212060@hust.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Apr 2023 21:02:29 +0800 you wrote:
> Fixed a wrong indentation before "return".This line uses a 7 space
> indent instead of a tab.
> 
> Signed-off-by: Lanzhe Li <u202212060@hust.edu.cn>
> ---
>  net/bluetooth/hci_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: fix inconsistent indenting
    https://git.kernel.org/bluetooth/bluetooth-next/c/2df7d630ef53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


