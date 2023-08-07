Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B4C04A94
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjHGWu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjHGWuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57245100
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF51622E3
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33584C433C9;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448622;
        bh=3PWEuDlgmHIee2Bqas5J/TeWLZQEcwRGoFm8OO9bWLY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J9LivOuiCrlPB4WPmMJ08WT666SM6DvlKd9tP244qDFlPI3aWJMVpbwg8UA0XcCau
         3mHjfjrwNcEhp5ft4yf5+d6/r2iZG58lfSCHJo7EgO0vrNb4hIj8n99Ylq+sTRPt3x
         3w5Fh5QPIwbddZr1o17Iy6brmh9UdDLHf1n6oAaWBq726QUsdkwE8zKWzJJf26cTaR
         8zUzZElFBYM+ELGhAnNermHEA/JkkOrW6OYtIg6ASxQlujDCGYm0jNOwgmvsu8Kdj2
         ZRgrqo/RfJv0t2O1cpqwEcZl1DNHoLN3ifSEmJcz4s8Mvd+JJZcGTnDLTVaNPIGbEm
         LC5NIyxte+2Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18965C73FE9;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Remove unnecessary NULL check before vfree()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169144862209.1999.1134689356839449627.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 22:50:22 +0000
References: <20230807023206.2128846-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230807023206.2128846-1-william.xuanziyang@huawei.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 7 Aug 2023 10:32:06 +0800 you wrote:
> Get a coccinelle warning as follows:
> net/bluetooth/coredump.c:104:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Remove the unnecessary NULL check.
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Remove unnecessary NULL check before vfree()
    https://git.kernel.org/bluetooth/bluetooth-next/c/1ec3506d79fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


