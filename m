Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E40AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 20:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJKUuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKUuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 16:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55722A410
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F6D1B816A9
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182C5C433C1;
        Tue, 11 Oct 2022 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665521417;
        bh=9qmelDB7dLVWd0raASz4PlkXGvX7/TkVFU6MrISbaUQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bdI+gY8cOXtL7WOb/gLPQtjQ55KVq6rs1sC1+96+cMnX2ViJg+rO7etxwDpOK3/I9
         1RKBwYxDJM8HxpkMFoARAjZ6na66f1/sWj74274oxqzS6Co51dhhX4vmDPo7G/dMoJ
         nupABefklgqtxRiP3gKRQRFzYH+lUCBbBNgSImqdLoLSm1wdXahR5TCwm57Akuig/L
         j9fQa/GzyKXt0Put6w4goiRJliYOg75fWxsIYyuiv1b76gSgNOH81j0yc6Qzp3sHMB
         ksZDA/to+G+qHnNhWL0NTz437vCuOez4MbDnT96gm+Iu9JMHCcNBwFNK1O+UTtM17w
         BSQ5/8HibkLtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2900E29F33;
        Tue, 11 Oct 2022 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix CIS connection dst_type handling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166552141698.15349.13183520200083892484.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Oct 2022 20:50:16 +0000
References: <20221009174216.17533-1-pav@iki.fi>
In-Reply-To: <20221009174216.17533-1-pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Oct 2022 20:42:15 +0300 you wrote:
> hci_connect_cis and iso_connect_cis call hci_bind_cis inconsistently
> with dst_type being either ISO socket address type or the HCI type, but
> these values cannot be mixed like this. Fix this by using only the
> socket address type.
> 
> CIS connection dst_type was also not initialized in hci_bind_cis, even
> though it is used in hci_conn_hash_lookup_cis to find existing
> connections.  Set the value in hci_bind_cis, so that existing CIS
> connections are found e.g. when doing deferred socket connections, also
> when dst_type is not 0 (ADDR_LE_DEV_PUBLIC).
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix CIS connection dst_type handling
    (no matching commit)
  - [v2,2/2] Bluetooth: hci_conn: use HCI dst_type values also for BIS
    https://git.kernel.org/bluetooth/bluetooth-next/c/4d12cd187c82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


