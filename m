Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89312C636CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 21:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjA3Vk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjA3VkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2803FF0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 13:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4726127D
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3C64C4339E;
        Mon, 30 Jan 2023 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675114815;
        bh=QkDJjvZ/evv4VWdaYEp7yhuGZvJmzqgIOdwJgcxVMsA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F948IrzaNGAUxubKjl0mhuD2Pnigm+SFE6LZeaF9JZmz0+Zk3UhAFzRbSVt0ZPQFV
         K6ONT9MeSqBQyMWOQinOceyzZiLEG1eCIl/GeZVpRdOogPvOZHhsqZEfhG4FhDLnWv
         8UA0zWKC7W9gcAkq8zWPg+X11t9Pwc0p1iUJgOmzb2hi7JA5OhERDpiW7lRb16LNSw
         63E9+CQKbylu3gMcVs1iwIcbB8Fg9aO/81eZD8c9PNKwkH/qTD+ctHlB/jrqhpnur5
         GcT2TaPlxE7VE6kbbb4Y7wPlBqMmmD/MH7f88KdDuOGfvmLdj9GoQBntE3VanOlhYU
         ctNoCZZqzhrSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB26E4D014;
        Mon, 30 Jan 2023 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167511481571.2348.15966886740498131999.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 21:40:15 +0000
References: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
In-Reply-To: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
To:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 28 Jan 2023 07:37:32 +0100 you wrote:
> Add UUIDs for: Common Audio service, Hearing Aid service,
> TMAS service and Public Broadcast Announcement service.
> ---
>  src/shared/util.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=efba4618dd2d
  - [2/2] AUTHORS: Update Marcin's email
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eee6a75adc93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


