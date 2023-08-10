Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FCC001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 00:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjHJAK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHJAKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 20:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACDB10F5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 17:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6827C6422C
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BB1C433CA;
        Thu, 10 Aug 2023 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691626223;
        bh=4j4sQCxNAtnFEgnDlfIlSEEwhVClq6AiAeCb43gFEQE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QhLIVs2WDyJKrPEvwWrGuL39N5vQ0bdJc0qLHycx24mMch7nepk7xDjfahuPJH/qg
         ZaKdMUK/DuuL1HkLBqadLRTOwfHMrgozwJ3K5jpMtkpP7uQW54gtRUFneANuxkiNtN
         WDCc+O6KyJxs79FFhk7ZNFyULmyMDPYweQfeBSe55k73Cn3Fp4vrrCF2a5uvwREqwT
         aNsKa/iTBXKeuNY/u0c3Flce4bwidGaMf8LL/DR/wgKRs8LUwh3jEXvw/J/JG00x1v
         AAz0dLaVMGTaIk9n0OtTXrgHSDE5GV42G0fTKGmQhMVw3xnL3+x/bVPvNr7e7+fp7R
         uegJu1qz+ZqmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0425E505D5;
        Thu, 10 Aug 2023 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] fix writes to attributes of size 512 
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169162622371.3909.9864804498327871801.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 00:10:23 +0000
References: <20230809202724.15429-1-bart.philips@inspiro.nl>
In-Reply-To: <20230809202724.15429-1-bart.philips@inspiro.nl>
To:     Bart Philips <bartphilips1@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, bart.philips@inspiro.nl
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Aug 2023 22:27:22 +0200 you wrote:
> writing attributes of length 512 fails, although the Bluetooth spec (Vol 4, Part F, 3.2.9) states that attributes sizes up to 512 are allowed. The check_length calls in write_cb and prep_write_cb in gatt-server.c currently pass the length parameter that include the handle/offset length and therefore fail for attributes of length 512. This patch subtracts the handle/offset length before passing it to the check_length function, allowing writes to attributes up to 512 in size.
> 
> Bart Philips (1):
>   fix writing attributes of length 512
> 
>  src/shared/gatt-server.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/1] fix writing attributes of length 512
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8bf3a4a265bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


