Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A0C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 18:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIBSav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIBSaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DC53D09
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 11:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 919D4B82D0B
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 18:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43207C433B5;
        Fri,  2 Sep 2022 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143416;
        bh=U9cYXFwFOjXf5UHCiYpenH9cxxuMA8LsBl4qC/q4z+A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mp3W0E+GwfnIx7XrxIw45WNRepxjondbmiAPrz219uhb3LcEBwdvUaCzt2+5W6AAI
         rc+m6VbJZhYCZumLjQURUWX8ht8KtxRu6mahn3cd+L3tdxOoNul0ud5SybjBL/VIfA
         +q9KmWPILiDVHs1+0xoQKVBcuGq/Hfsuynrw0pTy43MnmxJEb69xBMfneVj7AcXPex
         jR/sZp1mgypw7ApFL4nay82zbOjPJuxYdINOBCOjM1Blg88vnHeviVxcAfzkYrK1sj
         GO1mV3gSwEgCQ+/e+6fiSSaQ/HjqakIpcG++cRS5FHFkJJQoYo3dr2wMZXLKJ/J6Pt
         f5RMgC1xHIN1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 315EAC73FE0;
        Fri,  2 Sep 2022 18:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix hci_read_buffer_size_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166214341619.20629.16131071869417089223.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:16 +0000
References: <20220902002717.1823748-1-luiz.dentz@gmail.com>
In-Reply-To: <20220902002717.1823748-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Sep 2022 17:27:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_read_buffer_size_sync shall not use HCI_OP_LE_READ_BUFFER_SIZE_V2
> sinze that is LE specific, instead it is hci_le_read_buffer_size_sync
> version that shall use it.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216382
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix hci_read_buffer_size_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1c013419bde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


