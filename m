Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B1C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiHBTuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiHBTuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 15:50:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E42BD1
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 12:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B857CE2155
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 19:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71EEDC433D7;
        Tue,  2 Aug 2022 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659469815;
        bh=lpGIt7UYcALHnUCZ1lZfky36U0FayFPvT0BfuW0gBzU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aVXYlJ+yhfVXVwgDdMbt+Aa2J/4aLRKl7uAo98a8njIOO/ervaKu15eTMUa98xIYQ
         UeFsNS04ahKZLZXDDCMneGNUufOwAv/yTXAOBlzwU0A8cg0Ppj2H6Vtsmkm4B9CaNB
         31E+E+sgZPFeO+X3C4Ra7aeclr7/MJBZ5r05g6a53Qv/a/CBQtTNSaEv5dQK3LPf83
         o2Pm2H5JMnwSV3TJSzQ24OhN/OX6G5QLYY8L0ckrjdH6HRqhRXMjIEt9Jvz0PG9Ww6
         0Qo8ULqXZ8s+oyijeypv5zsUZ4YxIApFr8Mt40P3uoKlkkQ/3nKxvG3pHpSOW73G6v
         2Y5rrp0mKCOLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A9D3C43142;
        Tue,  2 Aug 2022 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] device: Add btd_ prefix to device_is_trusted
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165946981536.12327.9783983495977391234.git-patchwork-notify@kernel.org>
Date:   Tue, 02 Aug 2022 19:50:15 +0000
References: <20220802163441.2522333-1-luiz.dentz@gmail.com>
In-Reply-To: <20220802163441.2522333-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Aug 2022 09:34:40 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btd_ prefix to device_is_trusted so it can be used by
> plugins.
> ---
>  src/adapter.c       | 2 +-
>  src/device.c        | 8 ++++----
>  src/device.h        | 2 +-
>  src/gatt-database.c | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] device: Add btd_ prefix to device_is_trusted
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7adb3aa7efc3
  - [BlueZ,2/2] sixaxis: Fix fliping device.trusted automatically
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a65ddf710584

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


