Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E447C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 23:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGEXAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGEXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4F1988;
        Wed,  5 Jul 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5978E6181D;
        Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0CC8C433C7;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598024;
        bh=rym0yeR30E8iN+MBxotmOtWY6Qu3V95nDoYS4r1n2o4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i9B0GpQRirjP1G/+lp0Qh73sn2FP6EI7IUEps4Sc3JyCNb41uyPnAaRJT8Pr/NOOW
         Y5aE0F3j1rkfJYvHXfyqS3ZZYMgYtRlVVkIbNcWYikCok/ixb3MMXIact/1+blXhho
         nUOaCwHNW1e3025ZJXrH+7xE1fy3L9ESmksCqR9XMCo7PY3+Y4U4+jWlDGdpsMzYhS
         wQIRsA7c2QCgu4qBw68krdQ+9olPXN7WCOxYMsG3jkgy7gHTZ7RaU3YBG5nUGU2kiK
         Nmcjio91qbqGb6BHpK/MWgKNMLHK6eDLrT42shPR7bwdGmzlsjpX+UJHD54swELl1r
         cxGvUCUXys0ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99615C64459;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for
 hci_remove_adv_monitor()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168859802462.24898.5386569963493900697.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:00:24 +0000
References: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
In-Reply-To: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
To:     Doug Anderson <dianders@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        swboyd@chromium.org, mmandlik@google.com, mcchou@google.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Jun 2023 15:33:14 -0700 you wrote:
> KASAN reports that there's a use-after-free in
> hci_remove_adv_monitor(). Trawling through the disassembly, you can
> see that the complaint is from the access in bt_dev_dbg() under the
> HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
> msft_remove_monitor() can end up freeing the monitor
> structure. Specifically:
>   hci_remove_adv_monitor() ->
>   msft_remove_monitor() ->
>   msft_remove_monitor_sync() ->
>   msft_le_cancel_monitor_advertisement_cb() ->
>   hci_free_adv_monitor()
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
    https://git.kernel.org/bluetooth/bluetooth-next/c/2648c5eb33ca
  - [v3,2/2] Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor
    https://git.kernel.org/bluetooth/bluetooth-next/c/22d2055a576d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


