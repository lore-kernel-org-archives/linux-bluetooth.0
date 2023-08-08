Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23986C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 22:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjHHWA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjHHWAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 18:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA310C6
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 15:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E590461A5A
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 22:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B042C433C7;
        Tue,  8 Aug 2023 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691532023;
        bh=tZubW1M95cTB0j3w9pzhgO8aAxf/gkUPMCy0VXVpypU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SScIt1Lo9mVvNZGCIiyUa6LmQBHfLvBH6XXMgA8BA8RgTVs+8vkP3ORqQdvA9USOT
         JVZT9UQY66ew2ULNKgiCpjzma+w+3A/5B5JFTVkqNUt9+GwgkKRdX48k0mJMQwrYgI
         83uwUeh+hRB+0SQPc2WlgBpNXBnEVr790oGlazvjjD/hQllqNGErGxdOD7r5T3JSdJ
         VYPcqhlmJLByvvtddaN4AwZScB8cpKbhDo0FY0H7hD9U4aQfQmKlTrZiSQMaxrOw+V
         YvsdCI8PqWBtwSYVd8SQIclcX0cG123l8XMWX7ByVpI008282qKVAar8TQOHW8Qyx7
         V5XqvL6uZu+9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45C06C64459;
        Tue,  8 Aug 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] btdev: fix CIG ID on Set CIG Parameters error
 response
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169153202328.6931.13282155890160699440.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 22:00:23 +0000
References: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
In-Reply-To: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  5 Aug 2023 15:29:06 +0300 you wrote:
> Set CIG Parameters shall return correct CIG ID in Command_Complete also
> when it errors.
> ---
>  emulator/btdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] btdev: fix CIG ID on Set CIG Parameters error response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=459b095c663c
  - [BlueZ,2/2] iso-tester: test busy CIG error does not drop existing connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=96de1c6eb9ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


