Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED401C2FC22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 19:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354757AbjHQTua (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354799AbjHQTuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 15:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06479359D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A84E6477F
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE13C433C8;
        Thu, 17 Aug 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692301823;
        bh=FCG79+3TPeyKnDk03gtZYm5w+n98A+FvfPHSft9PXHc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BAPZfXXgcNzWMKYr2BYpPXVXShnmilA0bhI46g/VES8vuhaDPGoip+xdh7iPUtr0/
         3HZs+o4A9hiQs3R4frVAtL2BeX9wQaJjlcnzL11+ZW4cbmBT3fEc0xAHwzY5c/MTZz
         CWveZJ2y6HdDu7U++1OU//vDg349zLXcLELfW6uvLKYVpqfke+8K+v+kJjq/MWeTot
         opLeZrQcnQOg3oe0cAeRWIfWoQNac242S0qkFcXMMzXzckhRI6o2UofGv+X2JzSnc9
         2ZdMzwL+yWog1ZTJDZwAnSWs6F38MumyJZGc4+O0xHWntqyzeN0SIaTJyHpHSLz3s2
         XWRxnnaJVprUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8666C395C5;
        Thu, 17 Aug 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] monitor: Fix not printing latency information with
 -r
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169230182287.7718.11850892118907803611.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 19:50:22 +0000
References: <20230816223147.2787284-1-luiz.dentz@gmail.com>
In-Reply-To: <20230816223147.2787284-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Aug 2023 15:31:46 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When reading a log from file hci_devba may not work, also store link
> information so assign_handle can use use the parent (ACL) destination.
> ---
>  monitor/packet.c | 40 +++++++++++++++++++++++++++++++++++++---
>  monitor/packet.h |  1 +
>  2 files changed, 38 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] monitor: Fix not printing latency information with -r
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31941ff3977c
  - [BlueZ,2/2] monitor: Detect LE-ACL connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aed756136b7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


