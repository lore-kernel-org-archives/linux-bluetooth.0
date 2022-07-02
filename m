Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGBA3l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiGBA3k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 20:29:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05558FD6
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 17:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D6E0B83266
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Jul 2022 00:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F911C341CB;
        Sat,  2 Jul 2022 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656721777;
        bh=YP6ZQnDP/WGaxg49IcOOoTPm7tYg54Y1rnYaWV6afU0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H1GQvbQAyNrPQnSXmVyd0eeU8PEwR08mt2K2YU0+zcpZ5EUC1h9iRLsuSO/qaHASf
         rHbINJV17sdCxw1iGajsXIWlE/0K/skwNe/NUZWduIBcp+NDEbMUEsBq+CLlNz8LhX
         /4+a7SwMjLqZZnxtRCSIMTOLEiDHtYbgzYDEV7clFfiyaQRb+vK0y5k8SU9MCMilcf
         WI9Yq0QmObsXuTjmtqJR4vmo2zMC37rE4uc/EfVyBw8M0cGCk5UlDpbvIQzvRoK9AB
         D2EEOnFlDaugpJPHfIPopnZ2yfl9xa4QZkz5sZri1vidT/wwrjzrwlqUlbEMzn3KTJ
         gQaLjWMWcWWCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CD1FE49BBF;
        Sat,  2 Jul 2022 00:29:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] tools/btmgmt: Fix errors reported by scan-build
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165672177704.15137.7822022272106359994.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Jul 2022 00:29:37 +0000
References: <20220701004352.2253107-1-hj.tedd.an@gmail.com>
In-Reply-To: <20220701004352.2253107-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jun 2022 17:43:51 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch fixes the errors reported by the scan-build.
> 
> tools/btmgmt.c:2699:2: warning: Value stored to 'argc' is never read
> [deadcode.DeadStores]
>         argc -= optind;
>         ^       ~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] tools/btmgmt: Fix errors reported by scan-build
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1f0b1a747bc
  - [BlueZ,2/2] tools/test-runner: Fix errors reported by scan-build
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dd12ff1ed1f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


