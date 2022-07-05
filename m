Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiGERUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiGERUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 13:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A31140B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 10:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F60FB8182D
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 17:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2576AC341CA;
        Tue,  5 Jul 2022 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657041613;
        bh=R/UWVwcDtAT1EQxqaEl97xaRtlwgKH8GQcab+HXHzZU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wd2l9bLsJ6bNy18iQa/e136lYLycGMioT0mhzwlkvUWJdQosyYc1viZ18lPaQ/gPs
         fgq2SlPXg5+5h9EmnjsL0qKYqDdgYiGUkqXg+8Xw2GeQFgTjCxN/HPvI7JhRSjZuV4
         6H+M66oCf5KoKXIyrEKuk977A16v57hfr0E2gw7XTIro92rq5f5F9hSW45KBOG6Jx/
         dgYkfrvvV/FdjCjHl8hgWoBgtUOsztgrhzfJrvbcEQ1otvfh51qou8n7++tCQsR1gc
         2WA8+0SXQkkaEX/i6AE3qJrC/nlLyLjf3aLtyBHrJZk/0+/9hr4rY76rLYoDdcrJtq
         k9nrKMnZ9p1dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F295E45BDB;
        Tue,  5 Jul 2022 17:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] obexd: Fix the code style
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165704161305.3219.2304829682962380338.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Jul 2022 17:20:13 +0000
References: <20220705092952.11868-1-wangyouwan@uniontech.com>
In-Reply-To: <20220705092952.11868-1-wangyouwan@uniontech.com>
To:     Youwan Wang <wangyouwan@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 Jul 2022 17:29:52 +0800 you wrote:
> ---
>  obexd/client/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - obexd: Fix the code style
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=575778a45f84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


