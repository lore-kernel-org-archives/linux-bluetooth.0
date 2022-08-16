Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64EC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 23:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiHPXU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiHPXUU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 19:20:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222773925
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 16:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 440D8B81B47
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 23:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E576AC43470;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660692015;
        bh=+1Slv/E4uV54cVz/BoLGKdffbhH9mPhCVf+cV642dLQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YrMLjwNzG2S4zT7hcuGCDgnlF5zQ3IUQ3X6lZqchN2EluaG517ffW97+dykOirmEV
         wGWmK1y3D23u5n2FN/Lw1wxGCDQPgQ6QIZguwUFikvcF3fnuyjXK0or4gwvo+47QTs
         b6AkHLBPW5Qq/aeZUDoXbo8FLVJt+54W8gPRKyVCbuoFKAvgB8VT219ETJOWHWaXuw
         ytVlFbTuMsUvfbBg1Zt7/fD8+AOHx0XcQRNv1DloIXo9NOnNf8BgHRIGF2bXY55OG3
         l956iTiMGNUmuiE/Ial/hT/dW16YcjcqcooO3piRXzseh5e91FiTlj95gdS+olaS1k
         zsnmxYBRYvCmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C851CE2A055;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Check flags are supported
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166069201581.20856.16721151067322364096.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Aug 2022 23:20:15 +0000
References: <20220815232006.1252933-1-luiz.dentz@gmail.com>
In-Reply-To: <20220815232006.1252933-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Aug 2022 16:20:06 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes sure the flags are supported before attempting to set it.
> ---
>  src/adapter.c | 4 +++-
>  src/device.c  | 5 +++++
>  src/device.h  | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] adapter: Check flags are supported
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c47730b2d563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


