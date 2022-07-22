Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13065C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiGVUkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGVUkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562B013E3C
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74639B82AD1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 20:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1139AC385A5;
        Fri, 22 Jul 2022 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658522415;
        bh=n84mhyBqD7iBU2wRu7v/HRHDAgFcHHUrdEMCvUGltUI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FPAiO809K4Cd0fsmq4u+oTEff5rt1wGJlb8kQwAFkBjMkmz1Yy9DPUAN0VV8oCwSm
         spAFYXzYr28HO1fq5UTkovVSq0dihTBC6NUkRNapFOQz0187AUfKcO5Tx1WV8bRsnC
         Ypxkp8foULa+0mWPuK/nwmNudKmY8TTXHNJqFLSsyLJoPD3jmSTXV1ya3AnN8icZoO
         ogTNAFFAgkmGAr4B7TgJJ0O7SOqDfJCLOWRrKL+BV3M3n70ClODtninkLXKuNJ5/L8
         GvRmHPnl7U+eOzJzZ6H5s42ZoUi1n1Q/ebsXXJtQknN6lsWw7G3PEQBsShscba6877
         X5NKvItGEEbHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5088E451BC;
        Fri, 22 Jul 2022 20:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165852241492.788.14147503461252581486.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:40:14 +0000
References: <20220714002225.3540241-1-luiz.dentz@gmail.com>
In-Reply-To: <20220714002225.3540241-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Jul 2022 17:22:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces hci_recv_event_data to make it simpler to access the
> contents of last received event rather than having to pass its contents
> to the likes of *_ind/*_cfm callbacks.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v7,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/dfe6d5c3ec23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


