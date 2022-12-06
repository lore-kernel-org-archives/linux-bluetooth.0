Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ACC352A1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLFRuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLFRuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 12:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C26CC2
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 09:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85FC3B81AE4
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454A4C433D7;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670349017;
        bh=R4vsVqAgYdUpF/OUoFPHhilQ8eGgJ3x0lKh3All0xHY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vo4H65IxWWPJA/u90GU7Gvuy4ZMv85UsN4FqsW84bLEBNBo4c4STsokyqrzY3qTGs
         Jdtdb7Zumpn0WvXex1TD/Isly1lCWEiNCWt189CVzIZL9rXRZOvhUlXMiOLS+Ob1cf
         UbMkCEQIsGC1F5NosCDuLuC0CeZvSc511MeQM4ykZz+CYSemFXf46KP6hLoPdr++u5
         ce/KXpm6+nzEZnp6dLYBoBZlshQr51hUY395df+oMOLlgJkwyFzk8UHlCgO9FOJyrY
         XKxCxusXTyV+IIu9l+se+QtB54qXa6jiQVtZRcK/2aabk7TX+uSa0KCrJuxSV3qtSM
         DjrCFqTczmtzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D0BFE270CF;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: Fix new sparce warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167034901718.25798.9174906645042172678.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 17:50:17 +0000
References: <20221205183236.3460924-1-luiz.dentz@gmail.com>
In-Reply-To: <20221205183236.3460924-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Dec 2022 10:32:34 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fix the following warnings detect with make W=1 C=1:
> 
> drivers/bluetooth/btusb.c:2212:9: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2212:9: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2245:18: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2249:18: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2253:18: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2257:18: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2261:18: warning: cast to restricted __le16
> drivers/bluetooth/btusb.c:2267:18: warning: cast to restricted __le16
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btusb: Fix new sparce warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee93fd98d900
  - [v2,2/3] Bluetooth: btusb: Fix existing sparce warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/e05ae902672a
  - [v2,3/3] Bluetooth: btintel: Fix existing sparce warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/b84a13ff4eda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


