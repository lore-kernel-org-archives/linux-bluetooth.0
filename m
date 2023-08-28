Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01455C83F15
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 19:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjH1TU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjH1TUg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 15:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED797124
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 12:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B50F61B1D
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC4AFC433C9;
        Mon, 28 Aug 2023 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693250423;
        bh=4PbJ6S9VC6X/FLxXVr7zo8nlFY/8YFOUcWbB6hQpO1Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dvvPuHEv4L4AynxYimoBPIB+WCeHcUuhmu66kMDAQrMjWN0EbiGArQ1vNCMO2WJoH
         ftW8pcSl61eTb+YDWF2JhDZdQXAw5p1dJ8JhJUe5YqZSDamW9ETT7per3FV/bkMe50
         nMZvSayHI+8Fp6wfVPZTK5l4XmPl4E4Hvh3pbVsg+nWk+daU/eoKkqPilRudypdK5z
         lFXidO+knBgPJJL3G1e/W5KtgWTZsrnMy810+HjretqzvXVcN9vsaoznGneWgYnMaW
         l++g9KrjWDJMhCB1lfLi3iaGjiiCakde79m2CMcRreKDtWpgdlzBL+gd1ML9Nl18S0
         8PaeVzGSWCNyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC8DFC3959E;
        Mon, 28 Aug 2023 19:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix not sending confirmations
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169325042283.1681.5228390738678162080.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 19:20:22 +0000
References: <20230828175553.518129-1-luiz.dentz@gmail.com>
In-Reply-To: <20230828175553.518129-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Aug 2023 10:55:53 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL
> callback") added an early return to the notify_cb function when the
> current client's notify_list is empty which prevents sending
> confirmations to indications.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt-client: Fix not sending confirmations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=670f0d0f618d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


