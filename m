Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A8BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 12:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiEXMa6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiEXMa4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 08:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E99419C
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 05:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30852614E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 12:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914CEC34118;
        Tue, 24 May 2022 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653395454;
        bh=xvoRcaAT6v+1W+G24H7HOjJK0vp967AGguBvvFhxIHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=inhaYTz//iun6QpCwRf6T+bUjH9+gUif5G764CCVALdKajB/yuNBVfYD7dbkQIadz
         DUQm6iyZs5gpSJ00rXl/2OdBx1CsyN47Gug/ZCk6RufoGpJbpyDiy9i9e0Tvg1vZDK
         HJXIylj4rTOlqLyMgVHThsGAR/ckAClk80qar30i6kdx3/NfUN3Ed9sXlk/PtoZbl2
         q9uRpgNn1Ee3alFMljLyYjP54gLThfGJd7S9s+p/gxeeShmaAwOXtFARvo1Kujynyh
         WkN6HVissQPjTBT0ntoVa8YSYvWgjINec8XF75VtJfAHSByDM1DY9r28VF/44p4q8E
         AJrbh+AaY4xXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71FBFF03943;
        Tue, 24 May 2022 12:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165339545446.7336.2419090981386078491.git-patchwork-notify@kernel.org>
Date:   Tue, 24 May 2022 12:30:54 +0000
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
In-Reply-To: <20220520183713.2641513-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 May 2022 11:37:13 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The handling of connection failures shall be handled by the request
> completion callback as already done by hci_cs_le_create_conn, also make
> sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> don't actually call hci_conn_del to cleanup.
> 
> [...]

Here is the summary with links:
  - [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9f73a2178c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


