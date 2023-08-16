Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB1C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 00:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbjHPAUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbjHPAUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 20:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B62117
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 17:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696CF61774
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C54BDC433C8;
        Wed, 16 Aug 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692145220;
        bh=vhl2JpVgGgjC+5H3C/Adbs7zhVl+9Qrl/oD7C+z7XUE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NxC/Prfw2rZrTx+u8ECtjEAIIYaoIszxkyF+Grrb8y0ZwcrvqCWo7TqSmGxfnYngM
         7kfAXCiLm5TA5Tfat5k5loo1fY0qEOwBHmIy7+Kud8I24sXE52JW10WZ+zNH0JyjTA
         33abw0hsPPvUa9w36Qsn1fzAlq+bGH7vxjvEod+aIQCsF+dgFHmQF0H+rwvyVeTYxm
         DyOtXGPgqCTewcM9MiImFDR1K757CtKLVLEB0EIwiz4IuuX/Kc7nB5mdBxFSHcGZtl
         /jY/Mlwf42TW8Trj71fZlKb3nZBMRAGMbE2+VEI3C25UgI5fo4vwz3sjF/sgEnouRO
         gt80kmydC+pdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB175C395C5;
        Wed, 16 Aug 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: Add suspend tests
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169214522069.30914.12189703602866375463.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 00:20:20 +0000
References: <20230815221738.2491772-1-luiz.dentz@gmail.com>
In-Reply-To: <20230815221738.2491772-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Aug 2023 15:17:38 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following test which attempt to trigger suspend code path
> while ISO sockets are connecting or have been connected:
> 
> ISO Connect Suspend - Success
> ISO Connected Suspend - Success
> ISO Connect2 Suspend - Success
> ISO Connected2 Suspend - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ] iso-tester: Add suspend tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=583d579178d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


