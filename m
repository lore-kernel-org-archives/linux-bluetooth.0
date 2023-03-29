Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD2C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 19:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjC2TvZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjC2TvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 15:51:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E106A62
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 12:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ECF4B82433
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C71A0C4339E;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119423;
        bh=i54eIhAAnp4ZjxJkNU5JYPHYD5UI2CmSqSZNCexMYwk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cFxrIt7INTGetvYL1tNnX+Zn7cxcEdcSBC63aYSTRtBbswxYMPg8k7Ej3JmI07GOA
         dGit41rcmbSgJpndgYn+vJUsfa9h+dyP8a8YtTJK+nA206jBAhYrO0O/Pv9HETVNeP
         tEITB4Z55DfOjg83Il46hzHekw33x7HuyBHEBCQVHeJs6oKmMLWfXDYSzr9zqVe2bg
         1DzLhY70qruv0vHJrwWBx+692XeTwveKdEJtMra4+ECvXPbLcRLiz+pUR2z4L+zbP3
         2JWRWDX3clbsNGOOj5CabF7sh+QoNvlMj4uP9KUwZihtnpCkEmsoesLNW9iS1OENSt
         bhpUZLWNwtyNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B13A4E55B21;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: Add LE States quirk support for
 Intel's new generation controllers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168011942371.31352.5868882207583254682.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 19:50:23 +0000
References: <20230321043310.79085-1-chethan.tumkur.narayan@intel.com>
In-Reply-To: <20230321043310.79085-1-chethan.tumkur.narayan@intel.com>
To:     Chethan T N <chethan.tumkur.narayan@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Mar 2023 10:03:10 +0530 you wrote:
> Basically all Intel controllers support both Central/Peripheral
> LE states.
> 
> This patch enables the LE States quirk by default on all
> Solar and Magnertor Intel controllers.
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: Add LE States quirk support for Intel's new generation controllers
    https://git.kernel.org/bluetooth/bluetooth-next/c/5b23f8375a36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


