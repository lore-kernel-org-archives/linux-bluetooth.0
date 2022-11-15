Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37270C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKOTkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKOTkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 14:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D021811
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 11:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC308B81B32
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75AA3C433B5;
        Tue, 15 Nov 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668541216;
        bh=KZhEvk0SKExAgHD5zOXnDUPGJewXInJMPN0JkXLcj3g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tBr2AhzNYbDkG7e4kxNJxnnPNVGr2ZuqnNwHLcdnLCrwlgAlILYSSlkOV3sHz7RBb
         abZ+IiCcoN+VJz1Vp56Jm3hTbv0+T6FManlTTSVGWYT5H0Aphoa0LJCTOnd7wa0K1K
         P0zdBZDLI/pJfijr8pxDEKqV2g5w0VJh73/8kf8ZqQTLudRyZtadJKROkZp4qZQKHF
         qyh5GQE0YJQCykJHj62COc0qTWZXmLsy/8dIzpGI1KF6x4ohAfSSmFP0IC2kCnasCL
         lHBLAOghBVdRWynu6vCav+2M50lu8wu4BYiA57KHZ6dYMG7beD6NXoKDqMUx2seRTn
         LS9ahdViMAs3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FBB1E21EFD;
        Tue, 15 Nov 2022 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] shared/util: Add iovec helpers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166854121632.14574.14499500619071398604.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Nov 2022 19:40:16 +0000
References: <20221109222947.1137901-1-luiz.dentz@gmail.com>
In-Reply-To: <20221109222947.1137901-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Nov 2022 14:29:44 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds iovec helpers functions.
> ---
>  src/shared/util.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/util.h |  6 ++++++
>  2 files changed, 59 insertions(+)

Here is the summary with links:
  - [BlueZ,1/4] shared/util: Add iovec helpers
    (no matching commit)
  - [BlueZ,2/4] shared/tester: Add tester_io_set_complete_func
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=918c73acb778
  - [BlueZ,3/4] shared/bap: Fix crash when canceling requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7fcd6889fb13
  - [BlueZ,4/4] unit: Introduce test-bap
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


