Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C16CECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 01:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIVBK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVBKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196752EF38
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8646334A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D4CC433D7;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809022;
        bh=a24oiN58/pDDIg0uS7kQ7GfXWqrE++ReVuOZRzMS0bE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jy5HH2fAIQneEq4T4zWzOfgjLVNlpxEMskkJuyg+LTGxZQqSjnkzQatZNuJxzUwoV
         +r4DY2anA77ToYRG/imRDopXSRx6oRUTi31QiaN989HHGwwUsGmlhwYNLD/51VzPRR
         qnp7+ITGj55TyuiBWBy3R4rw4/U7IQjKX2Tr0zGhh61qtjxOwmPihHkI1+GvoscVmu
         kabMIhLfoaATj9XXPn8AHWdWoKh+Xz2tL+6njOh0LTo0f27SjuKP4+o6Sx4BnI6kER
         CSBYHle9qTW2pdLK8dYDusA/ffEHulUfmM+2LBnU1AiERqwHo4OyDn8FiNZRt3vNB8
         sgvmh/mYNfzXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0430DE4D03F;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gatt: Fix scan-build warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166380902201.22214.1847121678282317101.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:22 +0000
References: <20220921215041.2243423-1-luiz.dentz@gmail.com>
In-Reply-To: <20220921215041.2243423-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Sep 2022 14:50:41 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warnings:
> 
> src/gatt-database.c:3541:14: warning: Value stored to 'iface' during
> its initialization is never read [deadcode.DeadStores]
>         const char *iface = g_dbus_proxy_get_interface(proxy);
>                     ^~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/gatt-database.c:3542:14: warning: Value stored to 'path' during
> its initialization is never read [deadcode.DeadStores]
>         const char *path = g_dbus_proxy_get_path(proxy);
>                     ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ] gatt: Fix scan-build warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31b32daf5292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


