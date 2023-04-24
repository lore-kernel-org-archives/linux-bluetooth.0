Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40603C7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 04:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDXEkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 00:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXEkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 00:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D81BD8
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Apr 2023 21:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0A561509
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 04:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5124C4339B;
        Mon, 24 Apr 2023 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682311219;
        bh=L2BIHIluCdr1CtMCBmuGQ02J5pzcSWJppCLRj6E9iLk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YH0FUgQhZZvSj+DtTmFwZt/b1drZGmY0lJmemmL4+UUp85CkGn48RFExfFssqKwxx
         CczZiXPkAsM0ql95r0wQzD0u7DY2IPETq4CUd4MOtRdIyNyXL/DM4pQ3mc/yfuY0x/
         sYD7gP5Yudkpcwc/fplB0SgUof1HsgqLsVbvElFu4qNQkai1qv2vSiPrs5YapUaOXH
         5Uv2pQCt6U7e2o9KOGh4/nsWPq3btaX+CuYf7kZtNLG2H2iD9FmVqVWrTonKa17Q1e
         AVIcD8IHdnDe1em6m8B+ZFKHLauW3zla1PrcoTDY5w7UgHAccnefrD6dnm16K2WKjW
         Or0qrU9w6ZMQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9087DC395C5;
        Mon, 24 Apr 2023 04:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168231121958.29245.17899768984592604260.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Apr 2023 04:40:19 +0000
References: <20230421184716.2846319-1-luiz.dentz@gmail.com>
In-Reply-To: <20230421184716.2846319-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Apr 2023 11:47:16 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes sure hci_cmd_sync_queue only queue new work if HCI_RUNNING
> has been set otherwise there is a risk of commands being sent while
> turning off.
> 
> Because hci_cmd_sync_queue can no longer queue work while HCI_RUNNING is
> not set it cannot be used to power on adapters so instead
> hci_cmd_sync_submit is introduced which bypass the HCI_RUNNING check, so
> it behaves like the old implementation.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
    https://git.kernel.org/bluetooth/bluetooth-next/c/54f33d124f3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


