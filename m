Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJSTAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJSTAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 15:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AED189829
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 12:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA83B825B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EBD1C433D6;
        Wed, 19 Oct 2022 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666206022;
        bh=I+Ndfl/6KgRd2139Aa7H/lryN5ECZntd6qu9OJOKvuE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VY/PJtXrTKnpdLh5cnmibB6U9GipayATgtRF3qM0v/dqQdCmGoXPokUfkKXXPYH9/
         /P4LG5Hdt9x6z3kmnuZxepjR4FFGgtCT57SAiq1jd2Wmpjt8KkGXZPpAzcmktkZekH
         xbXoP/DBZH5RvhbNKH/iFnL2YpwaCCvZYnO6O01NMxbBSTtmpvylrV5lGcMSHwtjVz
         PO2QmWlkDkQUSDQg+0L8NoQTTKfwHCDdD372oPLTrI+BU5Mq4t3TNJ7t0V3FW5nN/m
         eo7/6vyVbdiL6AZm4HKy2ZnvgEVuRqQvHNeq3u2ILRTu4SuaY6cvZBZNlYq09ZMkHk
         hVSIQXcnRPerA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AC08E270EA;
        Wed, 19 Oct 2022 19:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix not restoring ISO buffer count on
 disconnect
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166620602230.8596.5615614106694977804.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 19:00:22 +0000
References: <20221017224147.3629459-1-luiz.dentz@gmail.com>
In-Reply-To: <20221017224147.3629459-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Oct 2022 15:41:47 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When disconnecting an ISO link the controller may not generate
> HCI_EV_NUM_COMP_PKTS for unacked packets which needs to be restored in
> hci_conn_del otherwise the host would assume they are still in use and
> would not be able to use all the buffers available.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix not restoring ISO buffer count on disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/62294445832e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


