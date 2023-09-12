Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA88EE3F0C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 19:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjILTKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjILTK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 15:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BDE4B
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 12:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6596C433C8;
        Tue, 12 Sep 2023 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694545825;
        bh=ug4Aq3F6dG7gah2+WB72zLbVs8UTSFg6+IXiW/arsmE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fLILdd01y/oJB/yyT4XH2kMB+ybjVq6kdozgGLpG0+8JLsTI5rVMaDXsh1rklH7w0
         NYvIIne08ztrjhJkrTF4WTZemjHmcGHrBjYC6VpahC3mr/cVEhdtuso6n7t2beU4Ub
         ozwB5C8sVz+7o5g1Y2ZGBXeTvOs2bST+Fg8/XoJlm9CNTnszQLOmsLVrZxy9Rfvcg/
         u2RoJwA2hKK+btheFSZJZccf2IVjnqS1jpvtR2jvuNZVgTbYEHNEuINkvBk4dhUig9
         GwMEq48OUV816JJOVFvEJNyYMzljudE6M+y59AwMmue7d8Rcsmz0IG8+nDxCIpXCKY
         ndsCCw0V603PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D662E1C280;
        Tue, 12 Sep 2023 19:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS
 support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169454582557.26244.7964252860681748380.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 19:10:25 +0000
References: <20230912063329.1196184-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20230912063329.1196184-1-vlad.pruteanu@nxp.com>
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Sep 2023 09:33:28 +0300 you wrote:
> Currently the CIS bit that can be set by the host is set for any device
> that has CIS or BIS support. In reality, devices that support BIS may not
> allow that bit to be set and so, the HCI bring up fails for them.
> 
> This commit fixes this by only setting the bit for CIS capable devices.
> 
> Vlad Pruteanu (1):
>   Bluetooth: ISO: Set CIS bit only for devices with CIS support
> 
> [...]

Here is the summary with links:
  - [v4,1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
    https://git.kernel.org/bluetooth/bluetooth-next/c/58093c0b14a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


