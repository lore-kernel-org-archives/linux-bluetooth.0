Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E041C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjFGTuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFGTuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 15:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523E101
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC006433B
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E65B3C4339C;
        Wed,  7 Jun 2023 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686167421;
        bh=76tu48GUIzP7haxPJVRFbW99PI253z4Gn4AyjZ/cGzQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iLwJyz6eHn5ejCYFjHlGoLFEOWqGh5ZmTbVNwnXAn3XB64Vl6Flckhbv6nYR1tQ63
         ZU4z41aoEPOZJTbGHu6KJOEt4ITt6xVTU6XuplA0JL1W2v5sKR7Sw59Tesad6rTm1C
         NW2rbtXa2GV9mJqt/MILYt6bEYYnPA0UVyG+ItwD4TlebezUISXHPG+0rvY1epjEL+
         7PY+YdK1c9pCNXncW+SzFciKBpaDxPqwBEfMeSf+gfx2GHkNe8h65oPRnq2BJkY+aE
         CVW7+FFlOScI0hksa/dwkUwzvaoT7rPNMmw0cexQiNkamcDb5PXfOzDdh4Ek5JAwlz
         c8Jzu2076RXcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7818E29F3C;
        Wed,  7 Jun 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] battery: Check interface before getting property
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168616742181.16860.12535960462358259461.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 19:50:21 +0000
References: <20230528074445.694554-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20230528074445.694554-1-arkadiusz.bokowy@gmail.com>
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 May 2023 09:44:45 +0200 you wrote:
> Client can export other interfaces than the BatteryProvide1 on the
> registered object manager. So, before getting battery provider specific
> property, validate that we are operating on the right interface.
> 
> This change will allow client to implement only one object manger for
> media applications, players and battery providers without triggering
> error message.
> 
> [...]

Here is the summary with links:
  - [BlueZ] battery: Check interface before getting property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f32fa24cc9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


