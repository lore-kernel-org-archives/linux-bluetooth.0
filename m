Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF4EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGLWuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGLWuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176C1991
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B40E61983
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C738C433C8;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689202221;
        bh=3gbwWLNtrYcACMlR+KmUK/2K/stZWAgnHaI8Q0Wg2fw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SRzoeUC52IprWar/FFO5Hft4TcvBapprl1pgPb5e0EFlKvlUWx+R9ddETV+Tt92Ju
         hSFLK4+eHdr3VfO9ahlT+r0jhvCi7p/vNuRSZ5U8oFfrIDrZhFTFBpHrfx5l8h0RX2
         kCAHUFjS1S1f1meZjY96MIBL6Oo61JjYanfgZ42Q9LSTMn5WymFgJltqM8XjdwvJk/
         kXzqiJ7J41J43qj0fvwm6BA2FofQTEuCOwM6Ncbe65nR2PKNNZElxRS9EVZmO9csZT
         DyCz5RUZYbk70mHEIFfp/zI9SVlQJ9vGcD9B19nKqg65bj5VqIFPuGHBg3Rf/BnZig
         9/x26UQra41rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 575E5E4D006;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] main: Remove DEFAULT_SIRK
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168920222135.32437.8805845261931962159.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 22:50:21 +0000
References: <20230710222014.1231369-1-luiz.dentz@gmail.com>
In-Reply-To: <20230710222014.1231369-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Jul 2023 15:20:14 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> DEFAULT_SIRK is currently not used.
> ---
>  src/main.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [BlueZ] main: Remove DEFAULT_SIRK
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b0087bc3d25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


