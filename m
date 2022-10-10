Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 21:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJJVBS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJJVAv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 17:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720483DF1E
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 14:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CFD61025
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C461C43470;
        Mon, 10 Oct 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435617;
        bh=FhMhrJ8RnZbd3lw6oiB2YvI24+9LbI6CyLxmzyu0xXg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I6An8S8WchHMnyD/3LH7tFIDZ8GhH4qsu1/LM+a3GbtJ0tkV+uwUinbrTwgBXq18R
         PlHMP42kepYB+H2g5IwRvaoz6e4zJl3qFX6t9pq4ojWO0aXkggLD1xxYA/oBP1D264
         0nPjXQxdMDFrrlr/odBWd6gY5sUvqSQ8wCXnSYfyuq6fgBJHXYpiRGxqWJ1CnOFQYi
         /k0KQmpnSJYUwpa5FUEr5KB6Q705/abzdwQokflyQPrk+hQMQOZVoadIk4QlDEDcN4
         fvpOPd20HGp71tf7MzLV4E3zuiSo5foE/rVslpaRWBz8uVDbpTzgBYWKtkk/p7ZZec
         uLEgZCaquDVwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78167E4D024;
        Mon, 10 Oct 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] btdev: Add support for setting bdaddr
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166543561748.14234.13302214712570934172.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Oct 2022 21:00:17 +0000
References: <20221008011410.1907549-1-luiz.dentz@gmail.com>
In-Reply-To: <20221008011410.1907549-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Oct 2022 18:14:08 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btdev_set_bdaddr so it is possible to set an arbritrary
> address.
> ---
>  emulator/btdev.c | 10 ++++++++++
>  emulator/btdev.h |  2 ++
>  2 files changed, 12 insertions(+)

Here is the summary with links:
  - [BlueZ,1/3] btdev: Add support for setting bdaddr
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c94cdbc6d73f
  - [BlueZ,2/3] vhci: Add function to interact with force_static_address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2bf15137410
  - [BlueZ,3/3] mgmt-tester: Fix Set Static Address tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9065853fe5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


