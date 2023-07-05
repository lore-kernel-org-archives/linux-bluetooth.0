Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B2EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjGESA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGESA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C4173F
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22C8616B1
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E4F7C433CA;
        Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688580025;
        bh=y9rQC63hcAy7rJpSFUwPXIs3orGRKihsUhyMM3YT9zQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y0jRP133qeUWXPNkCRoAXIz8q/dsryiWCmSXju8pFyeh1M4Ti7q/eMUM3hIzUATMr
         auE1ddK5zv5Uorr2eU0Its1HueLbHqqtka57jLejIurc1jszBkSGK/ZGYkm2u/Gu7k
         UUIo+l82gN2+v3lpev0Ri6+rq6KGTzeETGK4lehojyJJ1N/vrJUAzQRp7rrFEpLCaY
         lJWu7Ucv4BeV+WZB3wZNaxR6qaruh5Cznr1eIy7OsplGvgocJZ6OKkJgWvwKF8VhHL
         57jJ982fczQ/YVf8K9tSjpH0OQSTVIY1latciCBAtIycjV6aAEOOLH0CB3PgHYmRRk
         tbkKoXIxAEC8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE318C395C5;
        Wed,  5 Jul 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] transport: handle BAP Enabling state correctly when
 resuming
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168858002496.7518.8837283986593270105.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:00:24 +0000
References: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
In-Reply-To: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  2 Jul 2023 22:34:18 +0300 you wrote:
> If BAP stream is in Enabling state when transport acquire is attempted,
> we should wait for bap_state_changed to emit the completion event.
> 
> transport->resume() is only called with new owner with no
> owner->pending, and shall return nonzero completion id on success.
> Currently if BAP stream is Enabling, it returns zero which fails the
> acquire operation.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] transport: handle BAP Enabling state correctly when resuming
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=466fce0209a3
  - [BlueZ,2/2] shared/bap: use only nonzero req->id
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8fd0c76b41d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


