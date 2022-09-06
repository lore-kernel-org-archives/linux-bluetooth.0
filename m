Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BCC38145
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 20:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIFUVY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiIFUVB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 16:21:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338506365
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 13:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3851B81A3F
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724D1C433C1;
        Tue,  6 Sep 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662495615;
        bh=BDJYmHpse8YGz5WDV5X1eZOiesMqYwI8alYyCbDsE70=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ar33rjJXu52rrV+/SKO6S9ZJM30fksBd9LjNiw6ovwfBLo/ygb+U9ASFYhJ+OYMBB
         8jUVrWN7JoCCwsdAoJgJQ7ubRFJSBPZg8In1b659Gn+BkrsnnL8+7tjM19YFAX3vpF
         i/oZKZkHk9jaObS6sE0cvfl0uc3eMHAEJgEF7Gv2Bbb4pwI31GjdJlvbhMWV0825wE
         Bp3bH2B+5A+rVj8L0yp5b6uId54SERjxWXPmgd4ODhNBKkR41cSw1E7TZLjYwLs2sT
         kT9RbKVOa2nL2ShFachHHC3dbZ+vAtw+OPj6UKGSgY/dzpr7g4HXN5VEmjf+/mSAFm
         AcnVaRTX43/IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48ED5C73FE9;
        Tue,  6 Sep 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] rfcomm-tester: Use latest Bluetooth version
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166249561529.28899.8499652131121293542.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Sep 2022 20:20:15 +0000
References: <20220902205702.1955891-1-luiz.dentz@gmail.com>
In-Reply-To: <20220902205702.1955891-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Sep 2022 13:57:02 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes rfcomm-tester use the latest Bluetooth supported by the
> emulator which is useful the detect regression related to ACL data
> transfer.
> ---
>  tools/rfcomm-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] rfcomm-tester: Use latest Bluetooth version
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3d3b1ceab9cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


