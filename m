Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA42CD613C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378321AbjJIWUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjJIWUa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 18:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1FFE6;
        Mon,  9 Oct 2023 15:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95EAAC433C8;
        Mon,  9 Oct 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696890025;
        bh=4io3LO+uu080DbbCaJxSHVDpj0edN9NVy7xVKX8iYxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BfjLqvQJsjXODlTcOArD7a9TKKIwFBbNY3F7GCvcPytvoo76zmfxDkKFhmkrQvtP9
         WA+SC/xKyPd4sTNFqqm+bGtyawu8j+Zs2DMom3fOte5xIoe1Pos2mOM7lc5jozeZqD
         81BWGJmrnsXhly+AfaDIcTykHKhe3bZb6MSagVvV/+ttRH7Y54D6EKPbUMnQ4SRDZi
         mGkpXItZI3aOgK+bf2qKP1pgI2rC3oR1wUNUmWdDIO1d2VK3rZacH8Fmb1OIRx7pdN
         pvfcoowyOFbaRUtIxxKIatrHYrXrzv3QAC1m4V1473TBP/pOhb5FlPoEPSZV6Rzjfq
         h93vGOPgLGL0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73AD8E0009C;
        Mon,  9 Oct 2023 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169689002546.32192.12724090135362600749.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Oct 2023 22:20:25 +0000
References: <5fffad33-4d19-4645-a21f-57321d1c82a6@moroto.mountain>
In-Reply-To: <5fffad33-4d19-4645-a21f-57321d1c82a6@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 5 Oct 2023 14:19:23 +0300 you wrote:
> The __hci_cmd_sync() function doesn't return NULL.  Checking for NULL
> doesn't make the code safer, it just confuses people.
> 
> When a function returns both error pointers and NULL then generally the
> NULL is a kind of success case.  For example, maybe we look up an item
> then errors mean we ran out of memory but NULL means the item is not
> found.  Or if we request a feature, then error pointers mean that there
> was an error but NULL means that the feature has been deliberately
> turned off.
> 
> [...]

Here is the summary with links:
  - Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
    https://git.kernel.org/bluetooth/bluetooth-next/c/99976bf519f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


