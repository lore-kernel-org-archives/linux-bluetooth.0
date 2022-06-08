Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiFHROe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiFHROR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 13:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2CF26F493;
        Wed,  8 Jun 2022 10:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4314061AC2;
        Wed,  8 Jun 2022 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93825C341C4;
        Wed,  8 Jun 2022 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654707614;
        bh=c+pSFOSKgq+o8Np9gz0lvRNLx1ALeem3eivA1a8z8jE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eLIGEyf5MJZ4RTE/LWnL/qAC0jwutZZsd2pZtYDqbVA6U2Vc2f4xR1MAaaDhjEng8
         9DkKnDevDeS9Xl4bTdIbey95aSVhCuPirj/k4dA6pQhKO6mS5I3Qu9yUtwZn+CXTu5
         nlwgV93me9/3JEyPI8FyF+AfusE4yQt2icGxqLuEnp+BGIsoS4McOwshLZMT+3nZXQ
         5F4iHxVbPi4B/D5JdXpvZALUVjhfznQ4R09qisWfwcuuUBrm2p6b3JvlxLdItjl0j4
         pdf0xHq5Hu4oheQR5of50qJ+m5vG4IjtsbANTUykn1Pr+rF0n4zQVVg94XiWx5Jx3L
         MPcURne+lZG+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B1F9E737FE;
        Wed,  8 Jun 2022 17:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix an error code in hci_register_dev()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165470761450.24378.7406795822626176055.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Jun 2022 17:00:14 +0000
References: <YqCoJXuRV8MIDS2M@kili>
In-Reply-To: <YqCoJXuRV8MIDS2M@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     marcel@holtmann.org, abhishekpandit@chromium.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Wed, 8 Jun 2022 16:46:13 +0300 you wrote:
> Preserve the error code from hci_register_suspend_notifier().  Don't
> return success.
> 
> Fixes: d6bb2a91f95b ("Bluetooth: Unregister suspend with userchannel")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/bluetooth/hci_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: fix an error code in hci_register_dev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad564394b3db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


