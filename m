Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B74C04A95
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIWRaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWRaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 13:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D891DA9
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 10:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2AEFB834A5
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 17:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C73C433D7;
        Fri, 23 Sep 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663954216;
        bh=zBqwKTJj+JLpZHegsAryIJnouuUcrgzpCK6JInuwWn8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fltdZagxfChttNKVeEl3rfXE8lC2nl+XtATsWr9oRQbeT1HwBddwjaZFDickwTIvI
         N29sho7sfvf4Pv/bUkekpLMQk3rElQ4d26Pbqxzw0ROhbVduw/wDlrWOerq62CkAh9
         xvKNzATm9KM2X3H9e7F56oWlBxZTq/nHWMOfnFCG+T2JHhrumxbWzYRc9PECmxMl9c
         jZFALDERbwO8Znn7GbrWqoegdgnBcRWV2inM+Kp6aGS6LejQmxVc03np98XdiJrpPH
         0INBMb/TozPHtg7OhWEy9Swjjx2DECOls/8TSWPKb00kaHgNRPUBn8N4t+6WPNWYe3
         hx6qBbnm8hXvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64C1CE4D03A;
        Fri, 23 Sep 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Mesh: Fixes to comply with mesh profile
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166395421640.11441.9559011289039831426.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Sep 2022 17:30:16 +0000
References: <20220923113149.14209-1-isak.westin@loytec.com>
In-Reply-To: <20220923113149.14209-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Fri, 23 Sep 2022 13:31:47 +0200 you wrote:
> Hi,
> 
> Here are two more pathes to fix compliance with the mesh profile and to
> pass following PTS tests:
> - MESH/NODE/CFG/SL/*
> - MESH/NODE/CFG/AKL/*
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] mesh: Clear addr field if virt sub failed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32d866b4df92
  - [BlueZ,2/2] mesh: Reply error if appkey added for wrong netkey
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95d9dc6764fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


