Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D01ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIITat (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIITa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 15:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB03B97E
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 12:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F57620C6
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 19:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E960C43470;
        Fri,  9 Sep 2022 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662751817;
        bh=Qx6RXJE9PYq/S1qrdM8ODJp0UjuDJVk3wJfYB85hiE4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NvaozRls6h1rIFsCtLgxUD0JGRNA45l1X/b60z7Zvp1/mMIFzHr1Nao7BMwvoDSqL
         YDdt1x9It8OeGUfaNR1UgQDlYehoDSyX4bBqxeABSs08yTx5/EHzJjEKicxb+bc5zp
         VCSvUOndoFGC6nRg1ZO8QtckUjTvbtovtoMfXRoTP0nW+lMzlNShFGOaF7kfFtMh5X
         M42hgjSlEo0OxLLlpisW4b7jQjgZr8xoErXhcAJckhxRRhOkZ5RdJWAaDplHBGKkaB
         pl/AM2sSuNXkuypBb31VWFIGRlSVgXTZYuuuS2oSuzhQv9gq2IQjJhVDqNrNE+GxmY
         +lrgterbgXRyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0419EC73FF0;
        Fri,  9 Sep 2022 19:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix HCIGETDEVINFO regression
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166275181701.14413.5901937901820747185.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Sep 2022 19:30:17 +0000
References: <20220908212135.3543626-1-luiz.dentz@gmail.com>
In-Reply-To: <20220908212135.3543626-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Sep 2022 14:21:35 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Recent changes breaks HCIGETDEVINFO since it changes the size of
> hci_dev_info.
> 
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix HCIGETDEVINFO regression
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a40f883781d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


