Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A5CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbiFMTmQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbiFMTlq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 15:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A75F73
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 11:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FE61B811EC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6179CC385A9;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655143815;
        bh=PnAKmESgMAu1yEPkzM7t4IW6J34FzCNA6TjC8YgYj24=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tV7HDMupcDarsN8zFLhxtrToCA2tRNt8MK/Kl/LW+ZiF/I032YGgBSjz834B+krg/
         WJCpVAw/PvJszrLUTA4aVDO+jKvVU8+KcqhLZmzilUupV9vyBc33rEN9f2cMCcSi/b
         VYR/eE5tVnbDIl4u9O20HBn6VfPr5i0AgbQk1kaxqUiXkNXP1I7PWHYX95ZxXmymDR
         KUa3ZUlHxitRXe9vvD90uFfpxwjTWZ5iF+kD1BOsJzgugompGElJ19lKglPpwom7/I
         gYCJQYjGaqzRLR+D9xPccj7TQJ4puEpA8/ktUcH8niwkhHdZ+v+tJzY8zbXLaFwDMs
         u0EsyeapRst9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49703E73858;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] obexd: Fix callback->func =! NULL in the xfer_complete() func
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165514381529.24573.13806720354390874416.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Jun 2022 18:10:15 +0000
References: <20220613113713.13681-1-wangyouwan@uniontech.com>
In-Reply-To: <20220613113713.13681-1-wangyouwan@uniontech.com>
To:     wangyouwan <wangyouwan@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jun 2022 19:37:13 +0800 you wrote:
> xfer_complete (obex=0x557d242c8cf0, err=0x557d242ca470,
> user_data=0x557d242ca300) at obexd/client/transfer.c:659
> 659     obexd/client/transfer.c:
> (gdb) n
> 661     in obexd/client/transfer.c
> (gdb) n
> 663     in obexd/client/transfer.c
> (gdb) p callback->func
> $1 = (transfer_callback_t) 0x0
> (gdb) n
> 668     in obexd/client/transfer.c
> (gdb) n
> 671     in obexd/client/transfer.c
> (gdb) n
> 672     in obexd/client/transfer.c
> (gdb) n
> 676     in obexd/client/transfer.c
> (gdb) n
> 677     in obexd/client/transfer.c
> (gdb) n
> 0x0000000000000000 in ?? ()
> (gdb) s
> Cannot find bounds of current function
> (gdb) c
> Continuing.
> 
> [...]

Here is the summary with links:
  - obexd: Fix callback->func =! NULL in the xfer_complete() func
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6d3bcf3d005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


