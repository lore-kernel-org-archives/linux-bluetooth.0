Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C73EC875F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 23:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjIGXAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjIGXAk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 19:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BA1BDC
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 16:00:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A1EDC433C7;
        Thu,  7 Sep 2023 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694127635;
        bh=2KkVqrO2/3UF6s6JSeEgaf01+DtGCWMG4dysUeP6ErI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fD0VMciuBQQMLdtT4pSaYu4Ao11lY9ohJzYmVh8nQ5ce0/Z9XACAoQ3wiKnoglLxY
         2GcR/fc65uErTBEF/Rugw+B+36leyYyegKyi3LVhnG1k2m3hQaaf+ehRc1m5zQKPh0
         QxaXINLkHGzQzBPyObcqIId9yxLVUEumJe9jHwpVRqVhSUQtnnSR0XZBiU9/QpO/zU
         NwDey4C7Bl/HcIZ5cUd/i7EAhg/hhPcwj40vA+FV0Lx9iSWMEpFendFqSuz2a3+ZBM
         5NFA3zXh/YaE8nc6K8rOZuciitwBQcqnTrMzQOBroC7Y4kVCBck6k7LEzRecVsB4AR
         xYhESqRWLW2QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3139FE22AFC;
        Thu,  7 Sep 2023 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] shared/bass: Add Set Broadcast_Code opcode handler
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169412763519.379.3652100291497748623.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Sep 2023 23:00:35 +0000
References: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Sep 2023 18:12:26 +0300 you wrote:
> This adds the Set Broadcast_Code opcode handler, enabling a BASS Server
> to sync to an encrypted BIG.
> 
> The BASS Server will detect if the Source is advertising an encrypted BIG
> by looking at the QoS of the PA sync socket, after PA sync has been
> established and a first BIGInfo report has been received.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] btio: Add support for accepting BIS after defer setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ed0def339cca
  - [BlueZ,2/3] monitor: Fix ATT decoding issue
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42681a7c15ab
  - [BlueZ,3/3] shared/bass: Add Set Broadcast_Code opcode handler
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df658c6c4ab5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


