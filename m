Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C541FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGLWu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGLWuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3F1BE4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3C861985
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D3B7C433CB;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689202221;
        bh=/9Mtq6S7+1xtBYfd9py9EXhpMIpEac/u+6KNlhTM+eM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lMVxkLyFDyKeqguPegXStlRJL+wI/SjVVU+Yre8aDbTRAFrZBM3ybmHVeP8QskuRP
         QuDzQOpZlirvrLiieynGVT29WG7wpWQuiIh1cyCfUkoV0XBLCPq2XXVSecbaiIJPCx
         LbCKEINUiU1gociFjZ17HJ+OW0WwnV/r2RxiLd1J3HBumrap6GxbeuK9wYclPGoBRt
         +MKNnVjERBXwjdLWxGpDhoZYO4jd4dAfQ38y2v+n27KonKnhf6Xy7vPxDeL7ljNBwl
         3Wa7476yYZphZ3Vt7dC1vnZAkc6Waguamhp+xHIxEGaMOB/DNhB4zTIgqkK0CiPRJW
         hvbwIVfXdpKEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68A56E52508;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] configure: Fix check ell path for cross compiling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168920222142.32437.8791264843870601970.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 22:50:21 +0000
References: <20230701041252.139338-1-rudi@heitbaum.com>
In-Reply-To: <20230701041252.139338-1-rudi@heitbaum.com>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Jul 2023 04:12:52 +0000 you wrote:
> Use of AC_CHECK_FILE prevents cross compilation.
> Instead use test to support cross compiling.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>  configure.ac | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - configure: Fix check ell path for cross compiling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c62a4cb55183

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


