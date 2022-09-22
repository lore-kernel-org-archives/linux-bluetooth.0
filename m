Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395AECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIVVKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIVVKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020165552
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC4E3B80C91
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7092EC433D6;
        Thu, 22 Sep 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663881016;
        bh=jabkHPFsRdv39fU2Hn6sk22X12zJpqmBhr3SXtx5e+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ehloYsQ3XyXZeKvca8otTsuG0r0BxM4+GOsVt23+lxa1OoaBN33Y8QCBv0loQuxnr
         MKeL+f13ba5xXy3HV6UKov+2+8ql+rFgXG2xSCvANWrxFlztUlOSZ2FHt5Oi9cDi/c
         L2W82HKMzJeZWDpJrmAgrE+mOCUuKbIeaLDntorBxAjYO1b/QaXY9u1hArx6rJOseT
         Hrpa0mHIhkTN5S+z6bcJOxfYLBdDnrJQYioXtaUOEwIVQ9bBaQydPW69kCTIdozW73
         hwfNsvt5DSTyAeTfuFbdjn+keOpCOJTt6xcL6oYvS3YHwuWxGR35h4JhROUfeL2+oj
         5zqc+nBGOkO2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54040E21ED1;
        Thu, 22 Sep 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] mesh: Add interface output filter
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166388101633.22480.8585428752520696622.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 21:10:16 +0000
References: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
To:     Isak Westin <isak.westin@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Wed, 21 Sep 2022 13:16:28 +0200 you wrote:
> According to the mesh profile (3.4.5.2), if TTL is set to 1 for an
> outgoing message, that message shall be dropped.
> ---
>  mesh/net.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/3] mesh: Add interface output filter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a76ff5879b75
  - [BlueZ,v2,2/3] mesh: Do not accept publication for unbound appkey
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b72edcc5ca6f
  - [BlueZ,v2,3/3] mesh: Remove RFU check for publication set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9fadca7eba4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


