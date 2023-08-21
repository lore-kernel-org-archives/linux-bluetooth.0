Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD19EE49AE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 20:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHUUla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjHUUkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 16:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E1CC5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AF5961806
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 20:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B23FC433CA;
        Mon, 21 Aug 2023 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692650424;
        bh=v3FXWN76RifE23s4dN597jpRin3YyNdUQL1+6Px0GcA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YXRhTGBSsGN7Ot7rErCf42d39tu42jD3PprKkkri4OLBM4ynKgam3vBM7fWhwoX/+
         I2tInIQPXyQO91jLc263BQR4CAXqbjRfcQgqrJj+kUjzBkvrUx/gnQDOOI3Idkfaqt
         NniEqD3PwUzPYZPw0W5pBXqXA2aB8mVZqiv7NFmr2Z3ls7hxTWieoCNTcC4TRv3Tys
         KxujTnusgtmmm5C9LDOTog2kjZCaqKb9K+kVKOMftELqBB5QFPtUik/pyUqsdTh5ER
         bNgZXN2QQGe1OE/QiE+sBr9gyXassbb/a1nqhEcIxHAHdr0WZWu4cOsaMQf7vq86KJ
         KtklzT9hOf9JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B8CCC3274B;
        Mon, 21 Aug 2023 20:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL
 gone early
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169265042450.14991.4730354041054049227.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 20:40:24 +0000
References: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
In-Reply-To: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Aug 2023 16:33:36 +0300 you wrote:
> Not calling hci_(dis)connect_cfm before deleting conn referred to by a
> socket generally results to use-after-free.
> 
> When cleaning up SCO connections when the parent ACL is deleted too
> early, use hci_conn_failed to do the connection cleanup properly.
> 
> We also need to clean up ISO connections in a similar situation when
> connecting has started but LE Create CIS is not yet sent, so do it too
> here.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early
    https://git.kernel.org/bluetooth/bluetooth-next/c/c452805643ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


