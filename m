Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D590C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 17:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjECRa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 13:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjECRa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 13:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B549CA
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 10:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9AD62F0A
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EFF7C4339B;
        Wed,  3 May 2023 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683135022;
        bh=BlB9wv6hz6vCIxm7pJKQ6ZwsIXIUXOnxrNgkkYz5+MA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RuPD3Do2XnZekv+9ikMReUXMBDb90DGFpeQ0Gs0tFfB2i8fYZUQO1HAmY2Vfif5pw
         9qSp1GnrM8yqJkQfpbi3nafTV6cfKOsJiFODC3TP3w08IcyAQLo4JLMtfO/HOcJusd
         etDtReBYqP49SfFw8oeA9VVufK5QMMGfhsaAGST52eXHzJ/WooiR/w7FNoI+qAdDsN
         ImjvImDdi5M7cxb3TzrEJ6W7e3sJN2MWKxw5yM/q9SgxsfNZipVSCliviVe+ryFccK
         zpvABepTsL4v4VqVKnFo/P/0xU+kJrqpDTOVAeG7WUOOESHYD0+Ki5JwdFy5WZGXJP
         OJ3rJGFMCTUeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EC18C73FF3;
        Wed,  3 May 2023 17:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/4] Bluetooth: Fix potential double free caused by
 hci_conn_unlink
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168313502231.19283.12765545255824034324.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 17:30:22 +0000
References: <20230503133937.169647-1-lrh2000@pku.edu.cn>
In-Reply-To: <20230503133937.169647-1-lrh2000@pku.edu.cn>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com,
        luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 May 2023 21:39:34 +0800 you wrote:
> The hci_conn_unlink function is being called by hci_conn_del, which
> means it should not call hci_conn_del with the input parameter conn
> again. If it does, conn may have already been released when
> hci_conn_unlink returns, leading to potential UAF and double-free
> issues.
> 
> This patch resolves the problem by modifying hci_conn_unlink to release
> only conn's child links when necessary, but never release conn itself.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
    https://git.kernel.org/bluetooth/bluetooth-next/c/3214238e9dc7
  - [v4,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
    https://git.kernel.org/bluetooth/bluetooth-next/c/38e9b45310de
  - [v4,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
    https://git.kernel.org/bluetooth/bluetooth-next/c/29f883dcbfd0
  - [v4,4/4] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
    https://git.kernel.org/bluetooth/bluetooth-next/c/e6e576ec4e72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


