Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKBVAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKBVAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 17:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593FB4AA;
        Wed,  2 Nov 2022 14:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79DA461C30;
        Wed,  2 Nov 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6BBBC433D7;
        Wed,  2 Nov 2022 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667422815;
        bh=rIUydBfZ/OIOgcTF4j0Jp0sVduCixsJqQhwy6N9z7Vg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O/NgJH9Dpiu5+pYxOaNH1309XAMaVISEQ8B68lj0vpUfHldjZpJpJEKW7WFiEIow8
         gnunA76cu0/mLVIPOcEvJoBrg719r9r7k7e4aC0KUReAy3wNFTHzdsg/4grNNXzPbM
         WxI7kVMnjjn34tqDqYFwsQKhZPNFCi+NWU0Jt6hu6+D9+igGtemzcMyqfjp55TN7ro
         flpWVKc1l2gV1x4mzCNfaVLO8KRmV3iI3vACAP5LxdfVz6FnJ63AKv0p+d9onFj0ef
         f1e4+c2s6ugkKezMfS/flvqnEF4irYG1J6oO4qMlmC3OTXXrdoGBOq3HBhaneBJuOI
         cq+biWey9eYXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB6BBE270D5;
        Wed,  2 Nov 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT
 binding
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166742281569.25440.9584575292031556354.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Nov 2022 21:00:15 +0000
References: <20221102164705.14538-1-marex@denx.de>
In-Reply-To: <20221102164705.14538-1-marex@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org, pbrobinson@gmail.com,
        robh@kernel.org, linus.walleij@linaro.org,
        hakan.jansson@infineon.com, krzysztof.kozlowski@linaro.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Nov 2022 17:47:04 +0100 you wrote:
> CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> This chip is present e.g. on muRata 2AE module. Extend the
> binding with its DT compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
    https://git.kernel.org/bluetooth/bluetooth-next/c/0a8d4b84bbd5
  - [v2,2/2] Bluetooth: hci_bcm: Add CYW4373A0 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/ce52c2f04177

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


