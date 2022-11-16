Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C456C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKPWAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKPWAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 17:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682458027
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 14:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D583C61FED
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 22:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41165C433B5;
        Wed, 16 Nov 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668636016;
        bh=VljnB38trQ5DJ/sZgWikrByY68MuACBKD2o9aFs980s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iulWWC9RVJZga/dvlxeZtq/h1MUJZu/zPNmbEbglI3YU9LPbuAny8cUeTDXtiigTn
         2n5viqV2fwyavsXuqq50YGfk887Exykh4Qa0VQtXzlasSE/k+4CrP+wgzBPOes7Sqy
         CcYOtpPA4maSUDVBhp5CSErkX7G9mb3ZiXHIm/t+x4JjCxGwMa45ekrjRyjeUOBvtB
         BRT4YKkPfN/3039kMtx+3Oqh7y93VsibDQ0HvznYw20HHd95RQFag8O8ge4LxvQ0oO
         JCIsEKvOvNzGZDynLSqj744kdnEZQbYPrJeQpUXrYXBDHzFSCwM6aaiq78iAu3tDh3
         q1xYihxxfDy1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23FA9C395F6;
        Wed, 16 Nov 2022 22:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 1/2] hostname: Add '' around printed strings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166863601614.24508.15137788773620027873.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Nov 2022 22:00:16 +0000
References: <20221109151756.96673-1-hadess@hadess.net>
In-Reply-To: <20221109151756.96673-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Nov 2022 16:17:55 +0100 you wrote:
> Otherwise we can't see whether the string is nul, or empty.
> ---
>  plugins/hostname.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] hostname: Add '' around printed strings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e515f4b6e25c
  - [BlueZ,2/2] hostname: Fallback to transient hostname
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


