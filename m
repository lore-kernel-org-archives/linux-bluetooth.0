Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FCC7113B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbjHWXum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjHWXu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031A10CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939E863E97
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0916FC433C7;
        Wed, 23 Aug 2023 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692834625;
        bh=o9sioJW4wVXpyaKWCQ6nfRvsCH1G3AYxTRnZSvMTyIY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nqIsgT9ENtbM2YmzMLXqFBagqMlR0m/ujL3yxH2I2olI7EGkd2DSrIYHSyieAxigS
         eBCq/8kUydRYgVc04LVItOd875gjZkWLBwFmDKxnjo6yeBMNqzxK7CuHOBmr/ptb77
         hI4o8MjsfwN+oHZPf4nE9oljEigMJDw7x4jHY7nMDOmsKihtK8BCYhCfkGPDCAOqBU
         dFOy9O25jKkIVEYbEjwluF/vUwOoXfkPTjuBf8pRMw/EQHnFGQms2gyjJqljTLQJuc
         eoBn9/jkGNAEYOEsnxnkU44CKeq8DFKdlH8MQD322rTd93fDOEk1OCsMimE1vCmgw9
         /9ECdn9QDxwoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E39FDC395C5;
        Wed, 23 Aug 2023 23:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Fix quirks table naming
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169283462392.23213.7059667248829697525.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 23:50:23 +0000
References: <20230822102033.1169580-1-hadess@hadess.net>
In-Reply-To: <20230822102033.1169580-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Aug 2023 12:20:24 +0200 you wrote:
> The quirks table was named "blacklist_table" which isn't a good
> description for that table as devices detected using it weren't ignored
> by the driver.
> 
> Rename the table to match what it actually does.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Fix quirks table naming
    https://git.kernel.org/bluetooth/bluetooth-next/c/5cef82c572a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


