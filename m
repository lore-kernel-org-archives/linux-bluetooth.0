Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C112FC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 16:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiGTQU0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiGTQUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4114A46F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 098C2CE20CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EA0DC341CE;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658334017;
        bh=3VrAOpP0423Iq4Tp2oKENu8PR46IUV6LT+GP4qbyZiI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C3aoYmBevvovyVPEv76W1hble05LeXY+LFo+iVdiEYRfADU1SJlyk7dni+E2+ao6j
         779HerBBqGxXyJMUniKFAbI0qHrVpcxXwqedJ1AdPcdkdZzNLdiP7syjvJOAMzAUGc
         Wf/hMlrpF1Shm0v29EI18RyZNmiMjUfWMazH4WsqJgxD5pcQjG2LMswZ73K4IGw/3D
         ymy7Y98q2hGBHLjOiF/UaQrY09S6GF0s6A7E2Zj3QzRXAreBd7LDDjtl62pyZvT+1f
         1dE+th6OyoX//MmO257vE3Twy2xeDChm8/FkrHDNiYeHLzFAqL7Yfly/vGdwmd3XSF
         /FFjF3ve90hGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27032E451AD;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Set
 HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165833401715.6265.10775188949216580851.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 16:20:17 +0000
References: <20220713152913.87328-1-wavexx@thregr.org>
In-Reply-To: <20220713152913.87328-1-wavexx@thregr.org>
To:     Yuri D'Elia <wavexx@thregr.org>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Jul 2022 17:29:13 +0200 you wrote:
> This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK controllers
> since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
> Signed-off-by: Yuri D'Elia <wavexx@thregr.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v2] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8252b94a32a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


