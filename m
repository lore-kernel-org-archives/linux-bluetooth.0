Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EBC25B47
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 18:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJXSu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJXSuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 14:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8ED7D
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 11:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058D4C433C8;
        Tue, 24 Oct 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173423;
        bh=H2zdFJ5u0puhN9LYu+Tg4mC6TrjnHB9Qi/d9P7xvgTA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oReVVvD+I81Unii+2ut1pBtmpzgPJ91W3RrHC8bPY46ZvTtBDsIk3pzyOXEG96p9t
         FApxRHuiZ3686n5U2OcE5bioJFRdenkdeFa7VG0Folm6TFrtOVY3YzQcwTttdYbWGn
         emivW/m32SGYKncEJM+/X6pNYj1ed6I/HftTQLNQttVLL0Ap/+NHdlHfumCpwsw4zY
         +Nu1Tebg2+t/1/AEulRW5yZh/RnK0ESPn66xl9R4M5d4SGl67iPg2x33B6hbxjEysB
         Uu/TPmP89EGySO6WDg2mIeCs22NdWIeOL10ErwYdO+O1RNjRJqvj9Og12lZaml2MA4
         yZCt7X5ik65xQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D56CFE4CC1C;
        Tue, 24 Oct 2023 18:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver PA bind
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169817342286.13534.5307923934042632577.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 18:50:22 +0000
References: <20231024110345.3292-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231024110345.3292-1-iulia.tanasescu@nxp.com>
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

On Tue, 24 Oct 2023 14:03:44 +0300 you wrote:
> This patch adds a test for binding a Broadcast Receiver to a number of
> BISes after PA sync has been established.
> 
> This test depends on the kernel update introduced by
> [PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.
> 
> Iulia Tanasescu (1):
>   iso-tester: Add test for bcast receiver PA bind
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] iso-tester: Add test for bcast receiver PA bind
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a17455cdcd21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


