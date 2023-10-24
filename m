Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688FC07545
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 18:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJXSK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343587AbjJXSK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 14:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FA010D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 11:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E18BAC433C8;
        Tue, 24 Oct 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698171024;
        bh=ac30dm6sbLTS+ofXOODU8A6sQRIOjsYpkUHPq2wwMEI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lInqJv2n5BWdmrjMi2v/SnvDiW/8EV7KxX4RL971pQ3/fTspjiKcOoFyuUsmqx7io
         Z38qmVUMTbVUb50PjlV8HTZLAwYB1g5F2oWJbajXULj+N+sR6YnPNkg7pX2iY4aLMp
         q7mKlKY12oD5APGSmZXQY4BtK+y2k2V+uycSZLuHwdYAVm+b/L1huGo/VfxhUDon6I
         ycujOBacMNPnw+zn7gkX0QBbmffyjI+02WrM7u+n5bjzH0OnyyIlJXtln1NIIo5iO/
         TZxTmeWinpnMVbIGK49HkuUXqtmzTQl0Ym5cCEh4YqPGS8Tzb1qNg+yWo/3ylWOBVm
         HX8AXqZNxci6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF029C3959F;
        Tue, 24 Oct 2023 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169817102477.23101.13839519077367788681.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 18:10:24 +0000
References: <20231024105735.3216-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231024105735.3216-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Oct 2023 13:57:34 +0300 you wrote:
> A Broadcast Sink has no way to know how many BISes are available for
> sync or their indexes, before establishing PA sync and reading the base
> struct.
> 
> PA sync is established by calling listen with DEFER_SETUP and accepting
> a PA sync socket.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] Bluetooth: ISO: Allow binding a PA sync socket
    https://git.kernel.org/bluetooth/bluetooth-next/c/0783375f2c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


