Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A74C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 21:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiJFVAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiJFVAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 17:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB39D527
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 14:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7B5FB8218D
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B8ADC433D7;
        Thu,  6 Oct 2022 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665090017;
        bh=iQeV/HqFZBkL2Lil0DvlurwLOtPGEIrTIEFnEi1RQqs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hQW3ORVFsnxNxiaXFg0di6htwjqGiulTgUrQzienQwO02PtQjQ5gdjt+oUOvftkMI
         CJttpvc2oRZmGaYXYFUwG9MuOOkczYrLwugZRo50+R3weQQyBXfjvCd2DkJ9zibYtp
         u+q5jRoOF18+mBkDr0TItHFbe6S6KXAGfx/yvZdDhMgk9OoEnM/tzDYAsm2jqfkDjY
         toJfN1Hox0X7hJbT6Xx+/xglVXueBH6W3DN/ObE4BLBhttXS0hX1ivuP9mvu1ijJqr
         Ivtby1mjMBCD09CY6hE2LSgWVH2//x7UAfaVpT3I4YiD1SVEVyizBTqv2YYpYVXzrh
         4H+Jd5LHfb+SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4192DE43EFB;
        Thu,  6 Oct 2022 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Mesh: Fixes for friendship procedures
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166509001726.28080.9031485319390742909.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 21:00:17 +0000
References: <20221004082530.25719-1-isak.westin@loytec.com>
In-Reply-To: <20221004082530.25719-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Tue,  4 Oct 2022 10:25:26 +0200 you wrote:
> Hello,
> 
> Here are a few patches targeting the mesh friendship behaviour. Found
> during PTS testing of:
>   - MESH/NODE/FRND/FN/*
> 
> Happy for any feedback.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] mesh: Correct size of friend cache
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9a8e884109c
  - [BlueZ,2/4] mesh: Verify padding bits in Friend Poll messages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ff3e10d92ba
  - [BlueZ,3/4] mesh: Queue a friend update on IV Update change
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f3a7b8e192f
  - [BlueZ,4/4] mesh: Always relay messages from Low Power nodes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c89e9c4b22b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


