Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD3C77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjEVUUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEVUUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 16:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC0A9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D72760025
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0CB6C433EF;
        Mon, 22 May 2023 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684786820;
        bh=VJ+gHYjZApEWCWG0X91Sm3N/8hXzpK+s5ypdsqLyphU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bywhFWG9LQ5vh/aNsp2IfnJHIdWJh32Q+LsxNP5wuAx+96kvcGMXuy0FRCqtPku+6
         C/Vh3FV6n4FaikBvKSQRsWgZ45GUj3guL5Uaz4gpGPiHGqinDIf//Ri4KVKZNLuUoq
         HwF0Qy2gdPbMS6+4FrWD5fvrpYFlgqhOsp9WXKkfjCCxJYfUmTONoYSskPT4mzkgdO
         OGZmJ2hmVSKgKg0efIkpTz62fT0vsOgHMuqosjhkDm6TCzT2C1UJa3gG9e/geNVq6a
         6/VI72CYQ3HPiRo8cKcLCQb2tbpSdJtC5rbOy/RVYeFzOGAg8eEVmc+YQccx1mLQxK
         F3mdnaooXf93A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87362E22B05;
        Mon, 22 May 2023 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] iso-tester: always use DEFER_SETUP for multiple CIS
 in same CIG
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168478682055.7079.605631444073463509.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 20:20:20 +0000
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 May 2023 15:27:34 +0000 you wrote:
> There is a race between multiple connect() for CIS in the same CIG.
> connect() will both reconfigure the CIG and connect the CIS, but CIG
> cannot be reconfigured once one CIS has already connected.  That these
> tests pass currently relies on some timing/event ordering in the
> emulator.
> 
> Connecting multiple CIS in same CIG is meant to be done using
> DEFER_SETUP, so change the tests to use it, so we test the intended
> usage.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] iso-tester: always use DEFER_SETUP for multiple CIS in same CIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a88c74e29b6e
  - [BlueZ,2/5] shared/tester: retain test failure status
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=195b9abbae0e
  - [BlueZ,3/5] btdev: support multiple CIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=678265f37c28
  - [BlueZ,4/5] btdev: report right reason for local Disconnect complete
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c32cfdf9462
  - [BlueZ,5/5] iso-tester: add tests for multiple simultaneous CIG
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


