Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFECC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIZUU0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIZUUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 16:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67533F337
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 13:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F082B80B96
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB32C43470;
        Mon, 26 Sep 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664223616;
        bh=jRNO+hZkgpcg5CSl0IV0yQZTvQxse2sooOMpOu0XAxQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ri+hg1HOE9xrcyU9U4vzqxFKKlAvy1g7ldxj78ZP8bxcKafsuBaAzMWhKsDYcjClV
         kKxjze83lwsh4G2pzumtpOxskvx+MDeNl1rL4jxNM0yCetoI+o3q5w5JVGRt2UYD3T
         zETnG50ocNDR3xBzHy+07L6M61W7hVuc/ec4WJBwtPrQfW/eVZfHC4i1xVFjfn/Jqc
         2L7j831KOoEhSiOivShpx6tIIXTW+L5VYwa5D3Ngpuz5rKP0g1vl0z9JrJiuuFw5vx
         Q5MA/OLDucn90PL3vKCiU0YZJevNesZZ7f/evtK7FN+i6dtdzFmtYQ4YpX+gt4H4+X
         gHRpmYPU1KgbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F12BCE21EC4;
        Mon, 26 Sep 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/2] Mesh demon switched to using kernel Mesh MGMT
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166422361598.9012.17342942678830979726.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Sep 2022 20:20:15 +0000
References: <20220923180018.815614-1-brian.gix@intel.com>
In-Reply-To: <20220923180018.815614-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        inga.stotland@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Fri, 23 Sep 2022 11:00:16 -0700 you wrote:
> This patchset enables the mesh daemon (bluetooth-meshd) to use the new
> MGMT mesh opcodes and events to send and receive Mesh packets. By
> default, the daemon attempts to enable the experimental mesh
> functionality, and query the kernel for active mesh support before then
> enumerating the available controllers and selecting ojne that works.
> 
> If no kernel support is found, it will continue to use a raw HCI socket
> for mesh support.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/2] mesh: Improve PB-ADV timing for reliability
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=491be481a91c
  - [BlueZ,v5,2/2] mesh: Add new kernel MGMT based IO transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9966cb8b6999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


