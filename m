Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC6EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJJUAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJUAT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 16:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FDE13DF2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 13:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D9DEB80F9B
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B8EAC433D7;
        Mon, 10 Oct 2022 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432016;
        bh=nDoBcvszEoZWIGdRe222/BJCG6LrMK/jSUAAMqWby/U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S3PHvuj6UoBV+8DlcYBWuw8rWHI+TVHqhqFiOdjEUy1P1AgTyRK4EeKVuiP262bTt
         RbZWduyY/FNg6cC/dwg7nkjTAJe6KBw0xhDNR0IfNezH8d7nC45ds/xUmghpkGJkrE
         /YpLM08uosLTQGp4BuvpQiNleX0RARbasgEHd6U62A87C7XeU7k3qbXvPFw+o1uT5O
         8yqPMmWstm8PNpfbzKr0JCo3fRtiGRBKq7ohJQz9R63vhb3eGA9NrBbxmSZNphxggY
         qr0lYMXGJFjhuncdBkuJZSdj79VoBqqPT3dZUMunLtIMCXZDjFuJZ2ktsiX60dlOV5
         codG+H3bNd9Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3387E4D022;
        Mon, 10 Oct 2022 20:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/1] shared/bap: Fixing memory overwrite during ASE
 Enable Operation
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166543201592.2402.9976336617866418586.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Oct 2022 20:00:15 +0000
References: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Oct 2022 23:15:17 +0530 you wrote:
> This fixes memory overwrite during ASE Enable operation handling.
> It avoids crashing of bluetoothd if metadata of more than sizeo of
> size_t is received.
> 
> This also fixes storing metadata to stream structure.
> ---
>  src/shared/bap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/1] shared/bap: Fixing memory overwrite during ASE Enable Operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3da439ae3c76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


