Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5829C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 21:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLIVaU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLIVaT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 16:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CA8326C
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 13:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B697762346
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 21:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2526FC433EF;
        Fri,  9 Dec 2022 21:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670621417;
        bh=r17QHWHy1C5SuoUoHT/7k89Ovpx4WM63Hiur3MazTro=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UzSH2F31Ev7wJRGLeIJw/v8tV42feRi+zVDdDd2OTe8cKLu9KXb+iobeOoYmemhJm
         qGQbgE5poiupzNwvNStdc2Hr9eTU1rGYbPQh4uqD5eUqXRxAO1VJVq78b/6FnTQyFy
         aih2Ea5o0vgTeBTltpT2iZBw5YKBi92Ay0pGZMhxtQFobWGu+/eE5vJHTx/GFcLwAF
         vIYcKXFBFn2V3nzzvCnL6/MNl4qwRoxX/18n50nbWK9ZPAeHWeI3B/FBe4bBkjaQGl
         C9gIRjpW7u2GhFaIBPcRVfeYN31xhnCECepf5drqwyQ0/0GpyFIE5ORZ7JrAsBGWjp
         tHSrK56+FY4pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10AB8C41612;
        Fri,  9 Dec 2022 21:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] shared/att: Fix not requeueing in the same channel
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167062141706.5923.11666293894073785331.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 21:30:17 +0000
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Dec 2022 17:03:10 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If request needs to be resend due to change in the security use the
> chan->queue otherwise it may end up using a different channel.
> ---
>  src/shared/att.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] shared/att: Fix not requeueing in the same channel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8670f9aa0a0
  - [BlueZ,2/5] shared/bap: Log error message if request cannot be sent
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b5b51392312
  - [BlueZ,3/5] shared/bap: Read PAC Sink/Source if respective location is found
    (no matching commit)
  - [BlueZ,4/5] shared/gatt-db: Allow passing NULL to gatt_db_attribute_write
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be9fc9222c03
  - [BlueZ,5/5] shared/bap: Make bt_bap_pac_register to be per session
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


