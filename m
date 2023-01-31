Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D21C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAaWU2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjAaWU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C00CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 14:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A1261710
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 22:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5C74C4339B;
        Tue, 31 Jan 2023 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203624;
        bh=uiiGIt9zpn41sDMeTFnNYF0AeGBEQi2JLlGMz65ZLXw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W3rAL4Vj/2Eho0RdFiCNjgSMWHgjKWNLVLBbNADf2YmPpowqeS4E+o7OLB1qMnBm3
         EkcTvWQh/rwKVPW/hTImE+yYEAL8rDViWfUiciUHne53VF9PaFwQPs1xmACw4ZZEQD
         uPNZvvcFTi6FB7XmuxruLFbE7kjd5zjpSnZdbz+lmSEuMKBTRW/X5r7N8B76mR88bo
         X8zeEqoWwGdrq3px1WYNXSi/JppC8+mmlbcpCYwqpYCmLoryC4NTwm1GAiKfQ/HFx8
         gfMK/T6VWK/G2rdvGhOHoCysGSqRAyqO/gj601J2yaAqJPMX5Qmms/kilhFkuTmTXp
         ZITzUH7UVU/EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A80BDC072E7;
        Tue, 31 Jan 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] shared: define MAX_INPUT for musl
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167520362468.18452.17996354116446297750.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:24 +0000
References: <20230131055258.3311810-1-sam@gentoo.org>
In-Reply-To: <20230131055258.3311810-1-sam@gentoo.org>
To:     Sam James <sam@gentoo.org>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Jan 2023 05:52:58 +0000 you wrote:
> musl systems don't have MAX_INPUT. Just define it to _POSIX_MAX_INPUT which
> musl does have if it's not already defined.
> 
> Note that on glibc, the values match anyway (as of glibc-2.36), and indeed
> POSIX_MAX_INPUT has the same value on musl too.
> 
> Bug: https://bugs.gentoo.org/888467
> Signed-off-by: Sam James <sam@gentoo.org>
> 
> [...]

Here is the summary with links:
  - shared: define MAX_INPUT for musl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca6546fe5213

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


