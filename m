Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A723C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHGXUa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHGXU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922A171E
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597A862311
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 23:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B435AC4339A;
        Mon,  7 Aug 2023 23:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691450422;
        bh=IjdkPSqm7w5Y5bo8iAnnN/fe4JAIrYdxPXlvsTVbC8E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uvuEG72QcOFezZ1Ua4/rzaD+Q2pFQVXltc5GklPk+qMfAK/ZvB+Y957MCskEPwBRz
         pi0nD+vNmCOoH8mWmMSTHHkNff7DQlqjMG3ZEU8d0JWN5jJyQ6d57BHR8ocbnHRAL1
         HIGsUscvXjmaAn1KebdcZGl3DRN9ggKw7ikCPW/LXKr1bIMMpC6qtzgNh/veKH/hoz
         RMsza1ndUJFVlbxH6bmnhp7AVPFjTe42Uc2g0QVDDn3VPyJv4+gDRWSvfo2X9mjfah
         W5VpGWM5qaTrk5ZxUx59Ng8saQGKfTuQSds2kg51qfCdQkTHIzbM+M7ZIa2lvWtCoB
         dptICVRGQlmCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C42FE505D4;
        Mon,  7 Aug 2023 23:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] main: Fix missing comma
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169145042263.20955.12179439209516837997.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 23:20:22 +0000
References: <20230807054108.234233-1-karl.bieber@proton.me>
In-Reply-To: <20230807054108.234233-1-karl.bieber@proton.me>
To:     Karl Bieber <karl.bieber@proton.me>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 07 Aug 2023 05:41:12 +0000 you wrote:
> I think this is a missing comma which could lead to bugs.
> 
> Karl Bieber (1):
>   main: Fix missing comma
> 
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/1] main: Fix missing comma
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b9c57e815e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


