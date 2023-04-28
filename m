Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41608C77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbjD1WkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346689AbjD1WkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 18:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1C97
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 15:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E380645E9
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 22:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 841E8C4339B;
        Fri, 28 Apr 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682721622;
        bh=Qe3FaB+907JtIRAD90trhUY8MrPOFxOcvx2xk8BmxfA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Gr93WECKFzU2mZBfTWniwGO0Yq2IfVcDF+tZObgs1o2bBZ0JNQU2pp9rHTS+8RhkP
         0ZGfwtCi/34U+QCQMiaCe0tEar43lLd7/q6oS+MoHPfkcJuU5L4XxwQif/pfJ+UHb2
         GrUurh3ohLfOIlDjdri9fcT0ADghf+tLrmK3wDtFrFi1uzhQ5YewQiFGTEjOxMeiBD
         gqkfFjgtdYURDYYWQj35/Bn8/W/wZz3C2rkwPh6wvYinh/FHG92rPGwKRgjd9K0OHb
         fYzLxxLM7vlail63kHDQa7VPNuNm7cZ/QfSXE9CCsx37E/Sy7xCvEW5VKanZuOJt8a
         vKWc26QGGlDhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65933C43158;
        Fri, 28 Apr 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v4 1/9] media: Fix not storing Preferred Delay properly
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168272162240.28060.16995674551834368079.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Apr 2023 22:40:22 +0000
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Apr 2023 11:46:32 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Preferred Delay properties were being stored as qos->pd_* instead of
> qos->ppd_*.
> ---
>  profiles/audio/media.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/9] media: Fix not storing Preferred Delay properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a600c9bda9fe
  - [BlueZ,v4,2/9] shared/bap: Fix crash detaching streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1abd45bb45bf
  - [BlueZ,v4,3/9] share/bap: Fix not removing timeout on bap_free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=614d66302715
  - [BlueZ,v4,4/9] shared/tester: Add support for NULL PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74206678a97b
  - [BlueZ,v4,5/9] shared/bap: Fix typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3fa45f728cd7
  - [BlueZ,v4,6/9] shared/lc3: Update configuration to use iovec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b230fd2ba38
  - [BlueZ,v4,7/9] test-bap: Introduce SCC tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f7a518c85590
  - [BlueZ,v4,8/9] shared/util: Fix runtime error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3b5c0e5ed076
  - [BlueZ,v4,9/9] test-bap: Add SCC tests for Vendor-Specific codec
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


