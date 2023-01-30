Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C2C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjA3Vkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjA3Vk2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE714EAB
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 13:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30CCCB816A0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D543AC433EF;
        Mon, 30 Jan 2023 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675114815;
        bh=ZwCtPi+m2sWu2GxaEmHo+Y+2Fw7aDDsGBclQ/cU2rLk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=awCdOLU7NjEUw+JWYITHVROgiuJbzPEc+z4krdVMntDkpEk4U4Zm9kpRyb9UpJMgd
         tRP3wPEeMhZnZ2YfGh6y9mGtXrIAd01aFHzgSz5UKUQfJrQP7cSw/xl1FP9BjOR0xR
         bvQAfLl60TgLIQVndhv2dJHMIErSIzNSsOtLNritfxQh8AdfqkLKqcYEZ4uWIfoeWU
         FC0oQQY5XoO+yC5ifMUWYCGhWUv+k3zKEZItT+NqYvl9hnbF9M1bt/QgaLdEwv5E/p
         rTT+8AUbpc7K/GM93Y09ezbzoC3Ep3o7vYWiqamt+yMpF3tVv2pkhjdDxErkLFKyI4
         2Wb5+XgUTUKsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5346C16ABD;
        Mon, 30 Jan 2023 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] monitor/att: Fix Set Member Lock decoding
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167511481573.2348.9357492996943626532.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 21:40:15 +0000
References: <20230130091336.19098-1-marcin.kraglak@telink-semi.com>
In-Reply-To: <20230130091336.19098-1-marcin.kraglak@telink-semi.com>
To:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jan 2023 10:13:36 +0100 you wrote:
> According to CSIS specification v1.0.1: "Allowed values for the Set
> Member Lock characteristic are Unlocked (corresponding to the
> numeric value 0x01) and Locked (corresponding to the numeric
> value 0x02); all other values are RFU".
> ---
>  monitor/att.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - monitor/att: Fix Set Member Lock decoding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f367fa3c9fe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


