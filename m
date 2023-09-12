Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0125EE3F0D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjILSuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjILSua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFE125
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 975EEC433CB;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544626;
        bh=2DGr4P4FTZCyI82ZyI17k1PXBOf2XaVnuzV2tfpR6E4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mn+e3+jhHOlS+OIpofOo4ErNdRRwO0gTa72T/qUW4vvdBiG4dlFR1iXPChEA32I9G
         s6t+K/2wn9AjRUVuvI9VNifszzuIYaQyBkTXVkvh8WBLsTG/kIGcE0P0NFSHlegmVk
         GGSmRMVMtRsMa8glTiiB8Ez82cOC1n4Oi+CxDS4ePAha75v00R428X5JzC+7/1RfD4
         3VHu7Jq4dPO20QKfv7+Gsm/cQjYQjXZviPfQMKkIbJhLvNnFDZW94atBDSAqpftqXv
         feEU/Uezuj5MAf8Yuz+WrivhpsmIQ8xvgAk1AXx68BFKRPb0P9blJc4uHJ6BqCqgBj
         exPhdsBlgBLnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B8D3C04DD9;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] main.conf: Fix parsing of uint32_t values
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169454462650.13260.8434369852731815958.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 18:50:26 +0000
References: <20230911205447.2689657-1-luiz.dentz@gmail.com>
In-Reply-To: <20230911205447.2689657-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Sep 2023 13:54:47 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Passing UINT32_MAX as int may overfollow causing errors such as:
> 
> bluetoothd[2688495]: src/main.c:parse_config_int()
> General.TemporaryTimeout = 60 is out of range (> -1)
> 
> [...]

Here is the summary with links:
  - [BlueZ] main.conf: Fix parsing of uint32_t values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=53542db3d6c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


