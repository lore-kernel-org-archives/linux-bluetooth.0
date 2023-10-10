Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2073CD98CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjJJXk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjJJXk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 19:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CAC6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9921DC433C8;
        Tue, 10 Oct 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696981224;
        bh=IWiH6sWfc/o0z2MwSgcC2gbDKg9onqeaYGbSfO63i6g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bw6fPCXADHaJqCVvZ8ldby33h/Jc2XV/znMzUNx4bk1vMU2fFxnHzOQyZP5EARxx6
         b2Ne3KBfeFXyS/7u0JlpRGSYMFV5Ru5HsIw3PSuf5XyWiHJb7rRRaBnB/9ltFX8Zbc
         p5SLI83R0+OIZ6FsPXCww9MbcdVJQU/eD1S197r3EhPy5z79bSjPma+qbsZ6ymjPvV
         6eSdzEIl0uBzIEEQ2oIhxYPPmG/BbW1zWvYWlayW+mjUnaHhhKW/+wMLix17/0XCcF
         WjBU+6e5iUEJHu07W9NHL3JOekadam6v1O0DSn9994052xSV6UovK/N/IDULujzzE2
         A+zbY3ourN84g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB35C41671;
        Tue, 10 Oct 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] test-bass: Add unit tests for the SPE suite
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169698122450.27583.10029537976359071333.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 23:40:24 +0000
References: <20231010153855.13825-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231010153855.13825-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 18:38:54 +0300 you wrote:
> This patch series adds BASS unit tests for the Service Procedures Error
> Handling suite.
> 
> Iulia Tanasescu (1):
>   test-bass: Add unit tests for the SPE suite
> 
>  unit/test-bass.c | 430 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 428 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] test-bass: Add unit tests for the SPE suite
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ea09cf6b9b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


