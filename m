Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AAFC00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjJXSu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJXSuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 14:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D930A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 11:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 022DCC433C9;
        Tue, 24 Oct 2023 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173423;
        bh=sAnIaf0zzoOhzNik+0AekQ1/9TL0jVO6VxO2sbcl43c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N2KqFwiaGFEMJhJQTYKjM+VDjWTfdSc8pSC2e+jkXlHZZ42ewq+k9Tax0hgcl+NyE
         rNxn3hOwOlj9yYm5Xz6ZHfSkaM7G11AJLIDTs9C1glk/NlbiFYPlV2EiVCC39t05sf
         zO1rLA6OvDw1OSXNNMSRtrpw/UdT00ZrYcwxMEQdS/NHqmtQiTpWg6zSQWsiUvRZHB
         u0cG3kB12IsbcA+0FdpS/xupIooLRLAhnPgJYm2XGB4CuGl/OvCn1uVXXpFz7Werym
         FKe9ngiv6mBimlKrbnarVJ7BoyeHKSpTZ3KyqUbme8hkcQEM8D00D9PJb6qArygLRg
         8M/NydHHLW05g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD77CC3959F;
        Tue, 24 Oct 2023 18:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] btio: Allow binding a bcast listener before
 accept
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169817342283.13534.14599969182820704167.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 18:50:22 +0000
References: <20231024110430.3323-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231024110430.3323-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Oct 2023 14:04:29 +0300 you wrote:
> This patch adds btio support for binding a PA sync io to a number of
> BISes, before proceeding with BIG Create Sync.
> 
> This depends on the kernel update introduced by
> [PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.
> 
> This patch version fixes scan-build warning.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] btio: Allow binding a bcast listener before accept
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00fdb61d5616

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


