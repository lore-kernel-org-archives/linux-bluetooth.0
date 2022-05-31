Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04901C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 19:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbiEaTup (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 15:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbiEaTuO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 15:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537F65D641
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 12:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24CD61240
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 19:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 447C0C3411D;
        Tue, 31 May 2022 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654026613;
        bh=CPvTqG8AMkALWfIa5cwpr/aaA2Ta/c+AGyKIU9ZfZu8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LuiAl1kwq9/tvimNbQLK5UbIKmiq4u/Vqm4WQQAXgwSIoUcvIv44Pnn9PzxbkrKmY
         Yi2W9W/aSenXNFffRMeL00cHmxAjwwWhcjQ8icMj/3We2uDqBB7uFZ/+gmv1bjQsF4
         xIH9xI8c1I2I3fRv52knK58sqyvgX/lw2O9GTK1qXUrHOj9kRdgBSgPtADMn4DHkVs
         YEtcj7U7qLRbWlg8/FVbwEdI1jabYbcaSeFo2Rq3NDz+kr8XeNDmBg2tBFuQYm3GWa
         wL3nuDZr4s2Ca2b0OkX2Kpg8GrFCVRsR6bdI4YxX75mkR+DVacmq7DULljiUP/HC/d
         fvej1scSOM03Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16703F0383D;
        Tue, 31 May 2022 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] monitor/att: Simplify CCC decoders
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165402661308.30362.3123093055341094283.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 19:50:13 +0000
References: <20220526205937.4159665-1-luiz.dentz@gmail.com>
In-Reply-To: <20220526205937.4159665-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 May 2022 13:59:34 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This simplify callbacks moving the decoding of the value to
> print_ccc_value.
> ---
>  monitor/att.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)

Here is the summary with links:
  - [v2,1/4] monitor/att: Simplify CCC decoders
    (no matching commit)
  - [v2,2/4] monitor/att: Add decoding support for PAC Sink/Source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=13bdb9f3bee1
  - [v2,3/4] monitor/att: Add decoding support for ASE Sink/Source
    (no matching commit)
  - [v2,4/4] monitor/att: Add decoding support for ASE Control Point
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


