Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE33C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 20:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiEIU13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiEIU1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 16:27:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FF590AD
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE3FFB81910
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 20:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C4FAC385B6;
        Mon,  9 May 2022 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652127013;
        bh=4pnOH/Him14GKb8UVz5ibDWuvJ0r3cuZvNH7HlfHiEE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qfgQtYXOEtcr8RcOgsiNLkHk02Sb7Udm1vlqvQnM08qY6T++xLRTTf1OhMBez+PCG
         8jyRxxZ4A93ATH69KOj3VXAb7TEY43Nmpi9AD1HWlQjtURK5Hs8+ki8uPN4tTmPlws
         +kDz/tpe7KirZSISkDJGzyG63DL1mYVAbt/HGAKf0G7qHQfuMJWKz4qB3WBLIrGkEZ
         7Q82stLGCtsiCkglXSYJcgTGp4I5sEMnLoVgnxCIptnhIkIcCYtxf1nWO74IoHLw84
         Gm1844DSwP7OIRoAAoKZQKVAi9zs/VDUerGbkH3upjph1Haq3POeO1Oon3OaPejlz2
         xWA3cktWUPcNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 784A0F03929;
        Mon,  9 May 2022 20:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] [v3] Fix few more bugs found by SVACE
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165212701348.18962.9637043732206595367.git-patchwork-notify@kernel.org>
Date:   Mon, 09 May 2022 20:10:13 +0000
References: <20220507173505.31249-1-i.kamaletdinov@omp.ru>
In-Reply-To: <20220507173505.31249-1-i.kamaletdinov@omp.ru>
To:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 7 May 2022 20:35:01 +0300 you wrote:
> This patch set includes few fixes for bugs that was found by
> Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Changelog:
> [v3] Removed trailing whitespace (style issue).
> [v2] Some minor style changes after CI check.
> [v1] Initial version.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] tools: Fix memory leak in hciconfig
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=efa90050937c
  - [BlueZ,2/4] tools: Fix memory leaks in btgatt-server/client
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a4741ef4bf6c
  - [BlueZ,3/4] tools: Fix handle leak in rfcomm
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9ec1cf8715d
  - [BlueZ,4/4] device: Fix uninitialized value usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42e9b8db92d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


