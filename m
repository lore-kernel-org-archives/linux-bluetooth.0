Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C67C001B3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF0TCB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0TB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 15:01:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4A185
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DDD61210
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 19:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F05FC433C9;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892513;
        bh=xZqTGmehsLYPdQdAdr5GswqHugDzpBDyVQUPE6vBiZo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d59sye1UsAOgaYWiul5Zbh/0NINpd6vjdNW2+D0Qa75iASazCYDnmcshaer5Gu/xA
         NqyVnIyvwXVTUkq+Lw7hOz+ST0jj/sMMv64rTLGVYTNQVmwPGIztPZ+8u91d2B+hkF
         dtPIkfz9Z3zsr5M6qzXXxRTVtucddoR4wTQX+ymqE1nQaGj+EB0D/lNSyOFgQyLzbj
         t73kA3I+rGh4Vx+dGtpkH0F0856y9sUX9577khOZwaC17n1erWJg8PGHXEK5KyyewN
         +0tv1X2NBfv8RiDLnDKmfqudiUQyxYhh6ZNvelNzCIVDedjiNA4mEIVB6V2xnvC6bM
         lPq3X8WrI1hGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FB1FC6445B;
        Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168789251345.11348.3015421877953257030.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 19:01:53 +0000
References: <20230627003142.2274828-1-luiz.dentz@gmail.com>
In-Reply-To: <20230627003142.2274828-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Jun 2023 17:31:42 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The ISO Interval on CIS Established Event uses 1.25 ms slots:
> 
>     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>     page 2304:
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
    https://git.kernel.org/bluetooth/bluetooth-next/c/8649851b1945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


