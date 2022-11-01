Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558FBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKAUuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKAUuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 16:50:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9118B34
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4010ECE1DBC
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 728E3C433D6;
        Tue,  1 Nov 2022 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667335816;
        bh=Uq3wL6wwXa4KFGHVvKUZdjq3gg5WzjgTgFp0cy8pvuk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lhx01/Ol2Rgp3harza47b+VVxMjOCSn9jhI8le/2lHv6DJV83fJlzk2ghsdTwQrnS
         f7ZfiyE/JtkwWsuCxfC9WIN3PxcAe+z9TblDrYHzSnJsjnZYur8Nf044oEumIepmDm
         xhEkyqQA9ilmmjFXyKqooMDvU9CWcQaPiCodaNBSuYHzUvEWgMASfMBp0bbfqma5H4
         rRuhN2Ou3JllRF647hqXAw/8MbfGtdZWUI34mVdaiHxYrGm6cOrWg71kaxtcrZrx16
         dJXickYRlsY4GgU9Y3KWAo1vjO7Mffb86YFiJ5f2SIfSt1rSe5DJhFCCfy5TfJ6OQk
         Zp+Udc79KJOWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 557D8E50D71;
        Tue,  1 Nov 2022 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix attempting to access uninitialized
 memory
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166733581634.15990.15185356562874303701.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 20:50:16 +0000
References: <20221031231052.2718430-1-luiz.dentz@gmail.com>
In-Reply-To: <20221031231052.2718430-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Oct 2022 16:10:52 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> On l2cap_parse_conf_req the variable efs is only initialized if
> remote_efs has been set.
> 
> CVE: CVE-2022-42895
> CC: stable@vger.kernel.org
> Reported-by: Tamás Koczka <poprdi@google.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix attempting to access uninitialized memory
    https://git.kernel.org/bluetooth/bluetooth-next/c/34f07dd531a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


