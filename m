Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6340EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjFMVL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjFMVL5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 17:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1031BC9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 14:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D7D63AFB
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 21:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9423C433C9;
        Tue, 13 Jun 2023 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690712;
        bh=D5cdq3igM8gRE3zrAHRGTQU4pX8/uQVFWzBlnTgA4ok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Kxd27UmcbpltRQuSeVtS2mh98/r92tgprqgZjE1Ylnw1xClwbzoDDuuXTnuasPnrn
         TAbCsvE7IRODdwk5l21p7aSZVLMhUcKWgHvGsWUZI6URQFhz6KzkstOvmZM/BGs1hA
         wTYrlHem7wWhkWTqJ2BFFX8HxZindD3YRyveKvG156I3BpHqjVkx5u6Y533hYrVxMq
         ANZH93dYkGCEC1MUhldpiSgQh+XlJZVXxYtIGoKZ+5U41bqzpb05+wqfrdnY+9YQSZ
         0tirTb1PheHGoIMbYGtOXWVuA0VEcQnZDckvhiiB02uk5XL2sXHtcMEzhmm7m4mNRU
         bXpET9EOCLgkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDC6BC00446;
        Tue, 13 Jun 2023 21:11:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] shared/bass: Implement CP opcode handlers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168669071277.22478.4227831114978770735.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Jun 2023 21:11:52 +0000
References: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        silviu.barbulescu@nxp.com, andrei.istodorescu@nxp.com,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Jun 2023 17:16:23 +0300 you wrote:
> This patch series introduces opcode handlers for the following
> BASS Broadcast Audio Scan Control Point opcodes:
>    Remote Scan Stopped
>    Remote Scan Started
>    Remove Source
> 
> Iulia Tanasescu (2):
>   gatt-server: Check pointer before memcpy
>   shared/bass: Implement CP opcode handlers
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] gatt-server: Check pointer before memcpy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c0156edd198e
  - [BlueZ,2/2] shared/bass: Implement CP opcode handlers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ddd09531e936

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


