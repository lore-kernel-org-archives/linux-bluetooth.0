Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7352C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiHVWuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWuQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ABB50050
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CAC461369
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE100C433D7;
        Mon, 22 Aug 2022 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661208614;
        bh=YhQVjDat3coMk2FSkPAknLHv+hUlA4uZp+uqs1/sMBE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VROODDcMwmCD/YVYG08POwjXdHdobjr8VpAi1igeSPEQoPugrVPCbO8vN29jo92LP
         szlGw/CZKf4ANGwJ+bJv6udJBeQCnadJ41izN2haMZA9ylXp2mkShcPbHcMZu4ZBSV
         gQmvjOl0oM5U0FIRjsvhO4eDAPLLCkoVsGtoXLJZTyCLJnUVqbxjfsdkq9GuuLXTKK
         /vQXXW2GShYn2js4tYD8prrZMT368Jq1aceDwu1q+5N70GZgg03b6fycgrybu3iL8b
         KAzd7AXPc7gh/0usZIJMxcQup3Bibu3k2pHBse6ikK13VoZueOP2Ffx16cplDPILlo
         IFjp8y+mOwXcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D604E2A03C;
        Mon, 22 Aug 2022 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] shared/util: Correct UUID for Microphone Control
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166120861457.16109.15076071818169587683.git-patchwork-notify@kernel.org>
Date:   Mon, 22 Aug 2022 22:50:14 +0000
References: <20220821160248.3481431-1-kmachanwenw@gmail.com>
In-Reply-To: <20220821160248.3481431-1-kmachanwenw@gmail.com>
To:     darkhz <kmachanwenw@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Aug 2022 21:32:48 +0530 you wrote:
> According to the Bluetooth product specification list, the allocated
> UUID for "Microphone Control" is 0x184D, not 0x184C.
> ---
>  src/shared/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - shared/util: Correct UUID for Microphone Control
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4760ada065f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


