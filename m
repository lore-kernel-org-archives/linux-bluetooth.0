Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C3EC7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 22:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbjEZWK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEZWKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 18:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE0F7
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F406542F
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 22:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE570C4339C;
        Fri, 26 May 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685139022;
        bh=tKQqP5NinQmkfXUyuNly3fvTRbAx8OuFOxDfEvaAhDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nWe9wnfOSc7Q9dY4EuEKvl3u9tGIeV0d8gwOA/z35HxAxGpWMFUhoj8AToA1caYP3
         6N+/T/PdUT6EAoKSqqhLcAobEpWjk9d4Xs+ESR9/vgufWmJU1WcgQcnP3k1AOfZsN0
         B+nhSS/G//o2fTiI1TIk4O+xaZZIqOAOG4s5ljVdXkZgGqKpNszngGnvsqrqpUdFce
         ueNYL5O2IlIVmRS3/c8jgYXKKe0c9SHmPnqqWk7X1pKIcupVso1qYYBQPaI0PPMdDu
         AMSZzdBYIv0a+kzkIsbvzahR1w8RqOoWOMbU8G0c4ZVk9W+34aeYCf7BGIBw8W/SHS
         fb+IKHwUj7TVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAA72E4F133;
        Fri, 26 May 2023 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Print process information
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168513902182.4400.12365722735968962103.git-patchwork-notify@kernel.org>
Date:   Fri, 26 May 2023 22:10:21 +0000
References: <20230525234621.3597759-1-luiz.dentz@gmail.com>
In-Reply-To: <20230525234621.3597759-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 May 2023 16:46:21 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints the process information when available:
> 
> bluetoothd[35]: @ MGMT Command: Rea.. (0x0001) plen 0  {0x0001}
> @ MGMT Event: Command Complete (0x0001) plen 6         {0x0001}
>     Read Management Version Information (0x0001) plen 3
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Print process information
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ec85350c4803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


