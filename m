Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC57C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiF3UaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiF3UaR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489442D1EA
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C49B82B5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 20:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9690CC341C8;
        Thu, 30 Jun 2022 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656621013;
        bh=DNQk/vxcz1E2+3jXR1Zjp4OnrfZIdxD3H3FPAhCpa+A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mmMOVOV/uF10LiSlGUzQJMeeZJldWrBJ2AX1sc7LbFSujeKNzpPWFv3LEdqO3EkXW
         OAla7dniZl0eG+/dPH2/S/xoG2L6mJXc/wvP2tFlUIe3MQog99Nz1vfL4fPKeZc1xG
         faF/jAWSkhNFpQxvHGn3fv6XEBm6tzrI/v7CJz73JA8GhAZ1+P9bxVsQU17z4zhq3A
         dAApc9UhwFXXpH9r/2EhzSzryk8080fUZCQ1KW8Al733ZOaBDfkwhKvkHj0GS938hM
         dim8BXrqGYRmXtI6kP0bH6CGGrturcwkRjCElaQlPqmn3M9D72f5G65URUNbb0Hd8y
         PnU46LQBOV2MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F4C1E49BBA;
        Thu, 30 Jun 2022 20:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] mesh: Use correct net_id in ctl_received
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165662101345.30460.6134404687466381568.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 20:30:13 +0000
References: <VI1PR09MB42395E20CFD614E52F3BC496E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR09MB42395E20CFD614E52F3BC496E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
To:     Isak Westin <isak.westin@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Thu, 30 Jun 2022 09:29:18 +0200 you wrote:
> Hi,
> 
> I had an issue that the mesh-daemon local node never responded to friend
> requests from a low-power node. After some debugging, I found that the
> net_key_id passed to the ctl_received function was always uninitialized.
> It seems like the wrong variable was passed to the function.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] mesh: Use correct net_id for received CTL messages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be7ebf29b370

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


