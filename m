Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04060C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjEZWkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZWkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 18:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57975A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FF26545F
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 565CFC4339B;
        Fri, 26 May 2023 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685140820;
        bh=gEp8yT9XGO+0bBD8GVAjNSCFFDfRP2eM9QgtgquhJtI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZOrnLJtBXaQlaZx27i0IZLKKjFYqLWYo4trZlNXnw2Pf9QcHxbTbgijAP2PJa3xUB
         DWioQ+wj69LOcjEgYcFZCnz8F06RnZvlhIrAR7U9l4d6sbU8bvGf3p8JFuiZwAePTk
         3nUdRhF0JOE6YLpFa1jAKKP1arwZyBQ+mu6GEfJLrXJD8q8YMfZyX4MDu1IpFK8YQc
         T9MOp50RKQlCATTn/Ie5vHBcfHM3nNVVm586k7crPTnMYiY9TiJN2+Gq/i8M96e/zb
         TLg/Bf1dzHkpLRtaWgyT6c18kw9M/QhKQHF6l9c1O8orNYZyVcafpSyOJurT66VtxY
         6zs88xhd9uLCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB6BE22B06;
        Fri, 26 May 2023 22:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] Add initial support for BAP broadcast source
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168514082023.18404.6757664438997139111.git-patchwork-notify@kernel.org>
Date:   Fri, 26 May 2023 22:40:20 +0000
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 May 2023 18:34:46 +0300 you wrote:
> This patch adds initial support for BAP broadcast source.
> 
> The current implementation allows BAP source endpoint registration,
> media transport creation, transport acquiring and sending broadcast ISO data.
> 
> Currently, one BIG containing one BIS is supported.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] Update Docs for BAP broadcast source
    (no matching commit)
  - [v2,2/6] Add macro definitions for BAP broadcast source support
    (no matching commit)
  - [v2,3/6] Check for ISO broadcast support in controller
    (no matching commit)
  - [v2,4/6] Add support for setsockopt (BT_IO_OPT_BASE)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7002ecc8914a
  - [v2,5/6] Update bluetoothctl with support for broadcast source
    (no matching commit)
  - [v2,6/6] Add initial support for BAP broadcast source
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


