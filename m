Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9ACC77B6C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbjDFVA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjDFVAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3FD7ECB
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDF9364CB5
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D17FAC433A7;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=R7+aTgNL/hWyq7B0zzJDLNM+K2ut60wjjZO4LViq9CE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eUqZ7bnpLaieufz14V8vuccySG72OeHykS7Eh05/1dvJiadBFXpCJs+GjGSnCsXCg
         FKLVywQvz7xJ63QRKLuUN/5ti53YUnVm/igln+sEy3L5simm33NJHVUijC72lCgxiT
         5RSkCiKoeFxcfvsOt1Z2kb6orX5odNe68q0/bEaXahOpBOsygusUENjdndU9G6daoH
         6S0FY8bOtBMIAXWJ+nib/gBBScyEaCbLyqa3HrYVxu2VF8hG/V08CfhMEFEWDDYxNf
         Q00cm7qMMF4yulfWDiadZieNxt1nBxMMBU1p9loLTeOE+HHgTCwheRFMbGcOLbDNgS
         fimX3zaaKKnBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA3CE4F14C;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND] Bluetooth: Enable all supported LE PHY by default
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482076.2619.8354131071987556780.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230404210537.2329660-1-luiz.dentz@gmail.com>
In-Reply-To: <20230404210537.2329660-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Apr 2023 14:05:37 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables 2M and Coded PHY by default if they are marked as supported
> in the LE features bits.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: Enable all supported LE PHY by default
    https://git.kernel.org/bluetooth/bluetooth-next/c/4f0484215825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


