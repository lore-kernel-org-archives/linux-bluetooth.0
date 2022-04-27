Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF810C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiD0NXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiD0NXb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 09:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94722B6B;
        Wed, 27 Apr 2022 06:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC9961C15;
        Wed, 27 Apr 2022 13:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5579EC385A9;
        Wed, 27 Apr 2022 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651065611;
        bh=8jDvOoUcxtpGB0tdinnHwv098qHQH4gTR6DYWTw4rRg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RSDRqnD/zRJj+XcN16ov46AL22k2e9qtlII8Na8I/QTf95+l4NkDJrZI3mwcbXKw5
         Gf5LNDmKF5AxxOJVP4NIdyccgYUe9tUrZlJsJlbLiB6ec9bAyWsEVxH3KLeAgMWKfc
         J7Hu82X+dg3gsHQdg8zHwmIraBsEEpole6OOXpIf6WWJp27AMtV2YyWECUsS/ZyGNB
         ntSFpUF8XuLcU0ARJUbtJt5NGhbQ5OBNSHKm91GPDHJyOK4rDRQVXnZ4S69KsI2liO
         oruKjqmhjw6rqQux3H9MWwoYd3RD6fJWqHtj1TaCwseRoUjSQBtdA4C3iEQkmWo4tI
         sVRqYQVf43zcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C4BFE8DD67;
        Wed, 27 Apr 2022 13:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV
 devices
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165106561124.26395.8057057839532424333.git-patchwork-notify@kernel.org>
Date:   Wed, 27 Apr 2022 13:20:11 +0000
References: <20220427125947.10429-1-ismael@iodev.co.uk>
In-Reply-To: <20220427125947.10429-1-ismael@iodev.co.uk>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Wed, 27 Apr 2022 14:59:48 +0200 you wrote:
> Identifies as just "Realtek Semiconductor Corp. Bluetooth Radio"; it's
> used in many adapters, e.g.:
> 
> - UGREEN CM390
> - C-TECH BTD-01
> - Orico BTA-508
> - KS-is KS-457
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb4b8a352656

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


