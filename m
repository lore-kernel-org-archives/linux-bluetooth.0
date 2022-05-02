Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiEBXyl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 19:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiEBXxo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 19:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4AB8A
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 16:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB79B81B13
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 23:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D863C385AF;
        Mon,  2 May 2022 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651535411;
        bh=YyRcXDHzM0Ocz3Ti/wgdKFPWZMN8ZVzSXZq4Cu1Zou8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sP2ldyr+07ffKrdJZ7fKc0Xd8UDUU7+EyN6peQocwvYAMlxn3UC5IeZKtPvkFMR8V
         5BwkBgU/86GSNK5COC4hNAaJHFFEcfJW8uRq7zq40luCYuNjLiocdpAhSaUAfTIZJe
         7LuyaG1lwUrw4Zmr39CpUnXkGfUC1LJxgBOZseyJ3l6CGHKfPQbJ3gpWeiu9XDANTj
         FkV0x5/tsiKqbceBIYIJrlY74wcHucUf8H65yqKALardi50BLpCdvq26eEnQiE8VMG
         UbvzJV02iXSaclLh/NCZybHAfUn8Ls5Og/eJHxLJPXPdNupvtHBi8mUCLZvWEtVBGG
         85xgHJYtMRRLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81CA9F03841;
        Mon,  2 May 2022 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] btdev: Fix not removing connection and advertising
 set on reset
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165153541152.14150.12523909985926798654.git-patchwork-notify@kernel.org>
Date:   Mon, 02 May 2022 23:50:11 +0000
References: <20220502210553.2271064-1-luiz.dentz@gmail.com>
In-Reply-To: <20220502210553.2271064-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 May 2022 14:05:52 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes sure that all connections and advertising sets are cleanup
> on reset.
> ---
>  emulator/btdev.c | 76 +++++++++++++++++++++++++-----------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] btdev: Fix not removing connection and advertising set on reset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c75ff36b77f8
  - [BlueZ,2/2] monitor: Decode LTV fields of Basic Audio Announcements
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


