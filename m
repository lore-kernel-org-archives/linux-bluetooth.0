Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 00:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJAAkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 20:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiJAAkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 20:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB617CB53
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 17:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E2760180
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 00:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F09FC433D7;
        Sat,  1 Oct 2022 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664584815;
        bh=hIZ8g4U8r3E8OVyndeAov1jaRieuQw+rcAGPNIBDHCo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bbj68O209b3wEI1Elp5d8/pOjd5GosVn9/DeFDtnZULDUrs64vcJbM4VzNRmq/Rqz
         /Xt91ncMEh3Ketm0q8/zBM1R6+ddW+sRvirgwB9SgIeJDz/CHw4rGk5IKVrtmimWz7
         sxqsmzvwoltOIHYfUA0RemsdRsuNA5z5UvkeyJUweNS6KzBdETzlQLC+x35sT41Oij
         VeGVaIb0iF5QysLso7x9ujLf5IcamkWe5RlpXaeAvKdBnz/Ftbfpam80t2a8hegcWw
         lJAMv7PQu0PlBiYt0ZE97uGlrKf8soLWSxD8SWC6K5paoRdAKiqEbVAKREWVqBazsU
         e44vCPod+FYmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0893E50D64;
        Sat,  1 Oct 2022 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix not indicating power state
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166458481491.9280.8352314569786728981.git-patchwork-notify@kernel.org>
Date:   Sat, 01 Oct 2022 00:40:14 +0000
References: <20220930201920.225767-1-luiz.dentz@gmail.com>
In-Reply-To: <20220930201920.225767-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Sep 2022 13:19:20 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When setting power state using legacy/non-mgmt API
> (e.g hcitool hci0 up) the likes of mgmt_set_powered_complete won't be
> called causing clients of the MGMT API to not be notified of the change
> of the state.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix not indicating power state
    https://git.kernel.org/bluetooth/bluetooth-next/c/6abf0dae8c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


