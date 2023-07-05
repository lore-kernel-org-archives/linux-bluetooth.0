Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C29C001DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjGESAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjGESA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F66198C
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC794616B6
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F24C433CB;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688580025;
        bh=PgNxsOJf2eJtezWz1voOaYmP2iJIA/qVGoNChbiPakU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BaaRBHmzViZWTUU9dcnCATmFiTUQPinHPO01UsxJLRDLyzZYXmMBNQcafrBUcIxYa
         wku5+9BW1pPJY55JZZUDqmYGAsMbTIf8nns+twATFEud65mkKEoVAxbGmF34ljVsK1
         tB7tl4cH+h+NQT+d7S3CbbpKwtq79DHA9tdnpSdagptepTlPXp8AM+AlXSiU3couHH
         yZjyq6DGFNPTRJy4YFkgzN/UedNaUSr9FUpDtbkT+0vnI+gtni5004EUqel+drEhpg
         FGRqQNPDY5dEYgMJrOduM2NSSUQfE6KxihS7Q9Cvaq73FMoRlG87fDVQXlg+01f91i
         oJ+PKd5iINaGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B872C64459;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: detach io for source ASEs only after
 Stop Ready
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168858002504.7518.9584432839192702711.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:00:25 +0000
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
In-Reply-To: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  2 Jul 2023 21:43:04 +0300 you wrote:
> The Client may terminate a CIS when sink is in QOS and source in
> Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
> Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).
> 
> It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
> Stop Ready command if CIS is already disconnected, and then gets stuck
> in disabling state. It works if CIS is disconnected after Receiver Stop
> Ready.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after Stop Ready
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b10e72de6f4
  - [BlueZ,v2,2/2] bap: wait for CIG to become configurable before recreating CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c3170190d6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


