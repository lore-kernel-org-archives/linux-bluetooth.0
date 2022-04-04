Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05BC43217
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380268AbiDDV2y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379499AbiDDRQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 13:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146BC1401B
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 10:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5716B818B7
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 17:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 773ECC34112;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649092464;
        bh=fPCaoGfYoSgp8fVjVRY75MbNhf7JUeJ+nj5i1DCEfAU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UWirtYI0fwO0nmktlpO8YSwwsPdofpDGbhXdGX46GBJNnj8XZzIuEo07jzKFYVEAF
         YiuKpl/eoiKqjrOtE2e32tSLc3fjNiQilfBImgGsFXBfURbFN0wOTVAWl8ggWHwx5f
         qZkNlEA+FKfwnSCIa37anB4PhmVHtg46k9+KogbDCBgYdMmYOzPEzHz6QiVYJ5HluS
         zOUSXpfeMutgf62igPfr9ulvSdq629v1LXj6SkwoO6skw2WYVf7MFt8ktOJ+Y6C2ls
         iLAB6GCEAmOZ6UFWJSezkW34OCg1VuE4rdO3IA7Y8JBHVm5/BlvaBDlTGanJiD8tu8
         67a86y4F7feLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D169E85D5D;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: Fix g_dbus_setup_private connection check in
 mpris-proxy
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164909246437.14329.15933231413374978148.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 17:14:24 +0000
References: <20220330094740.45637-1-frederic.danis@collabora.com>
In-Reply-To: <20220330094740.45637-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Mar 2022 11:47:40 +0200 you wrote:
> ---
>  tools/mpris-proxy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] tools: Fix g_dbus_setup_private connection check in mpris-proxy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f382885d4a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


