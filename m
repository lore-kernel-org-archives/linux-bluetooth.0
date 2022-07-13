Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3CC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiGMVaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMVaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 17:30:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902E22526
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 14:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D189DB82164
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 21:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9857BC3411E;
        Wed, 13 Jul 2022 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657747813;
        bh=/792nyPC6YrjUe79m2cJ7mTF6PTa4Ld0sW5V9G1lctA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kqfSYD+q/O0M+B2GHFn17aPC9FOy5GHsvHb9glKVjc2i+ucZ1HjUoV8rn7D84sezw
         nBp9vfpA4MTab570xOYeG8ZNf0bVL8Fn7wqZikEHRHpR4qUpzOxQQJZMMFzY9fyqzm
         O8p2UuI1NYT90zShx8lzHSTeOPlD6bqKQHI4D4d2BpGhhY6ktqxZih8eIm5BmGY6g6
         RF29XeHQgmOnO8Em3cCeUItl04O/EZDcvfgGKCNCF2uy2uIJ10ub+/L+Q9yJ9jM7Jy
         pvvk2CmwTngl0R8fdLH/zVY1elPE0J2K2+nylGuHS2KQHl89LPULDZswcbNZaA6gaX
         FEEB8gWWC/Dkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AB28E4521F;
        Wed, 13 Jul 2022 21:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Fix advertising monitor on Linux 5.12-5.17
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165774781349.16220.9847778229088259152.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Jul 2022 21:30:13 +0000
References: <20220630073958.34468-1-adrake@adrake.org>
In-Reply-To: <20220630073958.34468-1-adrake@adrake.org>
To:     Andrew Drake <adrake@adrake.org>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jun 2022 00:39:58 -0700 you wrote:
> The existing code assumes that, if a device supports advertising monitor
> offload, DEVICE_FOUND events can be ignored since the kernel will send
> ADV_MONITOR_DEVICE_FOUND events instead. Unfortunately, these new events
> were added in 5.18, but offload was added in 5.12. This patch adds a
> check on the MGMT API version so we can process the older DEVICE_FOUND
> events when the new events are not supported.
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Fix advertising monitor on Linux 5.12-5.17
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a69fa692b094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


