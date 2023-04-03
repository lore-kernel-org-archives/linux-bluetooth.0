Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB0C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 20:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjDCUkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjDCUkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 16:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D740EF
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 13:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A91562ADE
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 20:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C21CC433D2;
        Mon,  3 Apr 2023 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680554418;
        bh=wEMRXJynzV3M6kq8oJfFGHdVm+mDrAglMz3q3gvCM/w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IRariqjqgSZdQHqUOa4YKzYbGRNPx50gtyCCdb8AK9OQoMOa1EsrrJ73ij7UmuOKX
         jq9UC5x5PkQrJtrNkYI9F47lx371Nfn2FRbRCPTXehY6Kzxvhcc3icl3fFQt58deYf
         WY3O0VgCi65i+oldh3WRbRHT0WBNzAwjrhMyzePLLEP0EwEGe5VEefSbQtxT9HEQhK
         rpG23Vhu659j0WWKfht3VjPDpYFX5/uO5TX9lNcfV1JWwJDAey3TPp3hJCzpMtdw/z
         TaqyuFrutezMU7g9cOlvuYNGSQXZyJkvez98aKWKOSQJqWTDSjyKpyE31Nv1WZtkoh
         BS2uvfcHpHBXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6077AC73FF5;
        Mon,  3 Apr 2023 20:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mesh: Tighten IO and fix out-of-bounds array access
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168055441839.17342.11345686919808933560.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Apr 2023 20:40:18 +0000
References: <20230401001602.4161-1-inga.stotland@gmail.com>
In-Reply-To: <20230401001602.4161-1-inga.stotland@gmail.com>
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Fri, 31 Mar 2023 17:16:02 -0700 you wrote:
> This fixes the out-of-bounds array access in mesh-io-mgmt.c caught
> by address sanitizer. Similar fixes were applied earlier to
> generic and unit IOs. With this patch, the common code is factored
> into a centralized location.
> ---
>  mesh/mesh-io-api.h     |  7 +++++
>  mesh/mesh-io-generic.c | 70 ++++++------------------------------------
>  mesh/mesh-io-mgmt.c    | 56 ++++-----------------------------
>  mesh/mesh-io-unit.c    | 30 ------------------
>  mesh/mesh-io.c         | 45 ++++++++++++++++-----------
>  mesh/mesh-io.h         |  2 --
>  6 files changed, 50 insertions(+), 160 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] mesh: Tighten IO and fix out-of-bounds array access
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cffd5832a52c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


