Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1294EB64DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 18:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFTSac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFTSa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455510CE
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 11:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3F061414
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 977CAC43391;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285824;
        bh=OpOAp0u3hZo71CxoyRij4k2JxaEHyVBuhk9twys2TiY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O/4eajzh0cOpHCWoJRE/2RCYXtozBZDYucOoqELSFT6i8LIWhhJaLnwPmjFkdLc2v
         rhK8xejRpxN6PmLhBvCEZlGvKYpb+Aj2WTVj3GeAwY1wUuccJ780fjVwF5SiCCw+SZ
         mi/f1QtlR+xRtQClZMPO9gINqYR7BhG1kyy0LcM+LWtNu61J++p8B0x+HQ7laLSHL/
         6oujl+C5BE/lUIQNnRUYcKH2JHNhr+W6LzWe4cB3SdqHuNMg+w6XNGj5UC4ZkVYVLr
         QsAh/dxk0DrAfI6f0cEJMPB/P3iLll18SoDBgJ+0cuGzZ+zbcE9daKANDvuK0J41A7
         5wLtu3BWPAEBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB7FC43157;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Bluetooth: ISO-related concurrency fixes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168728582451.12887.926313891118140370.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 18:30:24 +0000
References: <cover.1687115142.git.pav@iki.fi>
In-Reply-To: <cover.1687115142.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Jun 2023 01:04:30 +0300 you wrote:
> This series addresses some concurrency issues (NULL / GPF) in ISO
> sockets or related.
> 
> v3:
> - Copy the pend_le_* lists, iterate over copy to make it simple.
> - Rename to hci_pend_le_list_*
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b48b117e516
  - [v3,2/3] Bluetooth: hci_event: call disconnect callback before deleting conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/e61a5be1d421
  - [v3,3/3] Bluetooth: ISO: fix iso_conn related locking and validity issues
    https://git.kernel.org/bluetooth/bluetooth-next/c/d9687da53dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


