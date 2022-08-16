Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401BFC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiHPXUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiHPXUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 19:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3877333A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 16:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F546130F
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E050BC433B5;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660692015;
        bh=T5wwV48/PgDjpJSiWbA9YEZUIQIAPIioyzH/m1MY6+U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n/N2YlxPQtStrmXev3Bmjm7sElQrlM2NsQwDEJbJmu+Nz4TmnpWrLJdcSCtXWQKvV
         1vYXNfDBj+ZXMMiWskSSMK6l/4MKoH/ax/+K1mvBLJrUcOaI5h+6IX7hUgzIdHZFyX
         ph8b1U9JVQSj1r86yFK6GFWUxJOdTLnfjFttAzNyIvE+2j6ZSamOE5j76XfykaC/NC
         NEngmbt/T3hcgq/Vxnh6hGxib54HWLXWZ9udwLlSegVI+cP2we37Ttz1u2FSn4pmdf
         2VEgel7zY3gHYK7b1NjYuovt5IjgqgidLWFhcLmobOM6shl8dVYUjiIw+NBsPSWfUJ
         3Qp/v+aXKimBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0225E2A04D;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] client: Move admin submenu
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166069201578.20856.12373619528324639655.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Aug 2022 23:20:15 +0000
References: <20220815232631.1275861-1-luiz.dentz@gmail.com>
In-Reply-To: <20220815232631.1275861-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Aug 2022 16:26:30 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This moves admin submenu to admin.c so it is not mixed up with other
> submenus code.
> ---
>  client/admin.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++---
>  client/admin.h |  8 ++---
>  client/main.c  | 82 ++----------------------------------------
>  3 files changed, 96 insertions(+), 91 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] client: Move admin submenu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=64abbf7cee18
  - [BlueZ,2/2] build: Enable admin plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdc788f576cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


