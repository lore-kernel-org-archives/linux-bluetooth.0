Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5A8C001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHGWu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHGWuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBAAF3
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEB060F21
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C959C433C8;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448622;
        bh=S6C6knIrAbZ/SxlnkkOFRWITLpNF4m1DY50QEJGDdAY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AFXra9RqOgCm+zj3w8SnHkzfKfA51Oa6n+QunOIAP5xCUClPTtvS6bnG1aYnj/rOg
         OUJh3pBH2HCS8CXOY35CGJlETbuGrGXdBbebi2cffZbslraWV/w1At1xOVn7+BI2tY
         MBWAHFIvGkTg8sDdvw0zFpsVLJDNiZVBGXTQOMXgIvyozXtsNcN5mS7xgzhbXVHTGa
         WMV89lKNYHNAL2YjD9JzpVyGBWRp4Fe1P+XblezG2rf6gKR8k8IunadzmYIwbrOQyy
         mjF9O/bR8wSICWMEmf5rYYJwliViAJS0gVrKebrbDyz4hQ7cUvOLZDPwb6+jvB1T1m
         ARfSMLPGT0+hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2284DE505D5;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169144862213.1999.7363681078767590692.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 22:50:22 +0000
References: <20230804232522.1151304-1-luiz.dentz@gmail.com>
In-Reply-To: <20230804232522.1151304-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Aug 2023 16:25:22 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces PTR_UINT/UINT_PTR macros and replace the use of
> PTR_ERR/ERR_PTR.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
    https://git.kernel.org/bluetooth/bluetooth-next/c/826843c39bc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


