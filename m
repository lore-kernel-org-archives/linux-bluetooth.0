Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5729AC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 23:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjESXkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjESXkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 19:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8C1BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 16:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 870DD617CA
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E081AC433D2;
        Fri, 19 May 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684539618;
        bh=9ZVaZpnUwn6zuPTlPeCTMjFWbO30X0xHnYgOUJp1PZo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ki7kEkolI3JW3Ec9l+Tp3q9cZZUo7b2Ey7QSh23VVjvXEbjkk/Tz8VrSoXxg1p6TU
         MGqNjpmX0HLSYtvMj650LmLLiOMBTftW2VsIIWwtlWRBqOMazinulvLgj9BJb9Ybn6
         QMVq/9o9pCCCOkjCTrnwJmq4ulYIsloYsb3CVPT9eyrIw+9kGK6kP0/I775wPUYBfq
         y+D+F2OsbqgFC36/dOVIYjv7ngjZSVq8k2+LjoeaqMLvCoJvlppmun0zHd9KUk1VPO
         T85vxRKcQ2qC/kkV2BJ5ijdFBpDp2FMJfB/pP9+HolkXgD1iGymm++Zv6Y8oSzCrSi
         zNK5uiPwp+MCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3EA6E21ED7;
        Fri, 19 May 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] monitor: Fix not parsing
 BT_HCI_EVT_NUM_COMPLETED_PACKETS properly
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168453961879.6137.7052838691395001858.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 23:40:18 +0000
References: <20230518232049.1656554-1-luiz.dentz@gmail.com>
In-Reply-To: <20230518232049.1656554-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 May 2023 16:20:48 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_HCI_EVT_NUM_COMPLETED_PACKETS may contain multiple handles but the
> code was just parsing the very first one.
> ---
>  monitor/packet.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] monitor: Fix not parsing BT_HCI_EVT_NUM_COMPLETED_PACKETS properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e99fbb5e4eea
  - [BlueZ,2/2] monitor: Add latency when decoding BT_HCI_EVT_NUM_COMPLETED_PACKETS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd176eb2d444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


