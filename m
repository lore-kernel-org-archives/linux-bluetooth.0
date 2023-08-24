Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A346C71153
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 16:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbjHXQkp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbjHXQk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 12:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A810FE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 09:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BEB673E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BF5C433CC;
        Thu, 24 Aug 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692895224;
        bh=Hb8c8wTGFvZdjAZFVJfl3YmikqUU9JsxBmn/dslAEY4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eEE/VWkI4IfCQjpjSSC+gcl8Ttck712lPGkXlaBhH/pLQJJsjSZjJIAMUng7l5CfG
         w5l86xhWYe2zx0hioNruPU4P8d+aMYYtVjWkqo4fqnVY1B7KLyFhkNXwqh1xZrREYU
         r9hUQ443IXxLclcjexwMGNz6TPgZRHAUHl0hkjDmh9jl6WFGb2+ehezsbkAIzn5Kb1
         B2JNBLDhKyoM0tUtnwALLEzDiiSzKtB8GSQptNyxko8Iu6WcX/3AkWtsIZ/UTHlTnf
         RtZu4NMWiQAkWt1qNXGdxUMIPGI7nYaMmlUsXpE2uegGhds2eUd4ja21IfirLxClrA
         lBdQnc1hoKTCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 556F4E33093;
        Thu, 24 Aug 2023 16:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: Fix crash with broadcast properties
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169289522434.24729.8894359712321736185.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 16:40:24 +0000
References: <20230824050045.4019298-1-luiz.dentz@gmail.com>
In-Reply-To: <20230824050045.4019298-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Aug 2023 22:00:45 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When connecting a BAP unicast stream the followin crash can be observed:
> 
> Access not within mapped region at address 0x1D4C0000000A
>   at 0x14F759: get_bcode (transport.c:1121)
>   by 0x1E02E4: append_property.isra.0 (object.c:498)
>   by 0x1E03B9: append_properties (object.c:527)
>   by 0x1E2AAB: g_dbus_get_properties (object.c:1811)
>   by 0x14B9B6: pac_config (media.c:1130)
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: Fix crash with broadcast properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6741c40816b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


