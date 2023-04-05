Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A9C761AF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjDETu7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjDETuj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 15:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E287D8C
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E177640FF
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8546C433D2;
        Wed,  5 Apr 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680724219;
        bh=N/ccQD1NYaj2cVJVaUVHa6puJrsKAIvY8kPeI/cA8Zg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e0g9Z22egXzsw58u9dYz+ELAE0iSqmIUgNE9BhrGAXQMT3kQZQBeOKCmBvCQQNzBx
         QpKMYiaJ/1uafwvAzmh+158AbGfyF6U981ww8+3+jvX9YDohdWO7IM6WbMZ5/t+OvR
         qxyUccbUSca8H8Hq1YNCRkLsxYGaam2LQrOoQyDhYNCxmqzE+awB9nQPZQbSxKSFZQ
         YJEqoMCnjLamsJU8mxtay4aRkHvlZQnmg80p6xcmkYbvNgFWPQ/W1kFsgzHGy0PUOR
         WtJh30a1rU/UGjhVDUH3KwVMid658Rd/dUqco/G21+ubKxa2LKGiBsJWIhNZ4pVfnc
         AJN0BDJ6L4aLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D64D1E29F4E;
        Wed,  5 Apr 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] monitor/att: Add decoding support for BASS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168072421987.28321.1878400837564538119.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 19:50:19 +0000
References: <20230405105442.14281-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230405105442.14281-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Apr 2023 13:54:41 +0300 you wrote:
> This patch adds decoding support for BASS attributes
> 
> Iulia Tanasescu (1):
>   monitor/att: Add decoding support for BASS
> 
>  monitor/att.c | 464 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 462 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] monitor/att: Add decoding support for BASS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61971f026466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


