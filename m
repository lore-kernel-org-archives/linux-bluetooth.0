Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C2C04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjHIRUX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHIRUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 13:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30351FF5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 10:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 747DC631D2
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D69A5C433C7;
        Wed,  9 Aug 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691601620;
        bh=xdkxumFR0VSXJLKxo5/bscOOdok4hcCFjTTp+hxrOow=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sNyugI5baYnWsUevGD4ivjz/JtVF4u1p5zxL4O0enQLHHo1xm8Gop76ocjDwlZ8uh
         s8yW5t3otowTRqm9TbN5UKfM8gUYckLxZrmhVDHJvwAj4cOGYIjmLb+6jt2y0HFrHt
         36QZMAD7MP5qOsAI5nnSk9pNw/mF/SV7Q6UFZrzc46oLIlm6tsUn8kEWyGO/gaXKkE
         hDCfbubU0GB5X2j80titr6ECZT00csmLVf/YjFucsAvLFCR/E6vFX78ER6/o9IAZPn
         enBKSUbA1qQxX5gsRN800MzKy4dx1FU6BUxtENa+iFIYKC7+e85AA4X+yD/ySMFYZ5
         3sAihiLuCrMxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4AD5E33090;
        Wed,  9 Aug 2023 17:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ RFC] profile: Add probe_on_discover flag
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169160162073.13361.9948723337406695908.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 17:20:20 +0000
References: <20230802201538.584029-1-luiz.dentz@gmail.com>
In-Reply-To: <20230802201538.584029-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Aug 2023 13:15:38 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds probe_on_discover flag which indicates if profile needs to be
> probed when the remote_uuid is discovered and changes device logic to
> attempt to probe driver when a new UUID is discovered and
> probe_on_discover is set.
> 
> [...]

Here is the summary with links:
  - [BlueZ,RFC] profile: Add probe_on_discover flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67a26abe53bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


