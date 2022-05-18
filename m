Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiERWaQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiERWaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCBA2F002
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42A69B82223
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E43CCC34113;
        Wed, 18 May 2022 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652913011;
        bh=e+S0Tmo8w6t5TRSGQ3eUMUgtALxkOqcwEPCekR3DBxk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YA+jKTT67sbsCXGke85DLLVUTu66BUu59DwOL+Z6IEm6SE/lEiKbjUbZSd9msr9EK
         tjogUXNxCOZdreURu/AJTi3bRs/XI+ctMAUbAgDIClKRJBdKbZh4XH20xB807DLjXl
         Xs3q6kuJsiSuLUeCt5PKXkO6qKQmXkx9Ne9pdedYu/fmSUd34Z338xp/ohfbsQfpR9
         qMGlWfgqxHNx8A34Ti+NxzmIuhHJnImXfjF9GFID1OQ5r9BZbn1ilO/SVDg3/RINc6
         7YM4wB93jrCThnDUIK4kV/Yj7BP0ovGPyUoVkHz8l8vtSzPEtd2nzKCwLEMb23oQsZ
         syNWYH8zF/rug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9F3DF03935;
        Wed, 18 May 2022 22:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH] input/device: Notify failure if ctrl disconnect when
 waiting intr
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165291301175.29867.15018263592071447894.git-patchwork-notify@kernel.org>
Date:   Wed, 18 May 2022 22:30:11 +0000
References: <20220518123252.Bluez.1.Ie61d0e985d42728b2e705ca6dfd000385cf3870a@changeid>
In-Reply-To: <20220518123252.Bluez.1.Ie61d0e985d42728b2e705ca6dfd000385cf3870a@changeid>
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
        sonnysasaka@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 May 2022 12:33:07 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> On some rare occasions, the peer HID device might disconnect the ctrl
> channel when we are trying to connect the intr channel. If this
> happens, interrupt_connect_cb() will not be called by btio, and we
> will be stuck in "connecting" state. Any future connection attempt to
> the peer device will fail because of "busy".
> 
> [...]

Here is the summary with links:
  - [Bluez] input/device: Notify failure if ctrl disconnect when waiting intr
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c159d790e878

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


