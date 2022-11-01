Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A69C43217
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 21:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAVKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAVKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 17:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854971B9F3
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 14:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 372FDB81F8E
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C4DC433D6;
        Tue,  1 Nov 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667337016;
        bh=npEe/kQdq6sDbbO1qUsDaD3vfhtCk9eMSn+XtmEgHaI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ujwl2ScrkwvCjuMCwTQEHUZGPh2LhcmaJJZ10zvZhVQQl0Php8LSW9zdwqhFOmTf9
         MDkfBpytg1mwe8GWxcQfWNqHlQE21RKygMGTBDP8nF3SrpQO2SvZP/IrjvCQN0ME/x
         koXmOVfJbni4vvMs1KGUOucj5aVaZHt5/iYpjEB2ZF8jkTMRc3QtnDvycTAntnH0pz
         NZf4fYN2Kwc9o+WLaTOPji9pdHDJmuQJR/IwFqD1vY5LIDiQwWBRe+GprzFxdja0ct
         R2wpmyRUHElQ9G1tGF4z8S75YBjNWBnMHZaVG0GvMbzLz9Vj9U+JH/GfF9nrtbsgMv
         sIMzUJgAawIsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C10BE270DC;
        Tue,  1 Nov 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: Switch hciattach_qualcomm to FAILIF macro
 completely
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166733701663.25446.9918192957069149869.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 21:10:16 +0000
References: <20221101202636.143165-1-marex@denx.de>
In-Reply-To: <20221101202636.143165-1-marex@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Nov 2022 21:26:36 +0100 you wrote:
> Use the FAILIF() macro consistently to avoid unused variable n warnings.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  tools/hciattach_qualcomm.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [BlueZ] tools: Switch hciattach_qualcomm to FAILIF macro completely
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9657b86ddd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


