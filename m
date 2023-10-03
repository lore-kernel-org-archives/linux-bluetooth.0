Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC59E8FDC3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjJCXUh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjJCXUe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E68AF
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:20:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66A5FC433D9;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375229;
        bh=86/dzsFkjFTy40jKZe2XF24zl7bW1vSce0lk42sbQkM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z0XaLEUFd9HP+p5ec7AZl03GRhc8p+wfXicssBpa8F+FL9JcM9UjlbUv03OG5U5h6
         MdCztZjecSguH5NVfulcVVBTyOdqIPByEXDkefuam5y0NKc1Ijs3tku+8/TCm8ZB4q
         2w907UMNTw+P7terT8FEN8qL3cCW9nB9pEAbee45eJ5blnxLc3jwLgvq6l8mOT+/V7
         FKq2GjAvutTV3MVoAdGk1WUlsepeAQzZiIFmnFn8DRzI52IBO1LuH9DZ5vhCWekT17
         wDs8eih/lPtcVGHgcuyNmM2JL7r2n63vr8IQpF10MnUZm8H7xuMwZbAaMCl7MIicyE
         OOpt3+GfNAyUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52046E270FB;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/att: Don't keep retrying the same operation
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169637522933.21629.13370082303236652052.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 23:20:29 +0000
References: <20231003184222.3273301-1-luiz.dentz@gmail.com>
In-Reply-To: <20231003184222.3273301-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Oct 2023 11:42:22 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If an operation has been retried already don't attempt to change the
> security again.
> ---
>  src/shared/att.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [BlueZ] shared/att: Don't keep retrying the same operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ff68ce57fb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


