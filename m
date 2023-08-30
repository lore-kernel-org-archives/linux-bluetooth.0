Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC7C83F01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbjH3WjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbjH3WjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 18:39:07 -0400
X-Greylist: delayed 1019 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 15:38:39 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5C95
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 15:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22FBDB81801
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 22:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E153FC433C9;
        Wed, 30 Aug 2023 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693434024;
        bh=ODnmI0uGY0o+nO84UxwxP6O8gK5BveF6TdvRtpkOU1U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PxigYQ2UDzaCqekeiatB4hYx7sQFjaIs+QahqtSkfIyvpRpenMwRgHadMxy1wu9sn
         bTmoRgjLu3mKmF2RFOEFu8oSxgXnlRLfAFsnOOCTKbUM0lWzjtSMRY3HqqY8QtSV0F
         SrB9FGwLZHkiypzYb9Gaxb6v1fCuWIsK1yTDM8g9siNVD5UZ47mmg/mBMAg0F9u2Ea
         W01xUz1EgbtF44huixtzPv+qT2YvOZMcMxPTh9U0U6gVJNihc5L4YCL3ULJneUHwHE
         U/uRtsA1M8VRzwrS6e/8cK8TKbN9scsG/hszIkiQiq8R62imC/7IYrs7HenKj1lkNJ
         qAVo7mVyK1jzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2DBDE26D49;
        Wed, 30 Aug 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of
 HCI_QUIRK_STRICT_DUPLICATE_FILTER
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 22:20:24 +0000
References: <20230829205936.766544-1-luiz.dentz@gmail.com>
In-Reply-To: <20230829205936.766544-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
> periodic restarts of the scanning procedure as the controller would
> consider device previously found as duplicated despite of RSSI changes,
> but in order to set the scan timeout properly set le_scan_restart needs
> to be synchronous so it shall not use hci_cmd_sync_queue which defers
> the command processing to cmd_sync_work.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
    https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


