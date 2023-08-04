Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E8C04A94
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 22:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHDWu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDWu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 18:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846546B3
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 15:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 663306216A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC612C433CB;
        Fri,  4 Aug 2023 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691189423;
        bh=Rw2JVx8IQ4HbCBxmyIfjk60aS9i7uzZIJa4+3NXV3aM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ufe9PWIR8xCUswKsbgYpC30nAg0PH1+dgTK3VnvcHZxjqy68WdrrNkWVnJhnJVZYD
         bJATtWbtRSWilQOjwSvhx5xBZZxyB7OK16JsEoCy525KtBuYLZEAmN8lGFHHakedlj
         aObpvSp9MBT62D1BOJKU496HHlmycO6xVO8slcXtuFikQXGyAWfGTrqhlBTMLHrScb
         oJUKdtOZnZxaqf9t51Qp/CIUTXvUJRw3s4ot96lmE5O+NIQG8Tg04NqjuCDRnOGbIu
         wxMZM1cZ7DmQn+KE7JCWlSIobR+Pi5E74f8s/Npcmspv4j7wNu+U8nJTCdaCeuhznz
         rS2AOh11uGH9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B02D1C6445B;
        Fri,  4 Aug 2023 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] Bluetooth: hci_sync: Fix handling of
 HCI_OP_CREATE_CONN_CANCEL
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169118942371.8518.5868752901322841839.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 22:50:23 +0000
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Aug 2023 17:11:11 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When sending HCI_OP_CREATE_CONN_CANCEL it shall Wait for
> HCI_EV_CONN_COMPLETE, not HCI_EV_CMD_STATUS, when the reason is
> anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is used when
> suspending or powering off, where we don't want to wait for the peer's
> response.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e4cdf2f6122
  - [v2,2/5] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/bdc83c443c30
  - [v2,3/5] Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
    https://git.kernel.org/bluetooth/bluetooth-next/c/e5ab05c24643
  - [v2,4/5] Bluetooth: hci_conn: Fix modifying handle while aborting
    (no matching commit)
  - [v2,5/5] Bluetooth: hci_conn: Fix not allowing valid CIS ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/90b1f9ebdea4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


