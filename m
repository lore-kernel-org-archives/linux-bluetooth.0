Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CDC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiIWUuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWUuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 16:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD7B6561
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 13:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD101615B9
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 20:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED3B4C433D7;
        Fri, 23 Sep 2022 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663966219;
        bh=a7X/lKqzZM/vI3I8brnFvZQSDQKJ2RWXu+izBBAGeGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BNFK5hGP1M7gL+v3b+J8OXqCZYsOFuGjufgEkdg5WV40DuO9i++bhuyt/0073uW9o
         P+uD8ZulszzWpHPdxkD+LHslMlwAxKmLhlgkOjNYDsjuy1TQ5eESM9UQckvQh8U0Ws
         qzST2aMOZIMIOZ8UUyJDlyKIjj+PlK9vFXSvJcsDldhNuG9+DnQFApNZZu/Jy58Nhi
         gNPZRKmLGp7ELY3OTo8GFpEqCeoFDVrKkd7Vb0vT8M/WulCNCCwuqhqJWba0QhgSOu
         G/zHpLgaiXCnrc+q0/YNef2lEYQ9tbV/CHTfjA9rUqDlknFUH7Nva3b/ikY0LLlVMb
         pJC692+TDKZ1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7218C73FEC;
        Fri, 23 Sep 2022 20:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/9] properties_changed: check for NULL iterator
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166396621887.24262.5531691450282001908.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Sep 2022 20:50:18 +0000
References: <20220923145602.25872-1-ceggers@arri.de>
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Sep 2022 16:55:53 +0200 you wrote:
> v2:
> ----
> - 7/9: don't call memcpy(x, NULL, 0) [Scan Build]
> - 9/9: shorten GIT summary [GitLint]
> 
> Christian Eggers (9):
>   advertising: parse_secondary: fix loop condition
>   advertising: parse_secondary: fix mask value
>   advertising: parse_secondary: check for NULL iterator
>   advertising: parse_min_interval: reset min_interval if iter is NULL
>   advertising: parse_[min|max]_interval: reset value if iter is NULL
>   advertising: parse_tx_power: reset value if iter is NULL
>   client/gatt: proxy_property_changed: check for NULL iterator
>   gatt: proxy_property_changed: check for NULL iterator
>   battery: provided_battery_property_changed_cb: check iterator
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/9] advertising: parse_secondary: fix loop condition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47821c473102
  - [BlueZ,v2,2/9] advertising: parse_secondary: fix mask value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2e4327816587
  - [BlueZ,v2,3/9] advertising: parse_secondary: check for NULL iterator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=732eaa7ccf85
  - [BlueZ,v2,4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=abfb3a807c39
  - [BlueZ,v2,5/9] advertising: parse_[min|max]_interval: reset value if iter is NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a18d66862da1
  - [BlueZ,v2,6/9] advertising: parse_tx_power: reset value if iter is NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47346e5390bb
  - [BlueZ,v2,7/9] client/gatt: proxy_property_changed: check for NULL iterator
    (no matching commit)
  - [BlueZ,v2,8/9] gatt: proxy_property_changed: check for NULL iterator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5cbe08af22e
  - [BlueZ,v2,9/9] battery: provided_battery_property_changed_cb: check iterator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15895e401e1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


