Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A00C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCNTuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCNTuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73955B6
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6878161982
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C520FC433D2;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678823419;
        bh=juQijeD2Jwck6eJqp0Bl1OhWvyP+NP56Bi5BWjQHToo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jaZh21QQWVCtX2m2IlVpSqbaF9tE1RAYnu8DYIWML/XP7SsQpAUlfY2yo94s8FRdj
         fjwYqfZu6vHxgQDqhDmmsDoEYU5K1GsTyvdeVjgN3gFrqzTWyzebHnXuhIlUcEFxV7
         tEiTTneu7acXNalsTRuTiYcZ1HFwlCsq4Rsz9j3kH3XYZyLq6rRhOsU/J4m0MSZTFN
         r9HadAuFc0GsiU1m95MkQuGJLwFQurV4B6JkcpxcGTqs4CbyGXZObRZ3Bk+mCSyD9h
         hdMKm3iUdAAm6XRrZKQ21y5GC+vGgnyI9tO+sg6b3U8wjesqs2MmsOgA2TLGFGosEO
         xkYoqgP5nzw5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ED6BE66CBB;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix Locations,
 Context to be PACS not PAC properties
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167882341964.5310.4476031771820978750.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 19:50:19 +0000
References: <3eff7be0f5f2cd5df7585ed2a2dc82bc84ff7f38.1678816865.git.pav@iki.fi>
In-Reply-To: <3eff7be0f5f2cd5df7585ed2a2dc82bc84ff7f38.1678816865.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Mar 2023 18:04:27 +0000 you wrote:
> Audio Locations and Contexts are properties of the PACS service, not of
> individual PAC, as these are device-wide bitmaps and a single
> characteristic may exist on PACS server (PACS v1.0 Sec 3).
> 
> Move the attributes out from bt_bap_pac to bt_bap_pacs, and actually
> keep track of the values.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: fix Locations, Context to be PACS not PAC properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b654b16fb04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


