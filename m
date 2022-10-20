Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF55C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Oct 2022 21:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJTVKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTVKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Oct 2022 17:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC08E710
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4AC61D1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48A78C433B5;
        Thu, 20 Oct 2022 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666300217;
        bh=BHNuUzdH/DmsNCi51meQV9s4WBKSi869Ii+9wFpBgl0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=clwnkARszRNj3z+n/PeQcZ3i9TK+QpuGdlqFGFZoumCTvdiNqt5UA7C04GS2kQJs3
         LUHyAqb6icAL0PiQ4ErIg8jHsvwfXuO9SkYRB3S4wAypJMV/nPzEDhRN7unSPqX9Eg
         TKVTKqY3TAPGXeHcTSyGJuBLLiU8pkEbVytLl5LMMx659bF8UI70B0AbYlzEkpES3y
         jZSiE7cgrSzGtteGQROcVtC8yGrGpLUXQcCtVy4iZvEVlUmhYxmA0TzRENUbOTry0f
         uDSNstcItN13UA9e3FX4AUyZnca/fDS48opkPTGpaUn3jSZaiEPksUCJ+CLu/hQhQ8
         pXqDrtcLAlmAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26039E270E2;
        Thu, 20 Oct 2022 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_core: fix error handling in
 hci_register_dev()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166630021715.31243.1085904526366100161.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Oct 2022 21:10:17 +0000
References: <20221020021656.2092938-1-yangyingliang@huawei.com>
In-Reply-To: <20221020021656.2092938-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Oct 2022 10:16:56 +0800 you wrote:
> If hci_register_suspend_notifier() returns error, the hdev and rfkill
> are leaked. We could disregard the error and print a warning message
> instead to avoid leaks, as it just means we won't be handing suspend
> requests.
> 
> Fixes: 9952d90ea288 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_core: fix error handling in hci_register_dev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f334dabe7dae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


