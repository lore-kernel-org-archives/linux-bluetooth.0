Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF7C531DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbjHQTua (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354800AbjHQTuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 15:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251D5359B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBE367133
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14824C433C9;
        Thu, 17 Aug 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692301823;
        bh=hVjV91VIswB3oEZ6G1FxsNtJapuvhc0jpiklbn4AisA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QIzNyPyz0fUVJzsvRqo/BwFYxKpU0yICwBS4ETr52+RCmYHKz8xdb98rVeUX1xE3X
         ZRZthJPq78KBrWjouF1YdGgNdkZSnmU8x9tZnrFA9Tk7scVpkBJjZNJdyz5E2EnjP+
         dqCYpKOj2q7hSvDeGvh2VCnUJaxzrajDgaAWkAl/hZQMwCB8vQYamNXD3PT6qSTjDL
         As7Vm+sAMPWpBSQZKZXRw4TGQveJ1q2MaJ1fkYZDMFPlXeNGEiUizWKnPhkNaiVe+Y
         E0md+a8G5fgvBGpPvMS7Er6LJ/whTw3KB3QBmlK3OtyBTZvSkG0GDoOfPbbFkjBjlO
         2rTLR+l/kTjww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E95B8E26D39;
        Thu, 17 Aug 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] iso-tester: Add test for bcast receiver defer
 setup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169230182294.7718.1928875158611497747.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 19:50:22 +0000
References: <20230817064853.3706-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230817064853.3706-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Aug 2023 09:48:52 +0300 you wrote:
> This adds the following test to validate defer setup support for the
> Broadcast Receiver scenario:
> 
> ISO Broadcaster Receiver Defer - Success
> 
> This patch depends on the kernel support introduced by
> https://patchwork.kernel.org/project/bluetooth/cover/20230817064427.3647-1-iulia.tanasescu@nxp.com/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] iso-tester: Add test for bcast receiver defer setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60731cab5891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


