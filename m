Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E1EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 23:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjGEXAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjGEXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC071989
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7215C61824
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE021C433CC;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598024;
        bh=MwoggFxQPyjgshwjkA92mmTHZdp4pFhr6BoVq3CQMEk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cMudlKJCaQX9buEws6Eawj9mQtfpeRhz3nLIkyPxwnVlezlITd1LuOlkl43f54t0G
         ggGSt9CT14akPqXVLb87vR+mY1fko7/rnzmYt8iIkwpio1OA+Xid6P8OMfAPO3Uzno
         Wq42WSQBwzweCSGj+JIrNS2pBbRC7FefuPFLJJ0tldU5EkHIIQjT2MQtnbAjiOqg5n
         /1v7XkDnG1uo9hqLWblRBEiXOQeV1etEpd4XrCrSM34FsGCgieO0dL79CxSP4ovk0l
         /2wsF7xoPJSUjByWuwpObEqlyD28U3GtZwrTIJwOIQgJCSQfdqzr2v3KGWtpvlVU4K
         RKnnsrdnqvD5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B22F7C691F0;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] Bluetooth: ISO: Notify user space about failed bis
 connections
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168859802472.24898.8102885156352597251.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:00:24 +0000
References: <20230703070238.4193-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230703070238.4193-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Jul 2023 10:02:37 +0300 you wrote:
> This patch makes it possible for the user to be informed if BIG sync
> has failed.
> 
> There are situations when certain procedures must be started in this
> case, like it is, for example, when a BASS Server fails to synchronize
> to a Broadcast source, as a result of a BASS Client writing the
> Add Source opcode to the control point characteristic. The BASS server
> should be able to detect if the sync was unsuccessful and it should
> send an appropriate GATT notification to the BASS client.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] Bluetooth: ISO: Notify user space about failed bis connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/5298a4d440cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


