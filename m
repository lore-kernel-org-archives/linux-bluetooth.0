Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C42C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 23:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383679AbiFQXUd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383655AbiFQXUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 19:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397DA663D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 16:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB5BB82C0A
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FDA4C3411E;
        Fri, 17 Jun 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655508015;
        bh=1mSzu2NhQUHudEP7ZzLbntei6uSmfoqt6V3cXuKsgGk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DXOOj8FbirZwOy2IeQgflqVxBuNrQNdApTe6e07g83K5laUevMNpGztdNIucSBwpB
         ngJcUkM0SINI43bGGNLt6nGLbmJ71aUqgLVDL8tjTwRPYPBYYMJErLSZg+wB+9OiKG
         /sy8lwIL2uY/xBSStyBo5797Dqu4mhzAuKC0LGz1Lxy1Ll5jvBiqg2b/GwyaO9sPUP
         7VqiPAGEnAtAqgcoaoXiiJlVIuxeAhzRK5xaNlZnzwBXrrL1AQ1ShfYMu/KJJbmgmV
         9glzy0mikBJbDvNMNiK4Qxai31ejSwy5J+zN/xjkQjy1hfMldXg+DdNx5ursitAV+U
         k69ZAjtG73JgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78838E73858;
        Fri, 17 Jun 2022 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test-runner: Fix issues found by coverity
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165550801549.32151.6122911595577602534.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 23:20:15 +0000
References: <20220617194929.95991-1-frederic.danis@collabora.com>
In-Reply-To: <20220617194929.95991-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Jun 2022 21:49:29 +0200 you wrote:
> ---
>  tools/test-runner.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] test-runner: Fix issues found by coverity
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=19ad4310c9b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


