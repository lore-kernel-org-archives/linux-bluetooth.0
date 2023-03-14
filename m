Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA305C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCNVkd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNVkc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 17:40:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8610AAA
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 14:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 08E13CE177D
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 21:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33840C4339B;
        Tue, 14 Mar 2023 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678830018;
        bh=cf5J49+3VRik6lh01z7+LTqXMwSelfyxSCXPdFpwgt8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qOePswve9Gtfie8GMPwuq8GNCJktHAWXZq41Zhm8ABgVcFVVutuP9sS8dOLowmyXW
         yhHuwKeeh9q7W0WnHMrI8tblkB4Vh6b3Rp+tPrYgSh2lsNoRSapdkykfQJtd4nsNpJ
         U6fJEuc4PSSUwma3unMKTttp8RG2cfmrG66VKgpCDa/WGB9Y5MNFcTGr5PVuvHvjRw
         MFeewMMF6AbtfXGgwgRcQTaFzgfInsCW16O4jiM11ZfMjY0vc6rKu2hSx4+RGrSg5E
         v/gTY8QlgJ44hTwExpkoQQhI8aRalkEV+nQsM0Pwna2pe+4QBR30VjlLO1TCMgx+zA
         HpEEKDM/zfV2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1122AE66CBC;
        Tue, 14 Mar 2023 21:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] mesh: Fix uninitialized memory usage
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167883001806.25944.4701946410337864742.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 21:40:18 +0000
References: <20230313231152.59147-1-brian.gix@gmail.com>
In-Reply-To: <20230313231152.59147-1-brian.gix@gmail.com>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Mon, 13 Mar 2023 16:11:51 -0700 you wrote:
> When attempting to cancel an unknown Scan request structure must be
> NULL initialized.
> ---
>  mesh/manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v3,1/2] mesh: Fix uninitialized memory usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5934f133d44a
  - [BlueZ,v3,2/2] mesh: Loopback unprovisioned beacons
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c0fb2fefb6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


