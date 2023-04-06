Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F57C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbjDFVAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbjDFVAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6011768B
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5811364CBF
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C022BC4339B;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814821;
        bh=Puifv+Br2bamtH/FF9STiUYB7pPYdFXtrZ4HFgS7ieo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zf/Mvk3d3Z17lj35ANDf2ni+by84WiyQmZ+SODO/mxE839U79XHxubn3tw9Q2+TfH
         G1AKtn9nlcDGhlKx8WAXM0RBgZOeawu1q0VpYRF+2Z6oChMhbIJRV0CMsjGK3sMBQG
         1R60lPVI6wQ5GeJxWpkTcGD7mNijW+XDbIL3Jmzpcn5fhoRuVD56jAECOMa3rYdd6J
         puUxsMnBiR3WLSbDPiE3sfruFjq5ttfOkWAbHLkncKym9NWMvRrnXe5SOMzUzbxdBl
         wRSVM86K6VzpDNzHC+caDX4Z2R4qUU8KA/H0sTCwIqWP9rsJ6f4hk4LN+pmnW0T81F
         1r4zewCOz7WUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADD1AE4F14C;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] main.conf: Fix parsing of CSIS group
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482170.2619.15624547085977413700.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:21 +0000
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Apr 2023 16:11:07 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> There was a typo in the group name using CSIP instead of CSIS.
> ---
>  src/main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] main.conf: Fix parsing of CSIS group
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1b93db14da6
  - [BlueZ,2/5] shared/ad: Fix bt_ad_has_data not matching when only type is passed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=759d1442a5dc
  - [BlueZ,3/5] advertising-api: Add rsi to SupportedIncludes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=23bc47437a35
  - [BlueZ,4/5] advertising: Add support for rsi as Includes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eef2e62a5bc4
  - [BlueZ,5/5] client/advertising: Add support for advertise.rsi command
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


