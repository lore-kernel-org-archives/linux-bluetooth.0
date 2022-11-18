Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03161C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 00:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiKRAaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKRAaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 19:30:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35EDF04
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 16:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490AA622D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A76BCC433C1;
        Fri, 18 Nov 2022 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668731416;
        bh=FX6xQs9kdC4FM+7/oeiLP1B7O1NVirLaV22kZM80Elk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tm29A6eUGWcT6X2ddiO61LSk/yh7H+37yuZmHIeuMi021iWooY3ofSbPql67aQR1m
         +9ykZcRo4OuBZiI9NFKaizUBW0IAHBKKSmftBwYwgb7VVSljSBTHxt5i+Le31Vwihm
         iXvBN+m+LQftHFclGJVsZOUCH9C7laYPFzAUJwzOPZP8Lfwci/W5pdesMxWDunf1/L
         GQLFBf0TfnpgO7HLMIkgxOuv8DwtNproTWSyZyhjkV9yGotlEGDUPlOlDv+W1WGfQM
         y+Yt7XummZ7RM2G+yzm2FcZcl6epoqIItBQ7cYmpqFIotVz/HTjrFkBwqc5YkfNBab
         UJGxyZI4upjkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A2EDE270F6;
        Fri, 18 Nov 2022 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: Use portable 64 bit data formats
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166873141655.26405.7826722217002521398.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 00:30:16 +0000
References: <20221117202150.56236-1-brian.gix@intel.com>
In-Reply-To: <20221117202150.56236-1-brian.gix@intel.com>
To:     Gix@ci.codeaurora.org, Brian <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Nov 2022 12:21:50 -0800 you wrote:
> The isotest executable was using the non-portable %zd string formatter
> for loging 64 bit integers. This replaces them with PRId64.
> ---
>  tools/isotest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] tools: Use portable 64 bit data formats
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=818adf28e518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


