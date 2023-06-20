Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42176EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFTUAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTUAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 16:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18FD1726
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4275760F25
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 20:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B9F0C433C9;
        Tue, 20 Jun 2023 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687291221;
        bh=2jrFnYMT64msN8gbT7Cf6r9KePiz8zRYsj51VbiqCCE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OBV2wh3/JSe4vku41Gq6rfL/mdHqih3ehmKDS2TMJPCL352W80o4uaBkpbxApA7gM
         M0CsIfhLagWC5yoGImXGfH5M69hTIHn/wQuT0Ax27k6VQRC8uthgfFrRV2sxGKqEvH
         +XOqK5dlHXMIHNuP/dsdR0xF4iDPN47Pvx35Sac91j/H3FDyH8m2cKP922xpYw60hJ
         WWk0W9PFR29jF81jGM/H0nyoLBlc1PX/zgkTyS4vfCAN3L8bDCzKFtdTXhTDLLmj5q
         YmZvv5E2SJ0PqNHoj27uF3Abe71WhwxZJLK8aeuEBXgXjqrppWBa2D5n2XxlUM99bw
         +26Ki34uxj2Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F7A4C395D9;
        Tue, 20 Jun 2023 20:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] shared/bap: Add unespecified bit in audio context
 to PAC records
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168729122151.31368.5072889026156893704.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 20:00:21 +0000
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Jun 2023 13:30:28 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes sure unespecified bit is properly marked in both audio
> contexts since that required by many platforms in order to work properly
> and while doing that add proper defines to the defaults values used in
> PACS.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] shared/bap: Add unespecified bit in audio context to PAC records
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62032321bfe8
  - [BlueZ,2/5] client: Print integers decimal value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2c9ab2d3f411
  - [BlueZ,3/5] client/player: Fix auto registration of broadcast endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0053bc5472b6
  - [BlueZ,4/5] client/player: Fix transport.acquire for linked transports
    (no matching commit)
  - [BlueZ,5/5] shared/bap: Pass bcode as a reference instead of value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95d3e66524bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


