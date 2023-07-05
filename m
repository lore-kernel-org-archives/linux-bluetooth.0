Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FBDEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjGESAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjGESA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A404DF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E33B616B4
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 18:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39A70C433D9;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688580025;
        bh=O3ksl+oovWRHXbFn1Ff1AlakZQYT4l2kp/vYnRr/gcY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GQzx+KjdO+Pl+aBpEyilsy3dDWbJ2e5zDLgSovA7hZ6ZCJad+yMzB/pQsRoHMNiiK
         17tOYU/kZNVyylVrCXRVgtJgzbw51biwJBI8zYeV3kWIR9Wx4MbgE9HNKBWPJbEOsy
         OOBgOPe8G8z81W2M1yYTZIBVsGJxL8MA8wWxWu9KAizENc6sqUZaJvaeGCcvF85Re7
         oyaUJp3ihKy/Xx3TPXS3wpqGgRtF1iKhhRJV46WActo50L9MxTnStLVfE9yXdlBzWi
         rPkDazRJuYRgCcptLdPkOlVJtdcN/CtSFQRwR3ARtEBULWvehzj6sq5KpjcN19mxfR
         SrqoYcuuXMwhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2356FC691EF;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/tester-config: enable DEBUG_KERNEL, PROVE_RCU,
 DEBUG_ATOMIC_SLEEP
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168858002513.7518.17658667726521748204.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:00:25 +0000
References: <fdec6ddf8eacfb37cbd34d9049fcadf29041c103.1688490237.git.pav@iki.fi>
In-Reply-To: <fdec6ddf8eacfb37cbd34d9049fcadf29041c103.1688490237.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Jul 2023 20:06:51 +0300 you wrote:
> Add more lock/sleep debugging to the default tester config.
> 
> Enable DEBUG_KERNEL since olddefconfig won't enable PROVE_LOCKING
> without it. Enable PROVE_RCU to also check RCU usage. Enable
> DEBUG_ATOMIC_SLEEP to catch those as well.
> ---
>  doc/test-runner.txt | 3 +++
>  doc/tester.config   | 3 +++
>  2 files changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ] doc/tester-config: enable DEBUG_KERNEL, PROVE_RCU, DEBUG_ATOMIC_SLEEP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80f2fa14b6d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


