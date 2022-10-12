Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F3C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Oct 2022 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJLVai (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJLVaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Oct 2022 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D274ABF3B
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 14:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5353A6158C
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 21:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB65AC433D7;
        Wed, 12 Oct 2022 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665610215;
        bh=7z6cihUQ6+A/y2JCNRP5/svwvvo7rD7uJERe50/M/9g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dmv6576dVkqxXI8+OZ8z+a7ogGlN6/4TBupUbKm6Zq9FcJ22FtuGK6TPG+bKqRyN3
         IIEd19vmMJ1n0mFUVCACoaToJV06T3pEoth2p8Ig7t/JHfW9SH5TpaK3JbiL55bXps
         twzdaOKLAI5stFyD1sBWS0C/13xWxjKfNQb2vazVHw9bbe10uoA96VJOLeqVZw6b7R
         CqjcHxL35Nfjrp9CRSL74ikqI5U2+tp2pTuyAB01OufXJBMoNwj8YgDjZ2/cmRjHuq
         TOD8cZ+/W0K64JL1tNfdTpysOFGwox66B5eiD49Rj+ByH1/FAe6Io7JZMjFzeR1AIQ
         P5FoIeHBY2NuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F144E21EC5;
        Wed, 12 Oct 2022 21:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] mesh: Keep cancelled SAR data for at least 10 sec
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166561021564.11682.3846570325729780959.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Oct 2022 21:30:15 +0000
References: <20221011140612.2478-1-isak.westin@loytec.com>
In-Reply-To: <20221011140612.2478-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Tue, 11 Oct 2022 16:06:12 +0200 you wrote:
> When a SAR transmission has been completed or cancelled, the recipent
> should store the block authentication values for at least 10 seconds
> and ignore new segments with the same values during this period. See
> MshPRFv1.0.1 section 3.5.3.4.
> ---
>  mesh/net.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v3] mesh: Keep cancelled SAR data for at least 10 sec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f06473908d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


