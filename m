Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1EBC77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbjELUko (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbjELUkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 16:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4C271F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 13:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBD46588F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB27C433A1;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924022;
        bh=48H8FijAmTFAOqmL/jpdoKPGVWwolTtdJhAlaokNow8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sEa9wK8KNqTLCESjb6LZ9wNmv7sRyd82Az88260QI2xepipxO1xRQh4QEBiXf/IbI
         1X2mEYoxLt/bB429sJCrGn9rgD8vuUl02EgPRUvFpjNnO7vwDGHiyyNWz6AaU0ArdB
         jnAWR/s8Kv/ddPkgpQyL5vdup7+M+RNIxZWagYGTaDl890rxQ818nlBT22j6VnbQjs
         RKk2kNSPwgoEZs3MKRRLW9HZoUBJbmYN20MmNN05VbLOhYKk+gYyopdGE45AgnmOLK
         H53JJgXyGfZ7hXh6DGm9FcZsvOYXmKU8OWU6n0Ux0WUOeuQdlOyQI9YhNywwA2ji48
         nxZM7EdWvxGiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8531E26D20;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/player: Add support to Max Transports in
 endpoint.register
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168392402274.13139.17059756690597826457.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 20:40:22 +0000
References: <20230511202825.3983806-1-luiz.dentz@gmail.com>
In-Reply-To: <20230511202825.3983806-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 May 2023 13:28:24 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): 1
> [/local/endpoint/ep0] CIG (auto/value): a
> [/local/endpoint/ep0] CIS (auto/value): a
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/player: Add support to Max Transports in endpoint.register
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe16cf2a7ee3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


