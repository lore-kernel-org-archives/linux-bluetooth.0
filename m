Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3EC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjERTkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjERTkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 15:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827B198
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 12:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D017651D6
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 19:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB66C433EF;
        Thu, 18 May 2023 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438820;
        bh=fTx8MZreExUSU5U++p044wnvd/74Raf5NGqNwu0V8fg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gH81WRCbqSZp3XPU2x6FsXQLDLKOsKmh9vGY5nsUd9MmeXBhgarKKER+b56MZone6
         rhR7ksY52UArA/cA1MUZdumf+DPTPbA+STonoYmnOuW4dVAuNMFreZjnZYA7NoyKIb
         FX6aiTK0yy0ed+rPi8PYdiN6Fc6C1Zz/zkDOZsPXBc3OfPjMNOFAG6eLQTVxKrGEGK
         wyFRdT1ITQFV06lVsopOo70PiZZ82LqJ8VA0N+OaJcOf7znpJH/jFjEJdFvqDeo+wo
         CfTqs/69JUr1EPeaql99+ixqD3VGnN3aGMyZgoVAQZVJFMLMHz4jAH+jW1+xj96VEA
         VuY3/Mo0fg4vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3CA8C41672;
        Thu, 18 May 2023 19:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Fix using PACKET_FILTER_SHOW_SCO_DATA for ISO
 packets
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168443882066.15656.12131175766452025990.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 19:40:20 +0000
References: <20230517215852.1395512-1-luiz.dentz@gmail.com>
In-Reply-To: <20230517215852.1395512-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 May 2023 14:58:52 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the uses of PACKET_FILTER_SHOW_SCO_DATA for ISO packets and
> introduce a dedicated flag for it in the form of
> PACKET_FILTER_SHOW_ISO_DATA which can be enabled with use of -I/--iso.
> ---
>  monitor/main.c   | 9 +++++++--
>  monitor/packet.c | 5 +++--
>  monitor/packet.h | 1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] monitor: Fix using PACKET_FILTER_SHOW_SCO_DATA for ISO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9526ef46e465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


