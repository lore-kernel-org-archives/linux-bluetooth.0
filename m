Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09FE732D0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjI1UA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1UA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 16:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A993A193
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50AC0C433C9;
        Thu, 28 Sep 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695931225;
        bh=MxD5dbF00geYo3n/jF2elSiX6HpEhf1gg/PHlwnws8M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z6vHT9y0POPK0LjMQ4Neo7rPJ1FmjxcmTdGYeJghKEPTo1XdmqfMgJiEDyw8gWoFk
         A2w0K5QIH3g286DqTZkbLrrUXUL2cJw4IXoRji2Owu729edKUnYHA/C44DGcAUmQ9y
         Fp+hcNhr7o5HjuXjPwTPBrc0CwHeYlAxHnk9QhP2xVzti7sZHXU/CxxJl+9kpGQElZ
         gf+vqJjxCTcZTwU4rIp0F9ihKlx/kYXPe9HChQbt6sQYSa68B9J95q4A0dh7Y97XSv
         NPo/MfDloW7bMvi4z6F0aYMrLEmnI7QXGjI5Qd1a9qwwju9Rgg11/clsnpChOflg0E
         22lMupC86SmsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3562AC395E0;
        Thu, 28 Sep 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: ISO: Fix invalid context error
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169593122521.10640.7001764205432711977.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Sep 2023 20:00:25 +0000
References: <20230928075257.3123-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230928075257.3123-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Sep 2023 10:52:56 +0300 you wrote:
> This patch fixes the error introduced by commit a0bfde167b50
> ("Bluetooth: ISO: Add support for connecting multiple BISes"):
> 
> BUG: sleeping function called from invalid context in __hci_cmd_sync_sk
> 
> When handling the Create BIG Complete event, in case no bound BISes
> have been found for the BIG handle, the hci_le_terminate_big_sync
> call should be made from the cmd_sync_work, not from the rx_work.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: ISO: Fix invalid context error
    https://git.kernel.org/bluetooth/bluetooth-next/c/62dc24251217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


