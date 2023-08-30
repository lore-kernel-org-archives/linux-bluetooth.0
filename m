Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C02C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 23:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbjH3XAp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbjH3XAo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 19:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50C10D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D927F6370B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F5DC433CA;
        Wed, 30 Aug 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693436425;
        bh=m7OAM4M03Lw7ziBl1zu69fC8007kaq/U0hsLDtGoEok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BylDqeHfSKTSp3tlNew9K5fDES7ZBlmCTXl1cTDdVlm6xNGTN0P6wcFSwQgYuIg9W
         bNg53iy0ghxQBvLgT3pOwjEXwopJf/3aToWyaVrvwNGHAmrkZU9jLTtXjxC7RIBews
         bAOWwwzV3/KjO57aMPHsNV+kvvOamc5IW9oDrlRr2f4LNJ4E7mwsi/Y3GOWIZgeFYL
         nzCGo5L1/G1NagULJf+OjJHpUnjck8fTmj6JsHdLv7dZ0RJ/g2Zc7XUJsM+tdRRjqr
         9MBMSToDfw43KNuIuWSkDQ0bJO482uale0fOQ8QztY5Wu0EAdw9dtfcwHaLbf5LvJf
         neZvhndcfnKAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29BA1E29F34;
        Wed, 30 Aug 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media-api: Make QoS a single property
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169343642516.10818.4526640145032766076.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 23:00:25 +0000
References: <20230828233239.634106-1-luiz.dentz@gmail.com>
In-Reply-To: <20230828233239.634106-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Aug 2023 16:32:39 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This moves QoS related properties to a single dictionary.
> ---
>  doc/media-api.txt | 78 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [BlueZ] media-api: Make QoS a single property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=530afa43ec29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


