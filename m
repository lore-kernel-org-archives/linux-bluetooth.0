Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5806C352A1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 17:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLFRuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLFRuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 12:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCBD209BB
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 09:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1072261825
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69DAFC4347C;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670349017;
        bh=K2aL6DXKkgnc7m4YWWTv46jr5AaDXzBdKsq33xgbA78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iFOU+/19klGP1PZTjNEVVnAAQNf4oAwbpNu9wZS6QXNH7+0g215p8yL3rcNhmDRO6
         Y/N4vsUi3WX7cw0YZWh3SvTsm4h2zA/BgxeVjT44bMyUihedemEV9SxiVVbMBXZ2/A
         vzRzMQJgnEEVe8hFmR5yQf173xTXD7AzxftOEfDlNRYMbIGg3zrca4N1d1aIFVFrnw
         a71e8RYPt/epQj4CFtzuJzlIMHQRu2hz7JenQVS2TgI0WH8sEUhpX/I8CXt4pjnZVD
         xxiX2DCuhmxzd+gHmq0DJm0ztYwEp0Vpz1JItCwgWteo+9qvB2RNzeukaWfFIm+agH
         2uf/jZ3zKl1ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 448FEE56AA7;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix crash on hci_create_cis_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167034901727.25798.1401857245889634003.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 17:50:17 +0000
References: <20221206012323.3684462-1-luiz.dentz@gmail.com>
In-Reply-To: <20221206012323.3684462-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Dec 2022 17:23:23 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When attempting to connect multiple ISO sockets without using
> DEFER_SETUP may result in the following crash:
> 
> BUG: KASAN: null-ptr-deref in hci_create_cis_sync+0x18b/0x2b0
> Read of size 2 at addr 0000000000000036 by task kworker/u3:1/50
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix crash on hci_create_cis_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/a49cd3f381cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


