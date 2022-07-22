Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F3C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiGVSYo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiGVSYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 14:24:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C39E2AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 042A8B82971
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 18:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A93C8C341C7;
        Fri, 22 Jul 2022 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658514278;
        bh=xqurs5dJFEhcmxSNk4maCMnuFqp+BpZepW7sxUjm8aU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mfDmJa9IoX+MP0K/ITNf53DFa6IfFc2aH48YyEaWleqxqTJSbNbIlY0oWdAZg7FQg
         uljuQxPNtfJBVkyJEY2iF/cN0xn5wlPlKLxBnt/u3Rb2OuxleCabXsxz0ekJc800Xh
         eNwChvnTXXJfXDKjlQV0FLfB+8X7uLRPQda0N7myPl4ZOlVxK6TQlncWjOQzBSx9Pb
         M7d4zaPCSXZdBptlF7z6xJjCcby3tJ3h4ktwrbrEYa5rJ7mO62LRB7syRZjvi03YCp
         S0RmHgOxLdTaFE1gaB0MN5Ijf4QCQ72YxNNOqn0aTty9Fwkqc2oYihV7oO13D1smEZ
         RUM4pUwd5XNhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A597E451B9;
        Fri, 22 Jul 2022 18:24:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MGMT: Fix helding hci_conn reference while
 command is queued
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165851427856.3449.804628076680082896.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 18:24:38 +0000
References: <20220722002600.632792-1-luiz.dentz@gmail.com>
In-Reply-To: <20220722002600.632792-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Jul 2022 17:26:00 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes the use of hci_conn_hold from Get Conn Info and Get Clock
> Info since the callback can just do a lookup by address using the cmd
> data and only then set cmd->user_data to pass to the complete callback.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT: Fix helding hci_conn reference while command is queued
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b445e220db9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


