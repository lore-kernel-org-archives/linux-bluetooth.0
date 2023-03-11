Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE3C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCKAxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCKAxZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:53:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C775142DFE
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFEB61DA0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64AB1C433A0;
        Sat, 11 Mar 2023 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495821;
        bh=Mz3fM8/0PEYWBwQk1/Q2Z/CGTAKaH/5AqDpx5rVu/RY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jfeAQWORps0dEJI0mRRZBEboqTBQLplqy2liXevcXWMtaV1h1zirzYaFJI7B5Oet6
         VyH0lE267vvPYOEpr3Q4BgGKq5WnMTm1My6ok4zwTsfKhb7s37n2WqcCpEmnHl5BlU
         X/LNqZhxUlCklXb2YAJ1uEkxbQQEpf7fUPsdKbSfsSBFuOKIkPHDfrIEMMKhwULkb3
         wg/b2WEWLiARiupLXzkGQJxH6Qu6fK3U8pimzfBfTYMMMBO8uUsJSohN2jQF2U7t14
         nuuEQJKrKVII3JSAb8/6jAw21T2iL+E5ME+NThV7tgaWn+WgXyIAAUNniSnSqViuA1
         dJce3WgX0oQRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50C6CE21EEB;
        Sat, 11 Mar 2023 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Fix responding with wrong PDU type
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167849582132.26321.12102069940723072856.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:50:21 +0000
References: <20230310000055.3396026-1-luiz.dentz@gmail.com>
In-Reply-To: <20230310000055.3396026-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Mar 2023 16:00:54 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> L2CAP_ECRED_CONN_REQ shall be responded with L2CAP_ECRED_CONN_RSP not
> L2CAP_LE_CONN_RSP:
> 
> L2CAP LE EATT Server - Reject - run
>   Listening for connections
>   New client connection with handle 0x002a
>   Sending L2CAP Request from client
>   Client received response code 0x15
>   Unexpected L2CAP response code (expected 0x18)
> L2CAP LE EATT Server - Reject - test failed
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: L2CAP: Fix responding with wrong PDU type
    (no matching commit)
  - [2/2] Bluetooth: L2CAP: Delay identity address updates
    https://git.kernel.org/bluetooth/bluetooth-next/c/1c991f006035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


