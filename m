Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF6CC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 22:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIUWaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUWaR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 18:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5896E2F1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 15:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAA81621CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 22:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A3EDC433C1;
        Wed, 21 Sep 2022 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663799415;
        bh=UpTb3YTL41VHy9O+XIwPkREyFNj3uQxtxUd3khuXA54=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qr/LJtJo8WeFFjbTR/veUNJZHJKb0YNzmY+u3IKA2nUznh/ChPtze4lKt59ESKbUg
         VOMmOB2pOHjEb2y/zzr/H8E4wa+frT+Kj6vyZyHdhzpg+DW6uSJEb85NPvvYCJSBWl
         aWZ57qy9ie4EeJCcnJJ1iRZ924SgYq4sIQRIXa6ztrgsRd+dbXcE5A4sXP6GQWxuT5
         FuQb2colSfn08dJd6v8uImbbbz+lzaugDWA/jQKhYpBXJFpbou9+a/LEuVZ8kIEZnl
         0p8+4IpT8j6gtlY8oBkUPb2Xj9VKLLdHTh3chIq2F8pVv1Yh27UhIzlbPc/V2QRzfB
         E1SbSIhv1PYcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E29D6E21ECF;
        Wed, 21 Sep 2022 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Make sure ISO events don't affect
 non-ISO connections
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166379941492.9162.11245441246375310388.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Sep 2022 22:30:14 +0000
References: <20220919181017.1658995-1-luiz.dentz@gmail.com>
In-Reply-To: <20220919181017.1658995-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Sep 2022 11:10:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ISO events (CIS/BIS) shall only be relevant for connection with link
> type of ISO_LINK, otherwise the controller is probably buggy or it is
> the result of fuzzer tools such as syzkaller.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Make sure ISO events don't affect non-ISO connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed680f925aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


