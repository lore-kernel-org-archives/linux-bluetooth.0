Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 08:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiFCIKQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiFCIKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 04:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1439BAD;
        Fri,  3 Jun 2022 01:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A374C61605;
        Fri,  3 Jun 2022 08:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B82C385A9;
        Fri,  3 Jun 2022 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654243814;
        bh=FkMHg8WEZ4o2J7tkypIiyj9GCRg2XH36cSiAvTj9Fyw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CaVQKkXjmrdPp0WStNticswpDMOHTla/nQAdhxMgccbI95Gnwgj6wAnMFAh79xLrB
         ++GGCApx/KMqF0YN4PTQI5YiPkRW3J5fbF+DvJdyc/cnrhmNXTVS/6eBccmm+1KzWs
         81E9ETqH9msovc4uzk18lSD2QazUZpJNjk242B/ZgAhGKnimhgp4ZZDJi5NPez2OOB
         PjGIolN3aveXprkEuRPG8+r3Dy8CzkwIThV3UsADkhe1fPhYzPNgFdIEJjL8aw0zcK
         +5NrE4mDUHW0rR7KwKu4hTxCJUwZ32Iqh5cbvpofV30YInGugOK68rihHLv2ebrklh
         HY4E6P9hgW+hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7BDCF0394E;
        Fri,  3 Jun 2022 08:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Add check for
 platform_driver_register
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165424381381.15428.16896146545060114165.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Jun 2022 08:10:13 +0000
References: <20220603012436.3332620-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220603012436.3332620-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri,  3 Jun 2022 09:24:36 +0800 you wrote:
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: 1ab1f239bf17 ("Bluetooth: hci_intel: Add support for platform driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_intel: Add check for platform_driver_register
    https://git.kernel.org/bluetooth/bluetooth-next/c/822e1b3ca0fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


