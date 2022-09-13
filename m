Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55FEECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 01:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIMBAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIMBAT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 21:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C702717C
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 18:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A5B612DB
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 01:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D4E1C433C1;
        Tue, 13 Sep 2022 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663030815;
        bh=4PFU35PpzuTN9vYsvcb8fsY2krIUJR2woi4JAtEoJNQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LbRKk6dr0GdGgMmO7t1FCriJUZbFDrvQ1SheOYmgILwbFV1sxsK4z5uTwtgpp7y82
         C6THR2n7G1qXC+4x2Iz+J2bRUlu3m9r3F/r5KESuakIJCB6TiSG2PU4+13OKnW65te
         X2Y23e2xvBmYphssG+uEswJ1ypBkcwkYNAb5ynRZSbyoEfMFoUeiJCXVLmQWAU5JD/
         VrCOx43BbPFMz3/9JPfSb//ZBgeGTEQtRHr2SF4NJM2ZGGywjUXir88iEwltHA3tuk
         VvaExCfq+0axdnR7TyDqBmdyD22+RbqJtvbJP5zI1N2bJEsbN42jGUhHTBNthu3oPg
         XDlTiDaEl8EeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42342C04E59;
        Tue, 13 Sep 2022 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Fix attempting to disable stream when it is
 idle
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166303081526.21555.4400313206149451522.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Sep 2022 01:00:15 +0000
References: <20220912214257.173804-1-luiz.dentz@gmail.com>
In-Reply-To: <20220912214257.173804-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Sep 2022 14:42:57 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the stream is already in idle state do not attempt to disable it
> again.
> ---
>  src/shared/bap.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/bap: Fix attempting to disable stream when it is idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=877b88c5f2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


