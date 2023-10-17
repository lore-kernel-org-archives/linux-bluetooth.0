Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB4CDB482
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjJQXab (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Oct 2023 19:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQXa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Oct 2023 19:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9992;
        Tue, 17 Oct 2023 16:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D54B5C433C7;
        Tue, 17 Oct 2023 23:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697585425;
        bh=F19AIuWps+oFrYH8x6B7coL3wkdUt+k3yWrH9Gy2Mkg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t9OSlMXAflk4PpJblN8Uo2R2260sS8qQzSn6UefWFZ2DWS5M4x/rz7kPoyQ03KYco
         uGZCJKIayPfOQrJqEv2rHaKg2MOXR9HYXAHrCZOJGHG6RKVPdSq00OMHuYeUwMw9qU
         N0eYCSZRidNJTLHfGqLAADNJtXvKYj1u9mNAVQKXEcfmT/+CR3QKyQFQ3HZ8rFYUUg
         iiJZAAj+89S+tfGoS2dHg7vWEliFIX3uGPlKsk3J6s4lcd1IyrzGtQmUNuIscV/9dW
         ZZMmN3+fUTOAi8c16TfQvle2Ia2ikszhAlWAwbTUBhAtoBiFPARcpkIPJN7joR6AbS
         X+kE4CujJYfHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8D98E4E9DD;
        Tue, 17 Oct 2023 23:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [kernel PATCH v3] Bluetooth: btmtksdio: enable bluetooth wakeup in
 system suspend
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169758542575.4587.5326115164218555952.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 23:30:25 +0000
References: <20231013124707.kernel.v3.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
In-Reply-To: <20231013124707.kernel.v3.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
        angelogioacchino.delregno@collabora.com, johan.hedberg@gmail.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Oct 2023 12:47:07 -0700 you wrote:
> The BTMTKSDIO_BT_WAKE_ENABLED flag is set for bluetooth interrupt
> during system suspend and increases wakeup count for bluetooth event.
> 
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
> 
> Changes in v3:
> - Replace deprecated macro.
> 
> [...]

Here is the summary with links:
  - [kernel,v3] Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/2fddfadb0478

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


