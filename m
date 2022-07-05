Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B016DC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiGESaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiGESaR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 14:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADF1A806
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 11:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2FE9B818C6
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5F58C341CE;
        Tue,  5 Jul 2022 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657045813;
        bh=TeUecqSICSnRRpzt8mjIXz9YEWCTnMP75aMFIG25e+Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U3qKnsZ6iTyYlcRmrBATV+HSbzY+9KhmE16/w7+dISREZ12tMJswsctrhm1pNFZOe
         sK/2eYvSGsxO0UfixNfzNOeaezyPUyVaW18lo4Lt+BPSzWOKEyaZWGQYDkG2quYi2D
         ZJnLz/b9R6eItWbupQultPc0NW00EWrjxw6/EgebBif5vOkGQVqnu9q6W1xBQcLDdR
         YFaGWZd3tfVWgcOlfkt8SDz9ZcGMQfUZ5N3JgMMmkcJH1KS5t67LJ4uLu2+bfNWNqr
         grW+pvcD8Qfk86AVFWZ2eHYvxXflvFEjRWYETXW0ZZ9OtqByHDjU+ofGZQpP77zUbO
         RTCfxNKzJqoMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C549E45BDD;
        Tue,  5 Jul 2022 18:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: core: Fix deadlock on hci_power_on_sync.
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165704581357.4649.14518954440800878534.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Jul 2022 18:30:13 +0000
References: <20220705172501.1610923-1-luiz.dentz@gmail.com>
In-Reply-To: <20220705172501.1610923-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 Jul 2022 10:25:01 -0700 you wrote:
> From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
> 
> `cancel_work_sync(&hdev->power_on)` was moved to hci_dev_close_sync in
> commit [1] to ensure that power_on work is canceled after HCI interface
> down.
> 
> But, in certain cases power_on work function may call hci_dev_close_sync
> itself: hci_power_on -> hci_dev_do_close -> hci_dev_close_sync ->
> cancel_work_sync(&hdev->power_on), causing deadlock. In particular, this
> happens when device is rfkilled on boot. To avoid deadlock, move
> power_on work canceling out of hci_dev_do_close/hci_dev_close_sync.
> 
> [...]

Here is the summary with links:
  - Bluetooth: core: Fix deadlock on hci_power_on_sync.
    https://git.kernel.org/bluetooth/bluetooth-next/c/bf909caec390

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


