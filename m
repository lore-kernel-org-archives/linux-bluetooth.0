Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34743C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 00:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjFFAgJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Jun 2023 20:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjFFAgH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Jun 2023 20:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B0EA
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 17:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD30762BF4
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 00:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250E3C4339B;
        Tue,  6 Jun 2023 00:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686011765;
        bh=yIesLC+hu0MamvZ+Xj58+7hUqD8ObtDUOk5djfVXd0w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nV7HeQ+s3TW1J84psv/8uC+TZYC5XCRhxOadbVqFB02TIXO2IW9nZeuhipYPIXOzj
         bxvhWYIp7dgH7ZTeY06lX4H5jlNRtia9WIgqK2vCthJU7j74MPXW/HkP99Y7ROIf3I
         lR1ZM6Glwp27gLeLvYkSHHgrLYwz0pkAjn+QbpMjcGc4UZympMW6O8VsZEJVZLr5re
         CbNtjZpBJJxyydu1VbZxo9hV9GBe0lc0fmtLQ0km5VhH9TER7TLvfX25ZN6lKlGhYd
         5o6+XKXKB/YemVMmyGDF7292zhdFb+LjVIZqdNYWq3j/aEQeIVS5k8BmwUjQ4xHZ64
         jirfeYQI3aFyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 051CFE4F0A7;
        Tue,  6 Jun 2023 00:36:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-05-19
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168601176501.31462.8894416742474090660.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jun 2023 00:36:05 +0000
References: <20230519233056.2024340-1-luiz.dentz@gmail.com>
In-Reply-To: <20230519233056.2024340-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 May 2023 16:30:56 -0700 you wrote:
> The following changes since commit 9025944fddfed5966c8f102f1fe921ab3aee2c12:
> 
>   net: fec: add dma_wmb to ensure correct descriptor values (2023-05-19 09:17:53 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-05-19
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-05-19
    https://git.kernel.org/bluetooth/bluetooth-next/c/67caf26d769e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


