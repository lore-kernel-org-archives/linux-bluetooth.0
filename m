Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F3C25B06
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiHIWAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHIWAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 18:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5245121
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 15:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3937860FB6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 22:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E36BC433C1;
        Tue,  9 Aug 2022 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660082415;
        bh=X+MO6VdxVjdQOFr40fbQmwi3sAby5Yo9D77H0LPciyI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tBxpKMBiCHcfJK12fjDx3rXsnHMZu/+6EBvmt5ON1ZrtPTsKbUq3gLzfX8tAGyb45
         uU8yXzdBSnIvhqdBBF5B7czEFNeRwMG+0BUYi7mCAybkEccZxWbCiA2ymzcJJVaNgv
         CCxjQ2X1pB7X374pFB0tjMDDiD+1lArxyCUiX0pV4ee1gHL7Qq/IioOUtVwvcF77l/
         gnPrlGJRk+jz+HCLmn8dns7/xs/Mw3Gq9Q6M+2dsDj0ii6ZLOx2xXrORV9uEjkTe7Q
         CpWSrAQVTBORVZHQOivTmdSyQZj9VpNfk0ugiAyXCHJ9ZBgc2o4jOzO5dFr+DaU31Y
         1X3cjeClAf1Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83F91C43142;
        Tue,  9 Aug 2022 22:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/9] Clean-up stale/unused hci_request.c code
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166008241553.11039.8770757425299965789.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 22:00:15 +0000
References: <20220805234236.704986-1-brian.gix@intel.com>
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Aug 2022 16:42:27 -0700 you wrote:
> This will be a growing patch-set of conversions and dead-code removal
> towards the goal of retiring hci_request.c
> 
> The patch sets will be split amoung the work queues and delayed work
> queues as initialized in hci_request_setup(), with the ultimate goal of
> eliminating hci_request.c entirely.
> 
> [...]

Here is the summary with links:
  - [v7,1/9] Bluetooth: Convert le_scan_disable timeout to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/2bf8edacd155
  - [v7,2/9] Bluetooth: Rework le_scan_restart for hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/89f043b2c6d5
  - [v7,3/9] Bluetooth: Delete unused hci_req_stop_discovery()
    https://git.kernel.org/bluetooth/bluetooth-next/c/eed7aab6c517
  - [v7,4/9] Bluetooth: Convert SCO configure_datapath to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/71172654bff2
  - [v7,5/9] Bluetooth: Move Adv Instance timer to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c59889a6b5c
  - [v7,6/9] Bluetooth: Delete unreferenced hci_request code
    https://git.kernel.org/bluetooth/bluetooth-next/c/3edf244f8c71
  - [v7,7/9] Bluetooth: move hci_get_random_address() to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7eb26d1285c
  - [v7,8/9] Bluetooth: convert hci_update_adv_data to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/9ec46ac996f5
  - [v7,9/9] Bluetooth: Convert hci_abort_conn to hci_sync
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


