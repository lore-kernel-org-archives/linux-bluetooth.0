Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC26C74A44
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCJAUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCJAUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94342F4B70
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5451FB82149
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 00:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 014EAC4339C;
        Fri, 10 Mar 2023 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678407618;
        bh=ylYE4zuN9++Nv/rLFd/QXrmcltLQLsbpazoAcyyDCOE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ra7ouEopFsh371QMwgiUkqMnSiLTWnr17CCSnKZOz5kTtM0EQQqR58FBKfIY6qfJ+
         t7yXuI3boK0UWaRxNAW2eBdyxb+N27JMnwGcYa2EIm2UFLKcAIbN4ia+jIXLYaygG4
         6k2JY+BDEtkOGIUJaKumjXT5JpMq2OoiHP7BI7eySs/hn8y09nGWxxytXLfmNngIMJ
         Yn+KwKHE9p/CGGVQZDPPCbiWlS4velZuLLwdnrvHqNBT1ZanLBEThwoWD8UqL7yTH2
         z5dwVbQDdFUsyVQ7jpfalK1D43ak9esP6ee27Dma/EdBSjumZojaD/yoTEXkHgQlDM
         7IfcP1K5kaSdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDEFDE61B6E;
        Fri, 10 Mar 2023 00:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Remove duplicate statement
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167840761790.25154.15771619907903459554.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 00:20:17 +0000
References: <20230308183235.326109-1-inga.stotland@intel.com>
In-Reply-To: <20230308183235.326109-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Mar 2023 10:32:35 -0800 you wrote:
> This removes the following duplicate statement in
> hci_le_ext_directed_advertising_sync():
> cp.own_addr_type = own_addr_type;
> 
> Signed-off-by: Inga Stotland <inga.stotland@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - Bluetooth: hci_sync: Remove duplicate statement
    https://git.kernel.org/bluetooth/bluetooth-next/c/f959b6b32769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


