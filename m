Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BFC19F29
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiG0UAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiG0UAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 16:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5054AF3;
        Wed, 27 Jul 2022 13:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0356261AB8;
        Wed, 27 Jul 2022 20:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A682C433D7;
        Wed, 27 Jul 2022 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658952013;
        bh=UxQCmQgCBS41J+VfE1yxZmGxSCURxNo7yitwUrUQf5c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RBRWSELlAG0tImpOz4BXDoMUVb51uLZqVe4Xp8GrDqy6Hc6qs6BKtmRjyz7ys9oRQ
         4d8fEtHJsClcNnRO22ayQfMkqR93ww9X4Go4SNoXbXiiF86jfqsEjiik3qyhtEX1dN
         vf8NJ0LE+oA3eAlguap3A99E5rTB4JygWIh7OnhdQpe7fQMBKIt285C55PRl3G9Fm7
         cNLyBRMv1qLQmzs3rG17fPGk5IW85/pcc3oL67/3ctmI197CboFe1ffft4AGUiUhc4
         cw/QQgaRA341Uw11cmS0r9gYUfXzqa7lhZB7GL5fRBzl4YaWl/c5E+Zem7oMDICFpn
         eP9qKYOrJWz5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 425B8C43140;
        Wed, 27 Jul 2022 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: ISO: unlock on error path in
 iso_sock_setsockopt()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165895201326.1016.3387322911297502466.git-patchwork-notify@kernel.org>
Date:   Wed, 27 Jul 2022 20:00:13 +0000
References: <YuEq2Aey0VOrxPB+@kili>
In-Reply-To: <YuEq2Aey0VOrxPB+@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Jul 2022 15:08:56 +0300 you wrote:
> Call release_sock(sk); before returning on this error path.
> 
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/bluetooth/iso.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/2] Bluetooth: ISO: unlock on error path in iso_sock_setsockopt()
    https://git.kernel.org/bluetooth/bluetooth-next/c/13474ba176c9
  - [2/2] Bluetooth: ISO: fix info leak in iso_sock_getsockopt()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


