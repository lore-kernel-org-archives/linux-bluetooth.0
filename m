Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB84C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 20:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjC1UuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1UuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 16:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB05B1721
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E4461957
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 20:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CDFDC433EF;
        Tue, 28 Mar 2023 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680036618;
        bh=xiQxJedCG/a9OaKMxhOqzt1bff2lwc0+wo/sGFSMRq8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RNoi0a85fvTTK+N+lgWrT0Rnno94O0GtmuFMygxNwsTZyOsTHbeTuPDL8ZokUil4T
         2+QL1JgMkQ9Bs0oEi+HV5bSB823RIGX/9kaRCngAY4XRZUCgLkm9ZTMRIEl9K1gqJn
         BElJhQGHuSllcQvXkxX3lHj9w8ruEOby+sYI3bdRS3LH2/T1xB7bXl0wEMWnI260Sz
         iuuQwtWObo/GjypFEMKwtqluKnJdJZbrzgXmlDqPyzCfNK9uq4z41JHrDaYZDScd7a
         hDfflPSwxjxf9lCumuTlMkCzmb3u4ss7KiBPY55MktYrT6pGf/GDGN/yKHWUrBmweI
         JZh6Q6sdeluaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A097E21EE2;
        Tue, 28 Mar 2023 20:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] l2test: Enable hex input for PSM
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168003661843.8805.15121337504355290538.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 20:50:18 +0000
References: <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Mar 2023 07:26:17 +0200 you wrote:
> Thanks for review. I'm sending updated patches.
> 
> Simon Mikuda (2):
>   l2test: Enable hex input for PSM
>   l2test: Fix setting mode for BR/EDR l2cap socket
> 
>  lib/l2cap.h    |  2 ++
>  tools/l2test.c | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] l2test: Enable hex input for PSM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cedace72c3f7
  - [BlueZ,v2,2/2] l2test: Fix setting mode for BR/EDR l2cap socket
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


