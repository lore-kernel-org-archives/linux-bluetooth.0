Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18EAC19F4F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjHPTUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbjHPTU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 15:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C12712
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C58F623BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 19:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DDC2C433C7;
        Wed, 16 Aug 2023 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692213621;
        bh=FpxKyb1jjkOtJ2hs651XCc3bsTwQ/A3BICEGHmW/gh0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eVFsgSjMva9zD+5CZ+oOr4VNnJJtlJy5rpFKBqaUA34HqkoDseabZ9nlCwcy4GOlH
         9CQ5KDv/LpxXwSjf5S1kSdULxuEjrNNO7Yx7h/QYZ1wzPXd/w0aG4d+CIsZ+H94PfR
         4aU980lKtcC1yCxh0nP8jFAvmxrww08BeujMexE74kiid6ivQvvLehn2A6jY24HxeJ
         O2Gcm50MYBoayqVhtsRzPWyQqpdpa40dTb1H/kYI1WYO72FqvqxXJ0ZhUkXvd5oS7U
         yoVNLve2PdQOm9QEeEWgcWwuAxnd58zGPT48u9jOl4KWE8xv935Y/2yhLIzIFy+IVR
         6/KiYzE3UlZug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EADA7C395DF;
        Wed, 16 Aug 2023 19:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169221362095.4169.6105116612298394879.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 19:20:20 +0000
References: <20230814190101.2302448-1-luiz.dentz@gmail.com>
In-Reply-To: <20230814190101.2302448-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Aug 2023 12:01:01 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Use-after-free can occur in hci_disconnect_all_sync if a connection is
> deleted by concurrent processing of a controller event.
> 
> To prevent this the code now tries to iterate over the list backwards
> to ensure the links are cleanup before its parents, also it no longer
> relies on a cursor, instead it always uses the last element since
> hci_abort_conn_sync is guaranteed to call hci_conn_del.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/45c37c4e9c9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


