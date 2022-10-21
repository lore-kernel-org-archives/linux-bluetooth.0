Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F99C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUUAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJUUAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 16:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014A108DC5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 13:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB3FB8288C
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 20:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A18D1C433D7;
        Fri, 21 Oct 2022 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666382418;
        bh=YOtE2oME4iAlUE6TJjjO7uzD1h9GD6nrqwOUh1kxDxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vEBhNdpFqCMcBUX/QMDZ82ts6yWcY+XcAAT9fwGtcn2gPesJNex3f2JQRyu/ef06X
         s4/hmbAWcnUG8vmtfsdKHc3edmOAn+Bv6A6d10e8ZpAmi8lhHpLK6shgwuhWjYe+XR
         ph+06Kh+Wwc2HW52TRXKzVUj6e5TCdlTWKrq0zwVHm28T4Xi+xsC77k/c6QDWP3xGg
         saT6RrtY0+qMYS4j0C29w4zhkpmI35+ZOWb4lqygG9uea9lMwllGBQO6Ca3ajittPf
         aB8Xxuphmzhoy2SjCudIxV9ospm6QlkrYN1aTnpv/jkT3pmrHSR1iFgPZURFXDfCGL
         l046YHwMeqjDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77EF8E270DF;
        Fri, 21 Oct 2022 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client: Fix advertise.data command
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166638241847.28420.8712576085392696189.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 20:00:18 +0000
References: <20221020225804.291712-1-luiz.dentz@gmail.com>
In-Reply-To: <20221020225804.291712-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Oct 2022 15:58:04 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> advertise.data when no parameter is given shall print what is set on
> ad.data not the ad.manufacturer which is a different field set by
> advertise.manufacturer.
> ---
>  client/advertising.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] client: Fix advertise.data command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8836711ad07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


