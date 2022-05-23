Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 May 2022 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiEWUuS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 May 2022 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiEWUuP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 May 2022 16:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A670930
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 13:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1A2BB815C6
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 760E7C34116;
        Mon, 23 May 2022 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653339012;
        bh=4C4lCra+Kr7wKAnZ78PwMWiihB3ea0vrKXhpch/BdWg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eLz3j7bYMlmjynGUc37nrYs0/x81PkTsxcCOH5gDiVq6/1JrfrWMBDNwAK4/YBCd8
         Wc3Ixyyhym3MVp+DTxMtz8d3Gzk6yscNtPpT6WABxZ3E0rGF4hexHxAhR7sXr49N92
         pu9LYramPziZtsxXKrzZGwk4A76pSzkvXJUFB5VsCf/Lo6wQM6/gKzqZpIQzp+7ynb
         QIDJqbG3N99yGht8hqQq+PMsQeQcRhHUZn/a43iivCyWvJZgUAtQC9Vq+TTVU2J1CA
         v+47MxXT/6SRhbfCExy//nuauE8PUCo8GS1BeN6vVWCvwpA/917eQb6ABEtVa3X/0f
         VL7VJ62bhqv/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BE75EAC081;
        Mon, 23 May 2022 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client: Fix settingof advertisement interval
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165333901237.23626.5603720892634813694.git-patchwork-notify@kernel.org>
Date:   Mon, 23 May 2022 20:50:12 +0000
References: <20220520234151.19286-1-inga.stotland@intel.com>
In-Reply-To: <20220520234151.19286-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 May 2022 16:41:51 -0700 you wrote:
> This fixes incorrect argument read when using "interval" command
> in "advertisement" submenu
> ---
>  client/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] client: Fix settingof advertisement interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79fe529d6485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


