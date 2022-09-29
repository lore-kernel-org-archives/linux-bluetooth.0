Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiI2VAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiI2VAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEC75FE2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648B5621A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C37D1C43470;
        Thu, 29 Sep 2022 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664485215;
        bh=j9wwZPHgPj0Zw+tw9a49VQt29cSN/BJJWncAVHBBU9c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=h/ObHbvgyOx07yCHchbpkHjWmIHQ0QTKTi0mxURPlp7ThR2bXCEyAU1/zYASITuX0
         QZB0w7CyyGbQ/mSNzNaopxJdx6jpTfhdpyIwYGkJP9gd9DP3DbgFJ+c043/hdzTI7m
         OwK/XD/4FD+OKz25Duk3mtRz6i31laYmrfPL8B5NSe8VHlio/JzvnczPWgbg6iZHna
         Sy4m7HeUcnS3zKhBbCXbYR3MI+YSc8APIIoCndvaxEAs7U9c8xkTN2kG91TQcZ8Awc
         rW9+i/++WNL51s+3oK7YoXxs62qXzV++DpwgH4vs07ifs8oG4BhU0TDn0Q+RYmajH1
         l1mxMfvv6a2vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8CD9E49FA3;
        Thu, 29 Sep 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/player: Fix attempting to acquire already
 acquired transport
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166448521568.31227.17921515065620740059.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Sep 2022 21:00:15 +0000
References: <20220928212649.3824261-1-luiz.dentz@gmail.com>
In-Reply-To: <20220928212649.3824261-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Sep 2022 14:26:49 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the transport has links check if the link is acquiring before
> attempting to call Acquire otherwise it may cause an error to be
> printed.
> ---
>  client/player.c | 70 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] client/player: Fix attempting to acquire already acquired transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25a31f5a930e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


