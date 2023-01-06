Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C1C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjAFUAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjAFUAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Jan 2023 15:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F49831AE
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E34B81E84
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07AE2C433EF;
        Fri,  6 Jan 2023 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673035217;
        bh=bhjZSIEKqtgvJAF1402cSOE/b5HsM8mt34HOI95XSew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SSQUvcEpmmN70qBXJ+oQJtQH2NJKIGLvfit32v3mcOlM71VaD6S/HRcNKpjR/+YFy
         3YQKIyrOqaMtcHURWP/iZ8+rkJ6UIoLLw/oXuhODqyRlKLXNn+H3hDnHuG0En5sO6i
         J98+zA+LledajeB6olOU/LGOIMCxhVc5xFWLcdIudJoAtLVIbzIfgUE8NFzTy85t6N
         sI9zcCSHZqsMrrneoj/hgyiit5ZQVnYlVJBZjfKX/nwx8kQmDgjg4XN8UnKfMKXwAi
         bK/2R2pxgMl9X4gQAFOjgunjWtbhKNL7IoV//qD+VNtxaR57Xb9v8J1Yy0wYI82+bN
         PiXz6NsbUDgZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD75BE5724D;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix smatch warnings
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167303521690.6339.8901546993775002756.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 20:00:16 +0000
References: <20230106003729.2526075-1-luiz.dentz@gmail.com>
In-Reply-To: <20230106003729.2526075-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Jan 2023 16:37:29 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warnings:
> 
> shared/gatt-client.c:2764:33: warning: Variable length array is used.
> shared/gatt-client.c:2994:23: warning: Variable length array is used.
> shared/gatt-client.c:3075:23: warning: Variable length array is used.
> shared/gatt-client.c:3514:23: warning: Variable length array is used.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt-client: Fix smatch warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c18e3bf92e04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


