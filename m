Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D544CCA473
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiGVUKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiGVUKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E351903F
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A7761FFC
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758AFC341D0;
        Fri, 22 Jul 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520615;
        bh=fkGCZg5EGDH4innvUq6I7UKNVY5S9itIjFChPVrzlM4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VrZnuuJ0CFWXAUHhf2wdLFdzxofJ18adtPg4ZVYojOD9j3N4BXzt0TQrTb7dl/ND1
         engS2I+HqWRyGyyYNOh/o16Lgy5Gkhci9EOlBTLdlDg+DKFx6tWht6vU/0cMplnZkx
         MUeNQM27yPW3wBFGqAkl29B5rbQJ9os5fhmIT5KK/t+5jg1DdBTXP/oLPjwtlFRq6L
         6OABl+gcRy0apstb3L324271lhvHcL+EwWnjY8U4bFHOxRWgeMo03mbqO2D4WOZvWQ
         Abqm5inqEN286KlymxzDsztuoDoMevrL5QNErn3YN22hr3StpIPFMBm1tFFMEvupFz
         7e/v7hokDzemw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60F8EE451BB;
        Fri, 22 Jul 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Clean-up stale/unused hci_request.c code
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165852061539.17882.14313781188452022391.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:10:15 +0000
References: <20220721232225.624426-1-brian.gix@intel.com>
In-Reply-To: <20220721232225.624426-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Jul 2022 16:22:22 -0700 you wrote:
> This will be a growing patch-set of conversions and dead-code removal
> towards the goal of retiring hci_request.c
> 
> The patch sets will be split amoung the work queues and delayed work
> queues as initialized in hci_request_setup(), with the ultimate goal of
> eliminating hci_request.c entirely.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: Remove dead code from hci_request.c
    https://git.kernel.org/bluetooth/bluetooth-next/c/ec2904c259c5
  - [v2,2/3] Bluetooth: Remove update_scan hci_request dependancy
    https://git.kernel.org/bluetooth/bluetooth-next/c/bb87672562f8
  - [v2,3/3] Bluetooth: Convert delayed discov_off to hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ef08313cefd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


