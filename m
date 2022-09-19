Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB3ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiISRaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiISRaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88937BD5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25601B81EFD
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1A64C43140;
        Mon, 19 Sep 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663608616;
        bh=Vg7AgJqVF3WxrTqFQQE/WOfAiLHTy8z8hGHJx+E7TGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DkgjNgZs7TarjcfIc1AhRPAFwWuf5sayP0g6mexL2vAzQ0SqOXkqrqlHpqC67PMAT
         BL/j5uvPMhyMTUjf4HnLdHQ+2mm8eyZgPA0tL5dfaY7o7RMgBa2wEx14FaU5O1B1n2
         QyM/iD0Igiq0YF4lFiErkRQ5tJARaldplzFirtrZYvpQV6tASYKyuU28gSh5Z/+X2K
         U6fX29o/yz/blSMdCqfq2P7uPa0W/dzs/GsBc55JtHSE0sGnlOk1niIZKcmr+64Gqd
         +BHbXMTkUmbHcVXxOLSkpcFjOyo3cINDkFiHtaJ5XnmdonmMufZOlV9eD5BQc4msaO
         dxYVpsrvDeDxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9722E21ED1;
        Mon, 19 Sep 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: initialize delayed works at
 l2cap_chan_create()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166360861667.29822.12688663792138790626.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 17:30:16 +0000
References: <b7d8d14f-6ef9-a2c0-0a7c-cdbdf6f12551@I-love.SAKURA.ne.jp>
In-Reply-To: <b7d8d14f-6ef9-a2c0-0a7c-cdbdf6f12551@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+83672956c7aa6af698b3@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 4 Sep 2022 00:32:56 +0900 you wrote:
> syzbot is reporting cancel_delayed_work() without INIT_DELAYED_WORK() at
> l2cap_chan_del() [1], for CONF_NOT_COMPLETE flag (which meant to prevent
> l2cap_chan_del() from calling cancel_delayed_work()) is cleared by timer
> which fires before l2cap_chan_del() is called by closing file descriptor
> created by socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_L2CAP).
> 
> l2cap_bredr_sig_cmd(L2CAP_CONF_REQ) and l2cap_bredr_sig_cmd(L2CAP_CONF_RSP)
> are calling l2cap_ertm_init(chan), and they call l2cap_chan_ready() (which
> clears CONF_NOT_COMPLETE flag) only when l2cap_ertm_init(chan) succeeded.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d2cb3066f2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


