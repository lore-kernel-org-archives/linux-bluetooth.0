Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 23:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiEBXy3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiEBXxo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 19:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA02F7
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 16:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07995B81B11
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 23:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4943C385AC;
        Mon,  2 May 2022 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651535411;
        bh=IMevT++VP/1ueUIIRIzJ0jn5qU8X3Qi+/KuSsvQcECA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YzIOBquaBqXcGEfYlmSoV71I/+OmQ1FFypUlhEwSaDu0nhJB969f4sAIQo8XcGk5W
         Wabz7QGo4wSWoievJqfksWlZ6iX176Peg9f/EndGKgKwUgyuYKlHeOz2L6Xki+n2vV
         UlnIYfw1BwLBAMnS7YTYdMAJKTHJ9gbEahofqtwrXmmMM0WcGyFAAEth/vmXbxv8Zw
         H/ekK8jsexqKeGkPeHx0wtY+Ffh5z0lGSw8SyXmnwJv8Txzu+YxK+fqaWQNgKMuaa2
         +1TiggkstO0tq095liNPb7q6ztMXyaIOPdc/wcFkbPEAXqeEaAScv2TfsF++rNTwsZ
         JO28LKUEUBKyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AB99E6D402;
        Mon,  2 May 2022 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Fix parsing of LE Terminate BIG Complete event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165153541156.14150.2123520639979898666.git-patchwork-notify@kernel.org>
Date:   Mon, 02 May 2022 23:50:11 +0000
References: <20220502214517.2363950-1-luiz.dentz@gmail.com>
In-Reply-To: <20220502214517.2363950-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 May 2022 14:45:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> LE Terminate BIG Complete event format Subevent_Code, BIG_Handle and
> Reason but the last two were swapped.
> ---
>  monitor/bt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] monitor: Fix parsing of LE Terminate BIG Complete event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7ca43eedfd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


