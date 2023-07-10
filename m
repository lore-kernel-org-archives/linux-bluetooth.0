Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15E6C001DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 19:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGJTk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGJTkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A5136
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B39611BD
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 242FDC433C9;
        Mon, 10 Jul 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689018023;
        bh=XG2yZlE6rJL3MtI8Ya/000FGvuaRc6nyOafSzElqYHk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GYultrSkSNtZsPqunvCMQXK3TIXKFbwHmZtavLoq1cYsZ8M838pzw7bMoRmIb1fgf
         AQnPyKqD7R2/eDTrcPAmP+IPaqeDwxyZfKsyGlBRYG2Gh95PVoTeX39UC9KCsVVMFH
         xfZg7RunsRuUjLvTKnEXOufijiwu4tzGUVxoNJgwr6EA8TZxA60dYSwTRqxG85vkl2
         hWTvCe4pHdxXG8P4jEl/79Y693Oy3eEzUQlfmzVc3Zj92whYA4bFR+n92H9JXpvUT4
         nrrV/ix1CHFCisIcVXcOB30KJ2uehFey1Sz1gOB7Xhk3jtwsg8TrNNitQJWvlPyza5
         9FY8xBAvwBWAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03F8DE52BEF;
        Mon, 10 Jul 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/2] shared/bass: Introduce Add Source opcode handler
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168901802301.22137.10039217524697261844.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 19:40:23 +0000
References: <20230629080735.525650-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230629080735.525650-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jun 2023 11:07:33 +0300 you wrote:
> This patch series adds the BASS control point handler
> for the Add Source operation.
> 
> If instructed by a Client through the Add Source opcode,
> the BASS Server attempts to synchronize to a Broadcast
> Source, by opening a btio channel.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] btio: Add options for binding iso broadcast address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da85360a956f
  - [BlueZ,v3,2/2] shared/bass: Introduce Add Source opcode handler
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a8f8c143b18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


