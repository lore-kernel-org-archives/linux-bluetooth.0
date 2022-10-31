Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A35FA3741
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaXKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaXKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91515806;
        Mon, 31 Oct 2022 16:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3621614E5;
        Mon, 31 Oct 2022 23:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23108C433D7;
        Mon, 31 Oct 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667257816;
        bh=ZMIoRfYnbzb46WivSxsiGy2a3pilLAniv/pIUSFDcbU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qwBWUMLd/Pamb+UDwLlYZDcbcfob3QjcZpmhcZJCcCTwg3iTUHp5SW2NPtWg9Hc1l
         f9hT2I5dhOxaes94JSJuwBt0zq9PAN6d6fTUSwg5fRIXp7mnLxqiP70qRhebY0UZY8
         gAWKsssZo3BRm52XNaMx7LJ/vi91xx1dJK5sy9kEtYloCQNKaMECBzyJw1CzxHMewc
         A5XjTBU+dh3dhGmBhJYfkjIjsZFXmTsWDuFwxcCeOKRN90AtowYX4DR0WODSvLis7h
         U6psO4+4ZJLpqAUEj/QAmDlpLqN/WowpgNVHs7Rf5Egq6RTHHZHO9ujs46+2v4MajG
         QqLsS7ssOluCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05D84E5629A;
        Mon, 31 Oct 2022 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Use kzalloc instead of kmalloc/memset
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166725781601.15466.8966753850530203194.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Oct 2022 23:10:16 +0000
References: <20221030181722.34788-1-tegongkang@gmail.com>
In-Reply-To: <20221030181722.34788-1-tegongkang@gmail.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Oct 2022 03:17:22 +0900 you wrote:
> Replace kmalloc+memset by kzalloc
> for better readability and simplicity.
> 
> This addresses the cocci warning below:
> 
> WARNING: kzalloc should be used for d, instead of kmalloc/memset
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Use kzalloc instead of kmalloc/memset
    https://git.kernel.org/bluetooth/bluetooth-next/c/214c507d87cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


