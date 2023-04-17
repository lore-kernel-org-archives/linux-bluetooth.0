Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F319DC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Apr 2023 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjDQSay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDQSat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Apr 2023 14:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA876180
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 11:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63FAB62954
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F8D5C433A4;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681756219;
        bh=QEsoBcdPaH6i9b5R0ZYz0t3TcCsKT3tcxEej34YSqcM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U5KYcK8VWfoB1O8WapgsH3R6movvW+I60FDUENU9MXt94TwfR24RtrCgxCdL0/TTD
         PKhSRLCkMBDg5ubyoQ4M4PwZvGUnhBjY/SRO0mpjhg2CUmNqdiuf/Ma9QwBR3TTG1q
         3jhjRAFrSAIiz2DuvVNyeh1a156CC3+TTLwn6CRgX4cfno6xgZO05ycaeCDWn6GIiz
         8kl0sfj0vDlwkGXzJ04PYD7XBjuByHFQZxagSJsxcyJh8OoGJ1fzmAPqK1dAQxx2yP
         EDeJtQE30AfoUkv782t0acnBMdaoqnr4+Y+6X2x4X52eviglpm/CfT0twGBB7QUYGD
         SYMkwksrpBNCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 605A2C561EE;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth: Add cmd validity checks at the start of
 hci_sock_ioctl()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168175621938.2755.3988233703199508689.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 18:30:19 +0000
References: <20230416080251.7717-1-lrh2000@pku.edu.cn>
In-Reply-To: <20230416080251.7717-1-lrh2000@pku.edu.cn>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Apr 2023 16:02:51 +0800 you wrote:
> Previously, channel open messages were always sent to monitors on the first
> ioctl() call for unbound HCI sockets, even if the command and arguments
> were completely invalid. This can leave an exploitable hole with the abuse
> of invalid ioctl calls.
> 
> This commit hardens the ioctl processing logic by first checking if the
> command is valid, and immediately returning with an ENOIOCTLCMD error code
> if it is not. This ensures that ioctl calls with invalid commands are free
> of side effects, and increases the difficulty of further exploitation by
> forcing exploitation to find a way to pass a valid command first.
> 
> [...]

Here is the summary with links:
  - bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
    https://git.kernel.org/bluetooth/bluetooth-next/c/5612e6a8ff35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


