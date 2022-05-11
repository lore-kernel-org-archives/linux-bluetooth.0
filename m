Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E298C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 21:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbiEKVkP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 17:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbiEKVkO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 17:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E76B09A
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 14:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323DB61C1A
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 21:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8792CC34114;
        Wed, 11 May 2022 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652305212;
        bh=YNXG2VZpK7gCm8/jLnWeGjGFIpwurTMeo/lygno7lC0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LUOlCs2Wq37TYCYgP6HS63QtpnYJUyvhfkR5nCTEPm5mrKT3egKw7I+BWTodEkfrJ
         YiGtlKkrG8B3opjo4yrdVbYov0s1r3GkS0cGtusYpwFfgsBqRyx9LzCnzvWYjEZO7u
         hMg5T2FHrMwj6QVfIUcraQDx4Hmk0firZI0ygPqwOhgPBLvvphKezOlQ7TZVn/sZiA
         7F0TuDLSr0n1eVPTUOm9vazf3mJy1/lnjwmkrREnARr0fmNPVzCoCbTcsLDl93j7ur
         CxzDoAL0VQhDdGY/rxI5tKoL5he+pT4eO1veQ6BhT4YTYar+pFTxuGAW80MwXkjprS
         /BmP7meroZ2Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A364F03933;
        Wed, 11 May 2022 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] device: Fix pairing has failed due to the error of Already
 Paired (0x13)
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165230521242.17601.4484740268374199473.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 21:40:12 +0000
References: <20220510012735.1698-1-wangyouwan@uniontech.com>
In-Reply-To: <20220510012735.1698-1-wangyouwan@uniontech.com>
To:     wangyouwan <wangyouwan@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 May 2022 09:27:35 +0800 you wrote:
> After connect the Bluetooth mouse, open two Bluetoothctl at the same time,
> when remove the mouse, quickly go to power off,
> try to paired the mouse again when I was power on,
> found that the error 0x13 was always reported.
> try to connect directly,can connect successfully.
> but use the info command to query the information of the mouse
> and find that the pairing status of the mouse is No.
> so I try to delete the paired information in the kernel
> through the "* cancel_pairing()" interface.
> 
> [...]

Here is the summary with links:
  - device: Fix pairing has failed due to the error of Already Paired (0x13)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4423d63a9634

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


