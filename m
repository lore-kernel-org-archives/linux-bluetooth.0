Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F50C001DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGQUA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGQUAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 16:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93846CC
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 13:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 315486124B
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93EE3C433C8;
        Mon, 17 Jul 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689624023;
        bh=1H0Z3NAVGmE5MA7pPR1VCh9cuSUjGb13o8FvqJlC+Lk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hCeuYQ24g3/rVP+KXBLmXx+d9iaOyYNqidWAmqZbUEpjx7y0mCJ7hgGLn130aeGRd
         qEVM92KYDE3YKk0ly86QHmsY5J9rqo2A+U7XQIz1nr0l0YWGHV9a34BlvA9wy4YIGj
         sKbspP8jvs8Bi4nFbg5bGfxOM5SPJVsvptTxIDELCBH9IBK4QH+nsiQQSrqAc8SaHh
         5TgtvVF9ovjwmdS9FSrLoINqvxC6hw4UIdU/u3jVegKdW6eNolI4LLdlGTI3/Xtzr3
         X6HSaeOoSU1tqdz9A4NJ7nSNhDwVKqQjHWDv5GEfEWFEgk9eJXOltC67lxAm7zidLb
         mBtI2c4gpWQ8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75615E29F39;
        Mon, 17 Jul 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168962402347.17606.410013759859453493.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 20:00:23 +0000
References: <20230713224239.2286549-1-luiz.dentz@gmail.com>
In-Reply-To: <20230713224239.2286549-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Jul 2023 15:42:38 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes the handling of BT_PKT_STATUS more generic so it can be
> reused by sockets other than SCO like BT_DEFER_SETUP, etc.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
    https://git.kernel.org/bluetooth/bluetooth-next/c/259181ff5785
  - [2/2] Bluetooth: ISO: Add support for BT_PKT_STATUS
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b36a4f78004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


