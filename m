Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbiFQVKQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiFQVKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 17:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D9E00F
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28305620B0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 21:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A56EC341C7;
        Fri, 17 Jun 2022 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655500213;
        bh=L/8C/RTxM58xtvp5tVu6aQpyy5f4+4hv/Q3KNq+1UwY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oYUO+SbymjB9koHrL3lbOWdnyo+1gzD+hejILFnGWKz2AGBkPQGure0Weu7fKG3JZ
         oh6OZ9TU5BUaqS+CeToS/koD7YbQE9zVmEaozA9JIp5AqBI5dV9nBBIpj8iAq3uepf
         iMXDXCKP2jw++1MmFDpls7mFSAyKFNdmeK8uhRCH427dsKoscZNvTNN2FX54Gr/Wty
         /Nfq0l8uX5E7iKrL3EtY83P8Z/hgvpfl9JlauyGAstvtteiNDM7BG5BAbUiiP11lHg
         hwn8iI+EAsKYS8WPLq6Q2LqejeaY7MzOmOUHHE+AmEB8Hu9YDMRztvmiXcthQ9h3dJ
         V0/7p7Iwm+6eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 707D2E7387C;
        Fri, 17 Jun 2022 21:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] monitor/att: Print attribute information on
 ATT_REQ_RSP
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165550021345.3032.9932230059635448889.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 21:10:13 +0000
References: <20220617004957.1148939-1-luiz.dentz@gmail.com>
In-Reply-To: <20220617004957.1148939-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jun 2022 17:49:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints the attribute information on ATT_REQ_RSP to make it easier
> to identify to which handle the response is for:
> 
> > ACL Data RX: Handle 42 flags 0x02 dlen 9
>       Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
>       ATT: Read Response (0x0b) len 2
>         Value: 0300
>         Handle: 0x0030 Type: Source ASE (0x2bc5)
>             ASE ID: 3
>             State: Idle (0x00)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] monitor/att: Print attribute information on ATT_REQ_RSP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c53cb7be2d61
  - [BlueZ,2/4] monitor/att: Add decoding support for PAC Sink/Source Location
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5da3c0387baf
  - [BlueZ,3/4] monitor/att: Add decoding support for PAC Audio Context
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2bdb79cf8173
  - [BlueZ,4/4] monitor/att: Add LTV deconding support for PAC/ASE
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


