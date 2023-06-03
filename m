Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44AC7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 00:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjFCAaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCAaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 20:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C31BF
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 17:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6686961F71
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jun 2023 00:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1500C4339B;
        Sat,  3 Jun 2023 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685752219;
        bh=PKqvut8QZXjew3g0AJLgUr4KTsFRYuxA85JiBdjKcIQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hrVruNvD+7RCIFl61xkMGzSRckKS7CYRVgqgR6bXrDz+a2Gob+/sUykG5oT4sFiIo
         6dktLmGIMt9Js/EiMpW+5sg6UIv1mTOjwcLb7dJlAxKuNiqPEx9wlOUIcQMDgQQ3aZ
         2HqP3Gu1n8f0dDYAZGIcRazw2WPNO/H7anIsNde7MCSDVHdURtrhpyM7vvhx3x0s64
         MqyxGVt1bEInOYC0Sw5ZaXvTZKu2Oc649eKxVmGtk7Pey9ZdkkIlNi6L8E2t5c2KvN
         fn5Gwi404rFjup+ubhhiJvtmfgil/W35K02vZ3XL0xkpDXJOMkRVbuHm74s7DW3DlT
         5Hy0ZHnfwgIoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A651CC395E0;
        Sat,  3 Jun 2023 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: fix Set CIG Parameters error status
 handling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168575221967.17023.9763642008143711219.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Jun 2023 00:30:19 +0000
References: <d7b290a2d4a3acc77feb10873d28c5c62f26f5ae.1685740877.git.pav@iki.fi>
In-Reply-To: <d7b290a2d4a3acc77feb10873d28c5c62f26f5ae.1685740877.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  3 Jun 2023 00:28:12 +0300 you wrote:
> If the event has error status, return right error code and don't show
> incorrect "response malformed" messages.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     Correction to
>     "Bluetooth: ISO: use correct CIS order in Set CIG Parameters event"
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: fix Set CIG Parameters error status handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/280ae657262d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


