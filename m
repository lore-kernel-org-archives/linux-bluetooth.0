Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B19BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKAVK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAVKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 17:10:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566061B1EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 14:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99197CE1E42
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCDA0C43140;
        Tue,  1 Nov 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667337016;
        bh=MAsiSipwGbXSyeSGFPxSZMnvu/FmTLf7AlbfEvZ2CDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EmaJ5b850DewS54+YG1k3yPnL5KgScb5fXKldxqyq1pJ7sfy9BDkQbzho4IyF3W3z
         UfB/HyVMXpdXLE+0TfkkC0w0c2LUDvCIKcd77YhGMjl0nrmP4Bs4PRfyWhQohV7njQ
         CMXQSmsc6dZLdou4GaK4dUMCJ69UQuCI+4hcm3H52Vlk00OJLsXmqRfLHfSiM+xt8d
         ORbS1kha27G0ShXAqgbq6d7mytc6Yoc0XOhdmG82k0Y2upYnLU7qwEkSL2wRFrfdlF
         7ejFyD8t9NYEOtCNWGWz4iVreYC1TJKT//TvwOdJk26qVrJ5jSwqVWhMphlCLR/AeO
         uHJxgtF8jfKsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A62D0E50D71;
        Tue,  1 Nov 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: Make hciattach_* firmware path build-time
 configurable
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166733701667.25446.5293406780135758558.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 21:10:16 +0000
References: <20221101115333.18223-1-marex@denx.de>
In-Reply-To: <20221101115333.18223-1-marex@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Nov 2022 12:53:33 +0100 you wrote:
> Make hciattach_qualcomm.c and hciattach_tialt.c behave the same way
> as hciattach_bcm43xx.c does, where FIRMWARE_DIR can be overridden
> at build time by using -DFIRMWARE_DIR= CFLAGS.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  tools/hciattach.h          | 4 ++++
>  tools/hciattach_bcm43xx.c  | 4 ----
>  tools/hciattach_qualcomm.c | 3 ++-
>  tools/hciattach_tialt.c    | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ] tools: Make hciattach_* firmware path build-time configurable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d9253248363b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


