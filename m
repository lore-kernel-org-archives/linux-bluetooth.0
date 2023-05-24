Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E63C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 17:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjEXRAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjEXRAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 13:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34726E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 10:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 852F96157D
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 17:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3599C4339B;
        Wed, 24 May 2023 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684947620;
        bh=giPK1e/60phTCVHQMqQVCPGxO5SZmjEs+KPnSS0eCVY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WSxmAwNweZ8keCHOLQ1ixUYHDCgHedkxOJm+N2zu/SSRwkGrl2QdvQu+VhrbU7/3i
         pEWl8gCBSCRtOUMRmJ7dge1oCbwSZg4Wej2tDxgj7ohID8EA5+Fa9G6kBJPHUvwR8M
         mZQ6a+ttOhELMs82GSlSJWLsOshZQLuf6roh9fjxbl6nGjNzah+Wn1zhpMorY6HoiP
         QNTJ05clS51gRgZ3jGwItIgZBTmCNkSqw6i3ZYv6ciW7tnsoZzWZ/DI7wgTfFgSqTX
         5z9Qo4WKOMplXw2/n+CyUOlvAWDrVilGa6gwbu6zOp7vAkqUPeYn44k2wGk1Iwtfda
         q7yDHSxT2P+8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9D7CC395F8;
        Wed, 24 May 2023 17:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Add latency information per channel
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168494762082.20557.13840001344894804013.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 17:00:20 +0000
References: <20230523205855.2821370-1-luiz.dentz@gmail.com>
In-Reply-To: <20230523205855.2821370-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 May 2023 13:58:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to print latency information per channel in addition to
> per connection/handle:
> 
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256 Address: XX:XX:XX:XX:XX:XX
>         Count: 1
>         Latency: 15 msec (3-39 msec ~18 msec)
>         Channel: 68 [PSM 25 mode Basic (0x00)] {chan 2}
>         Channel Latency: 15 msec (6-35 msec ~18 msec)
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Add latency information per channel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=718f27d09fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


