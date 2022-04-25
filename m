Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD036C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiDYOdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiDYOde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 10:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567534BB8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 07:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7145B8184F
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 14:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A9EC385A7;
        Mon, 25 Apr 2022 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650897027;
        bh=FzoW20lQaV0AspO9OsC2h2eStvDhqbdsckW6Trr/UQI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c7Sv2Kb1YZggoPySYzCDBIyMDGHXrVaBwx3JGkUEysLV+YzRYWvMUcDhFwMhQD7U5
         7R0Rq6EKRcEi/VHvxJxRcQc9AZ7ArLAFi8jnZLppFm3olv11ig05wI2Tfq/4u67dbG
         f1G22JIw9gWO9tAkW/RspH/jrkLMaG2gocw182B0UxeefYjRoRhuT7iXBxR6QYpKsx
         H2Lb0xljFA2Qo74NHnXe5Pis9p3N0FT4fjfG+rUk+jcoxpex9jimNn8TcrowxWWOtT
         ahTir+iPdcPzBNu+9DOGp6nfnnOMRxw8WI5zIVpi9Y4OFI5Zlsya+fYlCUDU8TYsJ6
         oD+7+XqTmIpLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29491E8DD67;
        Mon, 25 Apr 2022 14:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: protect le accept and resolv lists with hdev->lock
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165089702716.25646.7761597175138105526.git-patchwork-notify@kernel.org>
Date:   Mon, 25 Apr 2022 14:30:27 +0000
References: <20220422223116.70026-1-dossche.niels@gmail.com>
In-Reply-To: <20220422223116.70026-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ankit.p.navik@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Sat, 23 Apr 2022 00:31:17 +0200 you wrote:
> Concurrent operations from events on le_{accept,resolv}_list are
> currently unprotected by hdev->lock.
> Most existing code do already protect the lists with that lock.
> This can be observed in hci_debugfs and hci_sync.
> Add the protection for these events too.
> 
> Fixes: b950aa88638c ("Bluetooth: Add definitions and track LE resolve list modification")
> Fixes: 0f36b589e4ee ("Bluetooth: Track LE white list modification via HCI commands")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: protect le accept and resolv lists with hdev->lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/df50527dbc32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


