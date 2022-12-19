Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 20:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiLSUvr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiLSUvQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 15:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89112AC3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 12:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15DDA61169
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7121EC433F0;
        Mon, 19 Dec 2022 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671483016;
        bh=j6FCh4ezMivVpkhc1k5ftBikW2G9UsZV5DRwmyDvJRw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=El7jnVs4/PG1TRFmK1JidUJx6dLU9T9rTFliKx6rZz43W0kw+67q77uqlbvdMKFxz
         4d1tjrzU8JgQWC+H01FVidZdlz4Fg9NCQfVDsIEHQuaowB0mc3ZNIW8ZpBpmHVd+qS
         uBXOMuHDkai9Uv0yyGhQA2zptc8EL060AbKihTn/yWUyEhypf0oEyUIiefnkcZuBw0
         JfMiV02Kp8+F0EyzUFkpFWYyIdJhmymLBvOJrUW1Pun+Y/4Ewy3IRWbe8q2Bnp/PBC
         AoQm1DD7iYaU0WqoTdCPFaAsGvSLjIcpUA1THUN6C22T6dApPFt2JSb7dWEgNODBDt
         XCh8fwXtBF9ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54579E29F4C;
        Mon, 19 Dec 2022 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/2] shared/gatt-db: Add
 gatt_db_attribute_get_service
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167148301634.14818.13991356327697319132.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Dec 2022 20:50:16 +0000
References: <20221217011059.3087848-1-luiz.dentz@gmail.com>
In-Reply-To: <20221217011059.3087848-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Dec 2022 17:10:58 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds gatt_db_attribute_get_service which can be used to get the
> service which the given attribute belongs to.
> ---
>  src/shared/gatt-db.c | 9 +++++++++
>  src/shared/gatt-db.h | 3 +++
>  2 files changed, 12 insertions(+)

Here is the summary with links:
  - [BlueZ,v4,1/2] shared/gatt-db: Add gatt_db_attribute_get_service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b91d9213d951
  - [BlueZ,v4,2/2] shared/gatt-client: Fix not removing pending services
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da203f5dbc7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


