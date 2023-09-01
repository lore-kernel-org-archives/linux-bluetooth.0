Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC8FCA0FE4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Sep 2023 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbjIAQyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIAQyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Sep 2023 12:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4D810F3
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 09:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E003A623DF
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 16:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B24BC433C7;
        Fri,  1 Sep 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693587249;
        bh=yQ1EugiswnGjFQVkpnMRvUkisfUgOPZOo/d0FWlLVoU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gVjN9S+GqjhXFCMMzUGTgzlgA8uCB6UxQBRdsNymyN1tIL7j9zVZ3fH/WoRX49rYv
         YTRV/S/KB75eZIiFSipX1hCmBNT3yV9vpZyXe8kV80u42mk66D8r7yJXhXgz/3hRaL
         LyHhqYoW53H47Sf1h/GuNhrURyn1pDD8DEOjBZY4AY0bWlRiY77RqCp1V6PpJ++mov
         I5zNSOBDZfFle1YlN2tH39alWN2CdqNrbk3+ILl5GLPkWO2NXzMnLdiA/CReUlP3Lg
         uA4k6uoJSMLXSk0nQWtK+J2NFMyM6KCUtlH7HabfEYKWahHapbSdd8FwRN8mouEppg
         1oxmYRx0byJUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32649C64457;
        Fri,  1 Sep 2023 16:54:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: Fix not always calling bap_io_close on disconnect
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169358724920.14770.2803011071097075500.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:54:09 +0000
References: <20230831220137.1164891-1-luiz.dentz@gmail.com>
In-Reply-To: <20230831220137.1164891-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 31 Aug 2023 15:01:37 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bap_io_disconnected was getting registered for all links while
> connecting which prevented bap_io_close to be called when ISO socket is
> disconnected thus the cig_active flag will remain set preventing the IO
> to be recreated.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: Fix not always calling bap_io_close on disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d06b912df5ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


