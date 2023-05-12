Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D7C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbjELUkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbjELUkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 16:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41E26AD;
        Fri, 12 May 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B880465478;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01047C433EF;
        Fri, 12 May 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924022;
        bh=RKIqn5ReoDtSG30aKnJ/RVp6p72OTuvMIOYGF42F4O0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WZGWI7bU0YiAKqoWu8OivC3C87w/fcB9WlxpaL59Sl2IE/g1II4aCaVkMhOySyfZM
         /TSlrsBXsYHS6qvnIpR7z0s/v8ZsScLOb3WowEeVHX8LOZh6Pp12tOGLx2rpN9nxv1
         v56VesT71Yn1clDI+k4917hTWpYLRy5oUMsrNJaa5b282Vmi3BKcYc9LmS5GfK6bIi
         Sr6o9QiLzOvMHPq9IYvB2Ylr7FIHLiT92uQL/qrjUR8GE2yBgRnw6t4d4AaRszNzxx
         hzIpSyCvDWKLG9kdpki0cCc2zUtDH0H6CodPc1PIZXoxDgOPZk6r0Im66/tw01roBL
         jroR/9dfGmkZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6992E450BB;
        Fri, 12 May 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE
 declarations.
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168392402180.13139.16855798120553945065.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 20:40:21 +0000
References: <20230504212843.18519-1-dan.gora@gmail.com>
In-Reply-To: <20230504212843.18519-1-dan.gora@gmail.com>
To:     Dan Gora <dan.gora@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 May 2023 14:28:44 -0700 you wrote:
> Add missing MODULE_FIRMWARE declarations for firmware referenced in
> btrtl.c.
> 
> Signed-off-by: Dan Gora <dan.gora@gmail.com>
> ---
>  drivers/bluetooth/btrtl.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations.
    https://git.kernel.org/bluetooth/bluetooth-next/c/5a0830d69a77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


