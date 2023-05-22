Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 21:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjEVVKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEVVKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 17:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7E9D
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 14:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270AD629D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 21:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80556C4339B;
        Mon, 22 May 2023 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684789819;
        bh=+50W84He8VhD5v2gG5aoFns8gqbU7XGEwJcqLVd+utg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fgdBRMnZ0+qnfSv5zvG/No45wwhQb4o5sBAfE0L/BUXEwvv6MWnh0ze6gRiGUpGo6
         vr1qRBwgutG2ZCgrATijOErsnaUufTdPKg6ynaXSjtrNpsyBGIDJTmZA9uWEVFMI1Z
         IOviIIFlC8cOKdCai5kY2ffDYqojbXHYDgE2tmer+BVFyuMvR6Q7926c78nLatYkzh
         Vw1pB6qA6smhhb2fY+t3lXeID3IbsWT2SkoTRbf9hlB5/4wbuotVhfO6u3cQGj/slf
         pORpHA7zfqoLBsZsXEe4/hL3nbZdjqzBQxzcYtKED16O+PHa78Ps/1897mn2czqgQN
         1T4wQ/Ysawa+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6615AE22AEC;
        Mon, 22 May 2023 21:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: ISO: consider right CIS when removing CIG
 at cleanup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168478981941.2048.3358211127005602203.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 21:10:19 +0000
References: <2bf70b0560375b50180518968abd8c4dfcce7f34.1684788145.git.pav@iki.fi>
In-Reply-To: <2bf70b0560375b50180518968abd8c4dfcce7f34.1684788145.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 May 2023 20:52:44 +0000 you wrote:
> When looking for CIS blocking CIG removal, consider only the CIS with
> the right CIG ID. Don't try to remove CIG with unset CIG ID.
> 
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: ISO: consider right CIS when removing CIG at cleanup
    (no matching commit)
  - [v2,2/2] Bluetooth: ISO: fix CIG auto-allocation to select configurable CIG
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb576dc48252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


