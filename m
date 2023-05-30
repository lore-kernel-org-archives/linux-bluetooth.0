Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F4C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjE3SkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjE3SkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 14:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB71A7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25476272C
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23B20C4339C;
        Tue, 30 May 2023 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685472020;
        bh=5BqumEWD9r5KGfvEZnGb2L05rz9TxyrcdYJxHPXNQ/w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=akIxcAv345HgJPdtsHBT5QHKuYeRvp66JxqKTVaG/01KOb+L9wfZUuDJGiLO4rypt
         bNjecwa/IzK4crHpUe2jE9/zsY+X1DoPuC4UDtYNSvzJY/M+sLUHbuEspk4FaZqkmJ
         qXaGYdzalflO2Zj+KZ00YPOUviogSSM8wjhJCMQEq5ELuv5JxIS4yZ41wpjO5JOBO+
         nBTEBEyhS6a8NvW6J8LXD5RZc/9vlNXd92fhmKnvHnJ9ptBnr53HkdhHr+LaTeE6FY
         p2Jn/8slAxpfWOvNq6ilr5B07N4tTcI4SUmKs9fKTZawYy5+JtwgysjpvUJbz1vSA9
         o6QW+uEx54zzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBDEDE52BF6;
        Tue, 30 May 2023 18:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] iso-tester: Add tests for AC configuration
 reconnect
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168547201995.19352.12361626441351252422.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 18:40:19 +0000
References: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
In-Reply-To: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 May 2023 17:39:13 +0000 you wrote:
> Add test for reconnecting a CIG with two CIS, either both with same peer
> or with different peers.
> 
> ISO Reconnect AC 6(i) - Success
> ISO Reconnect AC 6(ii) - Success
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] iso-tester: Add tests for AC configuration reconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=000c2012f38a
  - [BlueZ,2/4] btdev: fix inactive CIG configurable status
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8b927e34733
  - [BlueZ,3/4] btdev: check LE Create CIS error conditions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d214fe5f7522
  - [BlueZ,4/4] test-runner: enable no_hash_pointers=1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15eb57049b19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


