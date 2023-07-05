Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31EFEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjGESAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjGESA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868691990
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD765616BD
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29AD6C433CC;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688580025;
        bh=ddF/WQDerc73rVeVdkju9RXRE+Ez6OU+5E6SWnhUoKw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UuXn75Y7qPXJTAQBC8GQol1C5UHBEhnZWxY0xjSwS1Cxfmt3FESI44Zu7xxdmewdS
         wtowR9SC8PHlKlKn0rUv7h/ARbxftwTpPIyKkZxPQZkmTRxS2UlsU8UE0oa60FMXLA
         2I4XQYjJ/7Fq/xE3PUNMZ6qAvi4JPCKeM/Ik9SUcd0RJPhSa2MqHMUc6ap8MnJJ4hb
         gwQZn3ATy62lxJV2T4/xkS7Id07ATYno4GMHxgZgxRtUKrwI7wKqmDWVkqQVPPi59B
         gvkLwOIsVoFXBNrd/iJ4yORWNRg5jIfexeF3YdovcAOiupisZnGwS5EVeGCFR1pp3+
         hXDHptBThubTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E78C39563;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] monitor: Add decoding support for Sync Receiver
 events
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168858002506.7518.15339114840676364173.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:00:25 +0000
References: <20230704074144.5587-1-claudia.rosu@nxp.com>
In-Reply-To: <20230704074144.5587-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Jul 2023 10:41:43 +0300 you wrote:
> This commit adds decoding support for PA Sync Established,
> BIG Sync Established and BIG Sync Lost events.
> 
> Claudia Draghicescu (1):
>   Add decoding support for PA Sync Established, BIG Sync Established and
>     BIG Sync Lost events.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] monitor: Add decoding support for Sync Receiver events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9557931ad36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


