Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E2AC19F2D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiHDAAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiHDAAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77F810CA
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 824646170B
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 00:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0C2C433B5;
        Thu,  4 Aug 2022 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659571213;
        bh=yti69F0wDCvEbo/DFrPOZlQnA+3X3UjdepWadulbgYo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p8s2AfbPSDO0KcP6ju54B4UkeZscqVgX5WLZUdusLMWIWDv2dkrfrbJb3s0eFScZ6
         hecJbCfyHBtAW0zoQS561G7jPf0OE+TQSQb2HCHY9gyuNoy9dHekBqHx39FFRnZYgP
         7HOMnaZomIok9XUGHIt320rclEOAI5cjAXSf+hJtEbnSMruR6eVip8d2I3suXf/t3C
         Lyq69F02pbwIb0zWnSObxQ92D84in3azMlrbg6jiYAeMa8u+KvBafkrJGsmJcn96Xp
         36tmTOWh/6KBrYJegulE2Ync8sqYYD7B6MGTeI5GLXIOKrouc97KoOlWxa9hcTId4H
         Oihie5OhwiD3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2437C43144;
        Thu,  4 Aug 2022 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165957121379.27811.14942480637593313108.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Aug 2022 00:00:13 +0000
References: <20220801225702.2278772-1-luiz.dentz@gmail.com>
In-Reply-To: <20220801225702.2278772-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Aug 2022 15:57:02 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The patch d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused
> by l2cap_chan_put" from Jul 21, 2022, leads to the following Smatch
> static checker warning:
> 
>         net/bluetooth/l2cap_core.c:1977 l2cap_global_chan_by_psm()
>         error: we previously assumed 'c' could be null (see line 1996)
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
    https://git.kernel.org/bluetooth/bluetooth-next/c/600f1aff2dcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


