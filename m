Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72344CA0FEB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Sep 2023 16:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbjIAQyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIAQyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Sep 2023 12:54:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BD10F2
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 09:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05E41CE23D0
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Sep 2023 16:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 461DEC433CA;
        Fri,  1 Sep 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693587249;
        bh=1uhn045Asw/dwlHsF6da/DbQtayP2JxEiy0KNdBXlaU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m1iLC/nHdGLDXu709saSphjWjq3UuzOjRuU1emecerK2uYkMD5KMFG/DVHqWNPKJH
         foSmrfcfDFo2pu6JyAe/SjmkNdurbunxe1Icwb0kg5+ZEVt/dsoTh4ibOJYxXKRmMO
         jEpkr/L27Q1zzk3TRlmMCyGL96fgkbBQcdcKWTwTd/AKJfLyX6/0r0LGS3BtWzuVx9
         xRU4Yzz1DqZ4yoUYfu6VxmVDwUxuzJfhlNIRUuZ1wVSOuoa/NQzRbgzwi5ZLLp354v
         LjVsxTZs3MmI3fFDbEW3hPyunnbCMPqyHqPNCMgjARkOhb/qC82Q/SR/8RNA5Le6HW
         KQjjrq0R2/25Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 273ACE29F3C;
        Fri,  1 Sep 2023 16:54:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Fix runtime error
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169358724913.14770.14016822461438109038.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:54:09 +0000
References: <20230831210554.1141646-1-luiz.dentz@gmail.com>
In-Reply-To: <20230831210554.1141646-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 31 Aug 2023 14:05:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following runtime error:
> 
> monitor/packet.c:10476:2: runtime error: division by zero
> Floating point exception
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Fix runtime error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7fd9310b925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


