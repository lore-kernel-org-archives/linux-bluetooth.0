Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA4FC71153
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 18:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjH1Sk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjH1SkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 14:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829FB0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 11:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D2763D35
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 18:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45487C433C9;
        Mon, 28 Aug 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693248022;
        bh=h0tvWjgMhE5hWtX/1HGWEstm11whlkCcZUfIH3SSXio=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=op5ouQH9oiwCq+Zm9D6NUVINRU8xr4W1XI8kNQcu3GT6pzyDAEinejMM0x1KRQ5TU
         tCbeW9BCUk4KHvXdhMEPBGvrh2U1ds2BQM8+dJyYlcVhhV/uYRIWKhjm0DMrcI4Uht
         gRI6Lr4G2U38nYeVUWnwKCQmrB0JUL8uAvHlfDEqioXOwDLg28SxjC0AJFv+u5Ik8a
         HcjjKreRI7nxoW09lpXJeDYG/ODmAyjn1cvLp/IUEZGiqK1cz5iWPRuQIWyJ+Zwt8h
         3puyZu+m6iQZGFCUDvGAjBovdI36TIWF8B/tzi6wMG3MAgbJ5P9iEaXRqnxtmC+bzj
         qoj/WC6zgP7sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A92CC3274C;
        Mon, 28 Aug 2023 18:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: Delete unused hci_req_prepare_suspend()
 declaration
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169324802217.12509.4273308236519479462.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 18:40:22 +0000
References: <20230826081313.3431523-1-xiaokeqinhealth@126.com>
In-Reply-To: <20230826081313.3431523-1-xiaokeqinhealth@126.com>
To:     xkq <xiaokeqinhealth@126.com>
Cc:     linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 26 Aug 2023 16:13:13 +0800 you wrote:
> From: Yao Xiao <xiaoyao@rock-chips.com>
> 
> hci_req_prepare_suspend() has been deprecated in favor of
> hci_suspend_sync().
> 
> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Signed-off-by: Yao Xiao <xiaoyao@rock-chips.com>
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: Delete unused hci_req_prepare_suspend() declaration
    https://git.kernel.org/bluetooth/bluetooth-next/c/12299967998d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


