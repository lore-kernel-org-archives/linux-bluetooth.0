Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5731C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354099AbiFUUUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1971CFCD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7216181B
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 20:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F48C341C7;
        Tue, 21 Jun 2022 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842813;
        bh=rkteo8S15LtR2nDpGBTrN/lv2nnWSppRTRVRsYtBLFg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jDunQ+Ju/8qM8YC4f0P/bp+5J26gtE6Z122PKhkcwxB+Hf0F+GwZ3ffjkPjzh/Yl2
         yjWEx7RNLkbPD7EHIJLLi9RchVO7eRqhVadDa/3T4Kr95b15XhhHv5SWyNMS0GNaAz
         60yiYsKSN/2bUD8Bho5V0k5hCte2AU173Il01YUFMvRBRT/juowcS6+A/rWAuNvZU8
         U2y76IKrDdBfqQkxQWH2sSXMfiKKQsPaLwtSBtqc9gQps4CQvRzPKbAeKITMQRD/7/
         sptyeXqxsKxl/Z2TTuGZET5/EM4/f/PGgj0yqFhDGKO8xsRWbhm8NYLOQY8hazZ6qW
         ntT2WjjqwBbnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 651C2E73875;
        Tue, 21 Jun 2022 20:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] avdtp: Free discover when send_request returns
 error
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165584281340.22978.2263696849927364814.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 20:20:13 +0000
References: <20220621043133.7720-1-zhaochengyi@uniontech.com>
In-Reply-To: <20220621043133.7720-1-zhaochengyi@uniontech.com>
To:     Chengyi Zhao <zhaochengyi@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jun 2022 12:31:32 +0800 you wrote:
> When send_request returns an error, session->discover should
> be released here, so that the next time the program enters
> avdtp_discover, the -EBUSY error will not be returned.
> 
> Chengyi (1):
>   avdtp: Free discover when send_request returns error
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] avdtp: Free discover when send_request returns error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=949898cc5e7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


