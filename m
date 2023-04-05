Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF7C761AF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjDETvS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDETu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 15:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E583F0
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 12:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3DA640FA
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 007FAC4339B;
        Wed,  5 Apr 2023 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680724220;
        bh=1xxo+ccts7hxNOy8j5ZncMtaaSSuHxCl1kvQO77lle4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tSElVi7Md7982c3hC7zmoirQpiGFQcbe8G2Cl5J0OqAlA2F3DTHUE7j8YML7bmJJ3
         eUlLd7N31Jbn0J3kYbXhZguaWtNmCdH9YslF50Dcuhk0+q3FAHSbM5T9vEff1lw6j7
         MGk/JIGoefjzPa/GS7pwJYtQEpTPeQJSfH1jFNzZ6jZAhbHS8xJ5tLeQKLU7W7Lsey
         dP8pjFtkgUaathTGgkhX9lGFoqXJWfjB8dRVaKo7Hbgb0ST6+3QzDMSxcfY0JT4eEz
         LNxCfTuD5KvZO0bfcPltGI1f2a+84dD21KABST11yurVOyQw5FsRzZtI4TliP1LzLR
         yQ+RV8Jry98ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF8DDC395D8;
        Wed,  5 Apr 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] set: Fix not attempt to connect devices with RSI
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168072421991.28321.8332933077878359054.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 19:50:19 +0000
References: <20230403203243.1960045-1-luiz.dentz@gmail.com>
In-Reply-To: <20230403203243.1960045-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 13:32:43 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If a device advertising with RSI is only found later after the set was
> already create we shall still attempt to connect to it.
> ---
>  src/set.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] set: Fix not attempt to connect devices with RSI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7aee0b67ba9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


