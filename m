Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 23:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiJSXBt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 19:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiJSXB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 19:01:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186852080
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 16:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7A25DCE247B
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E097CC43140;
        Wed, 19 Oct 2022 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220418;
        bh=GWCInCdLZL9kpWkI1oRNSSolbPdgHFcrNxq0Q1blgOA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rGi6bsx5Tp8SR20SYCTnsnFsJMBGadcQWngDUAxpAa0T+OjA6wqzsc6J4SCs71Rbo
         H1MDBZrOBLBGXCgr2akNWWXIRDdGH3SiU51QlijNRe606OryR3Jt00i2kB6ud+7Quc
         WFa+BohUPTsQMU1j0u3u+0QcnG1IKeP4UyqtkF8FmO8nkljf6nT/nBGiRjpWNt4HFz
         P2FXcJBubK1mrs7e8dbufWi3NGueRLc7lXIEdNyoWotmX4bVxNN6ameWsaIjPC8tSS
         384FynA23rYGIpuJRiw0QPIAjocKRNMnruuMqXfaI9aKcvt0WR+7DjyBCnHCDqXGJH
         iTNEvtMFwB9BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6A9EE270EA;
        Wed, 19 Oct 2022 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/util: Increase debug trace buffer size
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166622041880.8151.1631855556835217221.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 23:00:18 +0000
References: <20221019203028.57090-1-frederic.danis@collabora.com>
In-Reply-To: <20221019203028.57090-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Oct 2022 22:30:28 +0200 you wrote:
> Most of the debug traces are longer than 78 characters, increase the buffer
> to not lost trace's end
> ---
>  src/shared/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] shared/util: Increase debug trace buffer size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3153b0ecfe16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


