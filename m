Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7865C001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGaRu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGaRu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 13:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFFCDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 10:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0D866125E
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F2F2C433C9;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825824;
        bh=76aVjxgJmxi5xjMjNbx0R2xRwNMqjyCrFd8NNj87J9g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TEnGpaa5bw8zJpww0HIClgtRnQH2ABqWEItT2Mjp91/b8esEpVOVCskRsMVGajN9C
         6Pc77B980CoqOirc/uzsrzFHe66SUxg5pogVXyYJEN4aYL25bLPWgNrcWLrGCwf5ml
         pA4ecIdcmSPnbH9+9Gg8p/qIjQpSQFkRijMnHCjbJ66bBgXLAPxV0fgVvpboWg10HI
         YKKlAZjtebLAsD+gTDqIHtQlxGMcjE4UpqGT2/atufACEuCbsB5ZQHSAGWzY62dUPT
         ROdFjo8JFdB+2pqCHZ8Hbqe3Mn0W2vIgzeWi185x9c2a8kCKNdnollW5Ez6QIcuxx3
         sRMf12oMsvrhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36895E96AD8;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v5 1/7] monitor: Use gnuplot to plot graph of
 Latency-Packets
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082582422.13999.16583862419911662723.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 17:50:24 +0000
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jul 2023 15:42:41 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make use of gnuplot when using -a/--analyze to plot a graph of
> Latency-Packets:
> 
>   Found BR-ACL connection with handle 256
>         Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)
>         60 RX packets
>         22548 TX packets
>         22547 TX completed packets
>         3 msec min latency
>         73 msec max latency
>         11 msec median latency
>         6 octets TX min packet size
>         850 octets TX max packet size
>         847 octets TX median packet size
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/7] monitor: Use gnuplot to plot graph of Latency-Packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac04b56c41fe
  - [BlueZ,v5,2/7] monitor: Update documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a657dcec988
  - [BlueZ,v5,3/7] monitor: Consolidate code around latency calculation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d090ddc6aa6
  - [BlueZ,v5,4/7] monitor: Fix not dequeing TX packet properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=77fb0ab5287c
  - [BlueZ,v5,5/7] monitor: Fix not calculating latency for ISO/SCO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f150939419d3
  - [BlueZ,v5,6/7] monitor/analyze: Fix not dequeing TX packet properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4cf0900d05c
  - [BlueZ,v5,7/7] monitor/analyze: Fix not calculating latency for ISO/SCO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dce3971d227d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


