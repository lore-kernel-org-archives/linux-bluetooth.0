Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D515C19F29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiHDAAS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiHDAAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFBE2199
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E1F3B82412
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 00:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D602BC433D6;
        Thu,  4 Aug 2022 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659571213;
        bh=GKiEDUj+9CQYdrQeVyLIpBmiTyCng4gqASlEPjCgqpI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WN/MRdHRGddnWLYZjzLKraqQowrl7px1Cr2kHRMQEIMQ6CqekSmcloOx35VuLwWbM
         HvP9ifWHCqLmVUs37TSnijJ2lXfoj+9bJb5eXbOu47A9HoJEj9YP5bGmd1IRTo8yO1
         4iI5voLT7DDFTrb9IctLSpNTtYSgSKQM7t4euOVHUh5+/5gGEr7DtkGVLZES3ojy8a
         rNQl/Oj+iabx6A6IBYrqfYVgZqi2WUs54PnfoJfgbJk1a05NqtEwwNVeBWat+jS4yh
         baH6wU9md9zqGwf+ayG1zeZbYf+a0PRdZJeqkGEnYPhd2XgWm1d8+5KwQsWezIko3h
         2aovrnKUIBVEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9C36C43140;
        Thu,  4 Aug 2022 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_event: Fix build warning with C=1
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165957121375.27811.16023969841140281225.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 00:00:13 +0000
References: <20220803215527.3070932-1-luiz.dentz@gmail.com>
In-Reply-To: <20220803215527.3070932-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Aug 2022 14:55:26 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning when build with make C=1:
> 
> net/bluetooth/hci_event.c:337:15: warning: restricted __le16 degrades to integer
> 
> Fixes: a93661203641e ("Bluetooth: Process result of HCI Delete Stored Link Key command")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_event: Fix build warning with C=1
    https://git.kernel.org/bluetooth/bluetooth-next/c/72fe393b4e25
  - [2/2] Bluetooth: MGMT: Fixes build warnings with C=1
    https://git.kernel.org/bluetooth/bluetooth-next/c/9f74dd92c262

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


