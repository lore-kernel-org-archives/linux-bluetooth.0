Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD5C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiIZSMs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIZSMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 14:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044046FA04
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 11:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E09B61157
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0D4AC433C1;
        Mon, 26 Sep 2022 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664215215;
        bh=r7XU8xPdSdf6F22saznkKOy/4E08/y0HFOuoitwrckk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tZkff7A7UJXyJI62NT47c91AbQKQ/4OrxKhUCGE0WgRI5780bfnvhKSQA2RYvFjV3
         2VvShOhjfdH1CWV1FH8X8T6uIQ6WmQBH+Dm1M/rrusY0qgu9QiinuEO72uoRngNGLN
         ZbvSOmE07FYUBvS8zGwNESarWvCJJiTKjD3wdaVg1PZInp4UhotLjHsVzooCZYI2Pc
         YzBiEX+ep4BmLfdYJSnK1oZOI/2dF1H747V0fndYpcx3b7eA4LwfIueW/KW5uxBup3
         2BRriio6ZiScBe67hhtHamFavTGBEooqPxKNBFXRHi+Ks89epodXg/5LVDe5ZR0nLh
         ePKRDKyduYhNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5C28E21EC2;
        Mon, 26 Sep 2022 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] client/player: fix printf format string
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166421521580.25050.13157139924615559507.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Sep 2022 18:00:15 +0000
References: <20220923105141.20176-1-ceggers@arri.de>
In-Reply-To: <20220923105141.20176-1-ceggers@arri.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Sep 2022 12:51:39 +0200 you wrote:
> Use macros from inttypes.h for correct printf format specifier for
> int64_t
> ---
>  client/player.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/3] client/player: fix printf format string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b07f1f98059
  - [BlueZ,2/3] monitor: fix printf format strings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa8411cf37a3
  - [BlueZ,3/3] tools: fix printf format strings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e01e89179d4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


