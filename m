Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E52C63703
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGXuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLGXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Dec 2022 18:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCB5C756
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 15:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE0B7B82050
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Dec 2022 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83D9BC433D6;
        Wed,  7 Dec 2022 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670457016;
        bh=bJguUDz74KpG/uSPwhC+6lqteegijdfBzNAjqaIjATE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TokZgJ6RcugvWwv2h6islPgTNYZRZzGll4llAK9ZtCRCzlDvHgsJP5niQB6yKtd+T
         vdDwBBG29iy1ncYdgLWNeExsn4bf6kzPQDvyRV2ty8TA1QtuHDSOTe2HWj3eqohTG5
         N1OC6L8jOW0iGTotmoJfhF78kictVg97qmYM8USES83jjnfEN6vQdViNkDJOL/wlGg
         BLLt9Qq+W3mxHWLRJqCQEaLctqvLOU5qbH4pIV07uSBUsjTUjZSZArUzQB7LwPkcJL
         xjwMFrSbllagUSfzHqIcrtcHkZ3FnItM0ah+iiPxYwuU8itWHrzvSs/sExXXpd8Kzu
         PD28D0Evshk3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B394E49BBD;
        Wed,  7 Dec 2022 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bthost: Add callback to accept ISO connections
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167045701643.16225.4794408173206574265.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Dec 2022 23:50:16 +0000
References: <20221207013546.4162481-1-luiz.dentz@gmail.com>
In-Reply-To: <20221207013546.4162481-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Dec 2022 17:35:45 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables setting an accept callback which can return reject
> reason if the connection shall not be accepted.
> ---
>  emulator/bthost.c  | 21 ++++++++++++++++++---
>  emulator/bthost.h  |  5 +++--
>  tools/iso-tester.c |  2 +-
>  3 files changed, 22 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] bthost: Add callback to accept ISO connections
    (no matching commit)
  - [BlueZ,2/2] iso-tester: Add test when peer rejects CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=758161c422e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


