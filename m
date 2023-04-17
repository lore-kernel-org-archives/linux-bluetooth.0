Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D1C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Apr 2023 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDQSav (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQSat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Apr 2023 14:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8055FF9;
        Mon, 17 Apr 2023 11:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C306294F;
        Mon, 17 Apr 2023 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67695C4339C;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681756219;
        bh=3e9vKiBUmmEVBKScxPSb0rPDmENNsW9Ti6H05k9fcNE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=chUnqH0QIixvPMWv6v7K7XaUa9VexvyBA46wTWxni8GGiS7YLLKytoDCXjYdQqBda
         lVTRagGdYLAPZVdRbNn/04ktmSmFj5o2FQXvkyc4i8NhW3x/k2BBraVod1ftrvTVZK
         0XK43evBL3g63FgkqK6gttd3tAk+uYlxi4OQ5fNnWBNo+JiwriJ/bqFDJt4Gjq3Ku9
         t0/wT/v3NiSKp78t6K/XXsWsYu/X3ZpXSIZbxLK6rJDGNqjqXwAH+rIkuSUKlO+NhW
         SmjFWFn9xTNTy8IiZUMx6+cqVjaMZfP4XO/WvZfrlyJ5uErZ55azwRuuauTCWWtN1f
         VYrle1GG+Hdtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41BC5C395C8;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth: Perform careful capability checks in
 hci_sock_ioctl()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168175621926.2755.7232782905292014769.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 18:30:19 +0000
References: <20230416081404.8227-1-lrh2000@pku.edu.cn>
In-Reply-To: <20230416081404.8227-1-lrh2000@pku.edu.cn>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        stable@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Apr 2023 16:14:04 +0800 you wrote:
> Previously, capability was checked using capable(), which verified that the
> caller of the ioctl system call had the required capability. In addition,
> the result of the check would be stored in the HCI_SOCK_TRUSTED flag,
> making it persistent for the socket.
> 
> However, malicious programs can abuse this approach by deliberately sharing
> an HCI socket with a privileged task. The HCI socket will be marked as
> trusted when the privileged task occasionally makes an ioctl call.
> 
> [...]

Here is the summary with links:
  - bluetooth: Perform careful capability checks in hci_sock_ioctl()
    https://git.kernel.org/bluetooth/bluetooth-next/c/313016d28888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


