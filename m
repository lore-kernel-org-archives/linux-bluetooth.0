Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F91EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjG1Wu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjG1WuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB41739
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0AE6220F
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A65C5C433C9;
        Fri, 28 Jul 2023 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690584623;
        bh=TQWFelsU9bglSn6Y6QjBDuPrTI7dWELbby/IVw1B3fU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PLS2AInbIZ+VPkkl3+bVIMQ238hmqPM+yjf45sH9/5J0zfK4nYIjS8Zo2jj3Chmk8
         FqsUHZQeuBBb/c4klpbSVeyuKfjCNmJQwrAWDA+IUHLcHZKhmTa2nXGR66gXjI9rRd
         OKkx3grxtDS1/7y7xTN2ETCHq+6dQUYahGXhjcLdWGO8+iJRsYQSSCziVju5qoPDVa
         rH0nhwL0kiAIv/BEmTVGNXyCbJg2QIfgtdX2TpjIq2IvmOMChs9g1tk0U51uRyQVrU
         1SetvV4Uc2ASpaApy/DehUeQQXJSQ9EkMt+82HqIquR58xi9HgU8XBjm07Z5XQgfEp
         vfSg4KDoyhGIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BDA1E1CF31;
        Fri, 28 Jul 2023 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/8] Various fixes and refactors
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169058462356.19376.9499813447369169606.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 22:50:23 +0000
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Jul 2023 10:44:23 +0200 you wrote:
> Fixes for pairing and discovery for dual mode devices
> Fix for EIR_BREDR_UNSUP flag
> Add handle numbers on dbus for client
> Minor refactor, fixes
> 
> Simon Mikuda (8):
>   advertising: Fix setting "BR/EDR not supported" flag
>   adapter: Be able to use ConnectDevice for discovered devices
>   device: Refactor device_discover_services function
>   device: Rename start_discovery function
>   device: Fix pairing and discovery with dual mode devices
>   device: Handle error from discover services request after pair
>   gatt-client: Add read-only handles to dbus
>   adapter: Ensure that file exists on IRK write
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/8] advertising: Fix setting "BR/EDR not supported" flag
    (no matching commit)
  - [BlueZ,2/8] adapter: Be able to use ConnectDevice for discovered devices
    (no matching commit)
  - [BlueZ,3/8] device: Refactor device_discover_services function
    (no matching commit)
  - [BlueZ,4/8] device: Rename start_discovery function
    (no matching commit)
  - [BlueZ,5/8] device: Fix pairing and discovery with dual mode devices
    (no matching commit)
  - [BlueZ,6/8] device: Handle error from discover services request after pair
    (no matching commit)
  - [BlueZ,7/8] gatt-client: Add read-only handles to dbus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cda5549f2475
  - [BlueZ,8/8] adapter: Ensure that file exists on IRK write
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


