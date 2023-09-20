Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E4C05024
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 21:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjITVAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjITVAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 17:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993CCA
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 14:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB9B5C433C9;
        Wed, 20 Sep 2023 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695243624;
        bh=WDuLHL0EAVOhZYRyweDAM6OMbtmymPde6BtRKxl5xKY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QsUklgkpZPf/JleAzf/prXayJWw5rjeYdVsXmjL99PcmPH11vTPT325TbNmLAGn/H
         H4sCrqwCkQa2xPanRwWsqzadaoxB65StN28InTeWfd7opNLfoFKJQCJ3t0MzmhXzkg
         vCXk7sdFed5QuBtWXPdQC2AkaHcZ8fkUZvLzMl++qlM/szx+kU2x5jTMT6TKga4Sum
         O0PyyX+pvXXe50QR3M9KC5vYpqbAR39c51DZzUZeggYjlZLByYCS4rivjglhasvmyY
         L5gaZoUqzLNw19FlKcP7Zt/1owEfLLzzFYJqS2walCXQHh4cq4EOdzXqvx4eIs/C2z
         l0DV4FiMxnJ1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92D76C595C4;
        Wed, 20 Sep 2023 21:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] vhci: Check whether vhci open setup succeeded
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169524362459.6493.8374365124272867725.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 21:00:24 +0000
References: <20230920184313.973822-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20230920184313.973822-1-arkadiusz.bokowy@gmail.com>
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Sep 2023 20:43:13 +0200 you wrote:
> Due to race condition in the vhci kernel driver, we might read not a
> vendor response packet, but a HCI reset command. This extra check will
> ensure that kernel driver behaves correctly. Otherwise, the HCI setup
> process will fail, because our controller will not respond to "missing"
> HCI reset command. In result the virtual HCI will be DOWN and without
> initialized Bluetooth address, e.g:
> 
> [...]

Here is the summary with links:
  - [BlueZ] vhci: Check whether vhci open setup succeeded
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2d47ef05226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


