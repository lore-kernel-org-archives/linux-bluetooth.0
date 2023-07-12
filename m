Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD7DEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 21:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGLVU2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGLVUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 17:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EE1FD2;
        Wed, 12 Jul 2023 14:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C7761948;
        Wed, 12 Jul 2023 21:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA043C433C9;
        Wed, 12 Jul 2023 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689196824;
        bh=XzpCV7L+ggi2pYIN4/kiBvQmtWkPa45z6Dp7ndAAo+k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G4jiPgBvxdyFZPGbgupHO3CJPAduRRUe09GOZGO7Fh/T6AoOvp6uF3ZYViA/iTS/9
         g8on4Y9rkrwubaNg7bWV2oYZRI1D1w5LHmK1F7mH9EKAG+fuMS5HbRn7rGHb2MehDv
         wAMcbMgcMblApF1B4nOVxcJ7hLPYESL8os7Ub1XdwtYHKFBXRHB/FeY/1gI6NzHf5n
         coRm/n/ucNVEIwGu4Rtdm5LD2/P4R87y0w/UAdiHLLJ/iE+/LS91u219tneE1pUsZf
         RRZUsSUZ18cjbk/nAjUX/x7LI32QLUmmCCiLOxP7QoHoeXAqrArcnB2eQn8Lo/XW8q
         WJ+aXHrsmI33Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE88AC04E32;
        Wed, 12 Jul 2023 21:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in
 HCIUARTGETPROTO
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168919682384.17000.13075790266021679958.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 21:20:23 +0000
References: <20230710151723.15617-1-jlee@suse.com>
In-Reply-To: <20230710151723.15617-1-jlee@suse.com>
To:     Lee@ci.codeaurora.org, Chun-Yi <joeyli.kernel@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        yhao016@ucr.edu, jlee@suse.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Jul 2023 23:17:23 +0800 you wrote:
> This patch adds code to check HCI_UART_PROTO_READY flag before
> accessing hci_uart->proto. It fixs the race condition in
> hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
> This issue bug found by Yu Hao and Weiteng Chen:
> 
> BUG: general protection fault in hci_uart_tty_ioctl [1]
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff1b86784849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


