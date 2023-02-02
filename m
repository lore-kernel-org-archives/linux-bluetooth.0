Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE3EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 21:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBBVUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBVUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 16:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD96A331
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 13:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCEB3B82876
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 21:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B65AC4339B;
        Thu,  2 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675372817;
        bh=Fug/sKYgGFuHkmJRVDISEkJUXNfV/iFV0VoRhi5nMSo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YYzMfaqax1u/Bs8Iz7RcUMuORIY78I2WlBuXnZIkbvqfiqfNxUloIai39CcJ7GjAF
         U4aFKrIOOjNfYeS4ZZOP3VySh9rRGGNE+l52d4X2cLFbnDujgQ54Y3/FRkcTGiKBcr
         x58F/hg3yr07iZl18ZHqXTYi0LJ4qYZnmTSlNJ0qYVmm3QwJw7bnaGwXMl85vgXS0+
         xBTzjLX0MadBTX+44TOvvc+4KVW9fyl9yyxks24oJAk8y4x0bixtKLXtUoRiGMr9mw
         usllVhtjKlkP5lb9veA3Omu71knocfyUdALPsWcalfJDU/QvTSGob7amBzktsXNT4r
         JcsCriyR7fkMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51AC6C0C40E;
        Thu,  2 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix potential user-after-free
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167537281732.11585.11132759600776902969.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Feb 2023 21:20:17 +0000
References: <20230201220704.1543663-1-luiz.dentz@gmail.com>
In-Reply-To: <20230201220704.1543663-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Feb 2023 14:07:03 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes all instances of which requires to allocate a buffer calling
> alloc_skb which may release the chan lock and reacquire later which
> makes it possible that the chan is disconnected in the meantime.
> 
> Fixes: a6a5568c03c4 ("Bluetooth: Lock the L2CAP channel when sending")
> Reported-by: Alexander Coffin <alex.coffin@matician.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix potential user-after-free
    https://git.kernel.org/bluetooth/bluetooth-next/c/c076b7d4e311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


