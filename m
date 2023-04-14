Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B832C77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNVaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNVaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35661BA
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 14:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 209F964A7A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 677D0C4339C;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681507818;
        bh=HmrpJtDNJh5YZIQ7syKeOGoWQCrjEAz0r9TIcu5p4bY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JZQ7YXsHRE9tSOq7IMIjAMKLtjr4odZxJqScIA3wK6fSsg2gmLR9cHJr0V3pDLmEY
         fV0Lr/6QJAsu5ChXrqq3QrmNN6hFVWTisCrVGEOFvppb7FqH5qAp4mCfbHDkDPs3HB
         hNj1KjfgSOKvvKu9Ds3/IUNuqDFV7ErgzjiAGiV++Z54Dq96Ros4/MnI9q09hnMpJ6
         jn0JL9GRx9bIf1w0QMP84kwwmNWMzQ7rbTbXb/HmVIVyfuUX8QEchs6x0WA8eKVaN5
         0YUVbOvsi692pM3ewWTVXE98cCx38MtktJHc7SLH+C2iHr1oNXblUGXXmOPGHELCU9
         YGYjYjl016+RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 499CAE4D003;
        Fri, 14 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluetooth] Revert "Bluetooth: btsdio: fix use after free bug
 in btsdio_remove due to unfinished work"
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150781829.20001.8229232041629892300.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 21:30:18 +0000
References: <20230414103006.200788-1-liujian56@huawei.com>
In-Reply-To: <20230414103006.200788-1-liujian56@huawei.com>
To:     Liu Jian <liujian56@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        zyytlz.wz@163.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Apr 2023 18:30:06 +0800 you wrote:
> This reverts commit 1e9ac114c4428fdb7ff4635b45d4f46017e8916f.
> 
> This patch introduces a possible null-ptr-def problem. Revert it. And the
> fixed bug by this patch have resolved by commit 73f7b171b7c0 ("Bluetooth:
> btsdio: fix use after free bug in btsdio_remove due to race condition").
> 
> Fixes: 1e9ac114c442 ("Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> 
> [...]

Here is the summary with links:
  - Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"
    https://git.kernel.org/bluetooth/bluetooth-next/c/492cf2b505d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


