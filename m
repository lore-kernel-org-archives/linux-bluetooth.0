Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF64CA1009
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbjIEUIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbjIEUIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FA180
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 13:08:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE20C433C8;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936913;
        bh=S97CeyjQylgOgWUlDQTJX/HpM1isp5mNC9pm1T27xkE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Kqq5GLCx0Xh3wuvtMJIAHCKQMaYTA7tB567uHRQrt8ql07Gx3B8X9W0JdftjUSZKX
         imVXMspeMB7N3SisKz63Rn270u9xdBtIHsM6+t51VHA+r7NUKitYuQO+in+o7KAVaB
         yb3ISs8tplDs20NF/HjmYlbNQcIaDoJHH5LjnYVX5vjL1TjaAmHkFZigShIwMQBmc3
         I5mEOB5cvRRDdHIEj78PijZgKaZozvy4z6U5deov8CjfF5A/Hncwp/rlp8rI04o8nE
         MPAsQHvhb/sprqWUjB0HRKjn+pN+s3C82KKvhnkLF4y41zsl4Po5nv3nBcKzDaAuEH
         ftqPv2kCVWN9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EDD3C2BBF6;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Fix handling os listen for unicast
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169393691344.22693.14806608244671851987.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Sep 2023 18:01:53 +0000
References: <20230828200345.579455-1-luiz.dentz@gmail.com>
In-Reply-To: <20230828200345.579455-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Aug 2023 13:03:45 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iso_listen_cis shall only return -EADDRINUSE if the listening socket has
> the destination set to BDADDR_ANY otherwise if the destination is set to
> a specific address it is for broadcast which shall be ignored.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Fix handling os listen for unicast
    https://git.kernel.org/bluetooth/bluetooth-next/c/2595dd981e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


