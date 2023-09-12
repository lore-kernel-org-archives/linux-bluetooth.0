Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09968EE3F0B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjILSuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjILSua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042E12E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92E94C433C7;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544626;
        bh=m3sNP51TdGv0iuyZF9pp/r01s02yjH9zQxcihLE0OQU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DkcHnAWhPlb/vwlcKITpElQvq/zgobl0tTTxOfSq4mtpkwThfWbs5Sw6X+4RGJ8Wq
         EplwIiAla2unfeQaDU8rGr5sdvw20UcxLf2pZxJ2Y3UlAjHHWJwrsKnA+8C5KJidNh
         7NIalxCfkg9RKruoW3GEn7bzkpWm7++4m7N/Z6L4uQ1NePSMta0cdinxI52SLUO1Ve
         23z1vcZds8/4HtVK6Ou3+g1VLkjc79zp3HHu+Jq/BLPGC/ilLX45rLGMhqUUpLStEn
         YP9OGkKkZQl8ppvKMyYLQuMFwxaZG2kbb4u0QShXp0nm8ByCmlKitA/FeH+BadyuYa
         MrjODys1osPTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 708E6E1C28F;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] monitor: Use proper name for CIS bit
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169454462645.13260.14463828128805376542.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 18:50:26 +0000
References: <20230912070319.1224301-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20230912070319.1224301-1-vlad.pruteanu@nxp.com>
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Sep 2023 10:03:18 +0300 you wrote:
> In the Bluetooth Specification the complete name for bit
> number 32 is "Connected Isochronous Stream (Host Support)".
> 
> Vlad Pruteanu (1):
>   monitor: Use proper name for CIS bit
> 
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/1] monitor: Use proper name for CIS bit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f838361bf0a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


