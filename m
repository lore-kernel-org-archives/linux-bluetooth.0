Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FFC77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 21:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjDSVVq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjDSVVc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 17:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71B83E2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 14:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A769A642BC
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 21:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A465C4339B;
        Wed, 19 Apr 2023 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681939220;
        bh=PjW6f744HGGYtAgi0s5j1Q60gI4+c7D8WZVZJv40eQs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K/fHSPi0vIM3b8xnnCnfyl7r7nf3FoyZJAuw6t6tyRMM9CekJ/tmp2uTBdVMopaNc
         qWAKYBSVwn1d1GEeAc/oXPI39HMqNtYzW2CZ8Fiqh1eQxUhcpQrszxsdSnBrMKM6zg
         rhCnIs4DtypJ1OXEpLgg9k2aWswU9tRcE8p61KEltXxfIrgLuW9B7aXX5UdHI2XZRB
         8GyM+JCtgZCTZ/ipwIQWH6tvjYRQ4PQC+Iwc5vPORtBKo/Zs3ti2aIJI+2Rzuo+orN
         yk1B1ciIqxu2XV8GX3eY1hL8rTHorDN8CKj4YMJEYORpzPCB5akdUssGssmekZbhAi
         qu1F7Gq5bWq7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08F31E50D61;
        Wed, 19 Apr 2023 21:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Add additional Broadcast tests/options
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168193922003.10989.12119855597619141325.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 21:20:20 +0000
References: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Apr 2023 16:43:51 +0300 you wrote:
> This patch series enhances the Broadcast tests/APIs available
> in isotest.c and iso-tester.c, by making use of the
> encryption and the bcode parameters of the broadcast
> QoS structure.
> 
> For isotest.c, two additional command line options have been
> added - the user will be able to specify the BIG encryption
> value and to provide a broadcast code for the encrypted BIG.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] monitor/packet: Fix BIG encryption decoding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=180d1c9ad028
  - [BlueZ,2/3] tools/isotest: Add BIG encryption options
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce1eb5dd0a03
  - [BlueZ,3/3] tools/iso-tester: Add Broadcast tests for encrypted BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b56479f4f5a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


