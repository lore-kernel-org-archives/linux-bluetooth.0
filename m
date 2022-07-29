Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3837C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiG2AKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiG2AKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701712D15
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 17:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CBD61D0A
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6982C43142;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659053414;
        bh=EEx/SyvvsGtDvnksDgag6Xx/Qkou5DtjgzGv7gjKLSg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lr+O9hZPw3kwytT9DUQMG3AYaAljwVAZpl6Poo+/05k429XyOdWQRLIHSzLLgu9wS
         OPWa19hP+vF0tDBn4pePHYxxrL1rfCuutqEcKvAw3MXPmoCi7rnz4ex1Qh2NYACIsr
         XBoiCG/fJljfTnQ8wI9+BWYzvQnxDuYI1pBVL0YujXJKD1/5JEOdWDvBWc67sWmZZH
         yfUeUp3yzGU5sQgCjQYO8EOCHqp1nXVoJ/qb5F7sI4TX4KteA91xMQTMT6WN4M77Rg
         9vKE4h1dJPoGl9Z/mlBR0gRpuHKJ4Kx/4c8I4zMGt6gYnA2C2VanIk/NCdGwLXi9qQ
         WGGYZbNhvSknQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2BA1C43145;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix updating ISO QoS PHY
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165905341485.26440.17052003841675206872.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 00:10:14 +0000
References: <20220728210556.1236145-1-luiz.dentz@gmail.com>
In-Reply-To: <20220728210556.1236145-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Jul 2022 14:05:56 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_ISO_QOS has different semantics when it comes to QoS PHY as it uses
> 0x00 to disable a direction but that value is invalid over HCI and
> sockets using DEFER_SETUP to connect may attempt to use hci_bind_cis
> multiple times in order to detect if the parameters have changed, so to
> fix the code will now just mirror the PHY for the parameters of
> HCI_OP_LE_SET_CIG_PARAMS and will not update the PHY of the socket
> leaving it disabled.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix updating ISO QoS PHY
    https://git.kernel.org/bluetooth/bluetooth-next/c/8ce91829ab3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


