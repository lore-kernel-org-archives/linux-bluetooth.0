Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EFC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjB0VkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjB0VkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771A1ACE5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 13:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5584F60F42
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76D0C4339C;
        Mon, 27 Feb 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534017;
        bh=Pwd9nKYdt/KYSN8BgTtXkxjrDHUcsVwJ4Wh/re2Ert4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cy5C4P/Isi79oMNp5OfCK+ApkVlK+t8uAnIlAFW6wmQlGdIyg1jEpkLjij3QsLYTE
         2zjh1myneD9tT6KvEnDZJqzAkDpFsQ2czWmh2XDW6YIDo4XvANGmVboKsD610KOYGZ
         F6HPaeUD9X+LZCJPv9XoutFmOsa3HX5FFmso3HSUNbHYEBU/zgms8Xcf0akkAvF3yt
         cuiXNoX5X55Xz/BfYy0ImR4XiHbgyUf0jSqI7TTARlQvOY9pCZPXRxEX5N6Bb5m1UH
         FjMHcC38iZCe8LOCH2PbrrmkdQ+hDfLLJd4v5wST9CB1afqmdwW+U0+WUtIoDeKXu8
         yadx9/O14aROg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5DD7E21EC4;
        Mon, 27 Feb 2023 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] Bluetooth: hci_core: Make hci_conn_hash_add append to the
 list
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167753401767.12319.8383045482900462610.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 21:40:17 +0000
References: <20230225002052.3866357-1-luiz.dentz@gmail.com>
In-Reply-To: <20230225002052.3866357-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Feb 2023 16:20:50 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes hci_conn_hash_add append to the tail of the conn_hash so it
> matches the order they are created, this is required if the controller
> attempts to match the order of ACL with CIS which uses append logic
> when programming the CIS ids on the CIG.
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: hci_core: Make hci_conn_hash_add append to the list
    https://git.kernel.org/bluetooth/bluetooth-next/c/c25cd4779f1b
  - [2/3] Bluetooth: hci_core: Detect if an ACL packet is in fact an ISO packet
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c999e405d6b
  - [3/3] Bluetooth: btusb: Remove detection of ISO packets over bulk
    https://git.kernel.org/bluetooth/bluetooth-next/c/e574898ac6ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


