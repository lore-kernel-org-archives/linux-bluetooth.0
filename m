Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiC1SBz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbiC1SBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 14:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4B40A2E
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09CE461194
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 18:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6276EC3410F;
        Mon, 28 Mar 2022 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648490411;
        bh=BMM61RF9Rb0lJcARw9cAVR8Qb0YMrf+nMkFaSC/Bw4E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eNzEiARPvhU/fCXbsJ34d5C3j2NJbwLQ++XF59HHvdjGYwrhDxcIWHT0umpMnXLMd
         3Bw3FwtLPsZnc3ghKfgBCVucPF4yKWnUsvwCMwq1IoiZglknm82JyDLJvI0e5LHBjO
         X44mRqIZgOLtzZRM/35eFr/+Dbrp9WkEw9rxYiDByZQN/KRMYdgwWhpzp8ztQ4Gz2Y
         dMV9MN9zSzwetLjceY5q9rDnGce6N2y7UffFTaz6ygMJxwyA0587hu5telB6WWIx7b
         xLErOlMjd46YEYECAoGD5VCi2ie6afHroGzOx0OkBDczWiT9ndMV6IHaEX7WjxwVm5
         YFZE2SnA7os8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C740F0384A;
        Mon, 28 Mar 2022 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mgmt: Remove mgmt_set_verbose
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164849041124.15036.4321838478856852508.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Mar 2022 18:00:11 +0000
References: <20220325181617.332701-1-luiz.dentz@gmail.com>
In-Reply-To: <20220325181617.332701-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Mar 2022 11:16:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The likes of btmon already decode the commands/events so there is no
> need to have the code hexdump their contents.
> ---
>  src/shared/mgmt.c | 22 ----------------------
>  src/shared/mgmt.h |  1 -
>  2 files changed, 23 deletions(-)

Here is the summary with links:
  - [BlueZ] mgmt: Remove mgmt_set_verbose
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cb6e2ddf447

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


