Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E0C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHBVA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjHBVA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 17:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E61FF2
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 14:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB7561AFD
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EB38C433C8;
        Wed,  2 Aug 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691010023;
        bh=g9ru+d4bMPlm8Hj9JPRqSf1mNXvsNvb8qWQbGIvcFRc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KCFC79EUU/8kmYVz8n+NLmARjdHetrJunYzIO754SHNPJHKOOVZ95U4P9QdNSeDWc
         IBz0xEmwwJ9CmuoiMbUUlmFaKTqqZMobjMP0naAp2HwEKZDnvgEQy24KSkquvrZbPQ
         wBZRvc7on07FaHQERis8b/0V59rGL0tnN7gv0rcAO/Munr3VqDTrFcF9FLCL2gYsc8
         VRF216J7ikrHn3G1UX6CX/lUtxsOY+G093jBoVH0aYVZDlcMrFQ62uDlTr3ta9EsJW
         VtWtnsbc5myU/76RCZO2KeFT8iEoo0kntNOb5G9/C+W1A7t9iZt9m/a50oifbZkjiB
         PhKUnAr3YtT5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87A89E270D3;
        Wed,  2 Aug 2023 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v3 1/5] monitor: Add TX frame number and speed
 estimation
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169101002355.16544.5407656958603088874.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:00:23 +0000
References: <20230801233135.537864-1-luiz.dentz@gmail.com>
In-Reply-To: <20230801233135.537864-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Aug 2023 16:31:31 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the frame information while decoding:
> 
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256 Address: XX:XX:XX:XX:XX:XX
>         Count: 1
>         #188: len 850 (755 Kb/s)
>         Latency: 9 msec (3-21 msec ~6 msec)
>         Channel: 68 [PSM 25 mode Basic (0x00)] {chan 4}
>         Channel Latency: 9 msec (7-21 msec ~9 msec)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] monitor: Add TX frame number and speed estimation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=604633556d7a
  - [BlueZ,v3,2/5] monitor/analyze: Use conn_pkt_tx on acl_pkt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=54740308b52e
  - [BlueZ,v3,3/5] monitor: Print channel latency information with -a/--analyze
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6bb476800fe8
  - [BlueZ,v3,4/5] monitor: Add connection tracking for SCO/ISO with -a/--analyze
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f6e606c8504
  - [BlueZ,v3,5/5] monitor/analyze: Inline data to gnuplot
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80107630396d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


