Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11692C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjFBTuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBTuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 15:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25219A
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 12:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83591618B0
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7002C433EF;
        Fri,  2 Jun 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685735419;
        bh=mWHpCVwNCiF2ZsxBo8ceCbbGflWElMhGkwMRrxfwNjQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vJWqZORmF2L0fHizcRHIw9qUwSlB9jPvcytTi5rOmr8q1bjfyNGWUOKbWfHBbb/nx
         zDBxD6gILswc5DRtaB9hX3khPXRaqT8RBLlAVcsQyN29KHWeCuyFQOYawcisuLznVw
         szo+wHsmiryyZtcAo9oyk0uvmlvEtl7cq7xgxoZtCokXi4B/eRDxaqxGS4G7aN7faB
         LTZ6dy7W1K73UWuQsZycCiS1We6F3cs6mWGWt3Vyj2ydxsGnI4Cr4dS77k42itOWDt
         oPDZlGjri+JtGhE3SLUPBxgpV/qMjCrllVSZSCf1FbU4bzAEnia3yXCol8RVEKVuqx
         WZVZyn0NqkbIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B76CEC395E5;
        Fri,  2 Jun 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] monitor: Only print credentials if PID is set
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168573541974.27233.915150873238679796.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 19:50:19 +0000
References: <20230601233317.1419030-1-luiz.dentz@gmail.com>
In-Reply-To: <20230601233317.1419030-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Jun 2023 16:33:16 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If PID is not set don't print anything since this is likely a packet
> originated by the kernel itself.
> ---
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] monitor: Only print credentials if PID is set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f84979c1591f
  - [BlueZ,2/2] shared/bap: Don't overwrite attribute declaration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52477e80fc89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


