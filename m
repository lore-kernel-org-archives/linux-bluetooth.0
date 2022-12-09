Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72619C04FDE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLIVaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLIVaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 16:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A479CAA
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 13:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75E11B828D4
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 21:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F6A2C433D2;
        Fri,  9 Dec 2022 21:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670621417;
        bh=SDfhErqHx6HgnnnONSZK60SZDX5pujKv9AlFTu7k7ac=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UP5GymdEivdcFRo6GBTWlJHX0GphS430dHd7cAT23IzI6no9fqBPk1T8SRNOE2FTx
         ehJ/LQXSOS4jhci7kBnAc+kPJmJ8R9QYWSIzBqI0bxEDawuC6xTymBoOH7jjylsaLN
         dDpTj4O8JyU1cfBzk4v566nK4b68pj+hzs7KkfMLlgUGl9lurK3LDp1lO53603NtJC
         ihsIH6RLZRqvyOKX/p+BwitRK68bA53Xa/cLVsp8xe/O1yfGR3MgH57ETZKO4Pi6/u
         jZqJYy3MtxV/TiZMpzQZwIV7cJhBzm4ksAqa58i3IXtn6x4J6Wa7ndv//h94p9NwnD
         xKg3dggvfVoHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17212C433D7;
        Fri,  9 Dec 2022 21:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/player: Fix not calculating time to wait
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167062141709.5923.670959168737380822.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 21:30:17 +0000
References: <20221209180312.938166-1-luiz.dentz@gmail.com>
In-Reply-To: <20221209180312.938166-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Dec 2022 10:03:12 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The difference of time start and current time may have advanced just
> enough to add a second leaving start nanoseconds to be bigger.
> ---
>  client/player.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ] client/player: Fix not calculating time to wait
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e07c1e723ee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


