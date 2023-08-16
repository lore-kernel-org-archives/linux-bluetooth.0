Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A52C41513
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbjHPTUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjHPTU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 15:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F62272C
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0527623E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 19:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 197B6C433CA;
        Wed, 16 Aug 2023 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692213621;
        bh=PAKM+2JiMUUW5BUIV/kFLKRonqI+dETqWF61b1BsQLs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gA+qHR5srnzMILk86qrMvH6jyiw+bwNeIkOUSUjhXjF+SCFRc+/3O9gz7hbC+ZAAE
         NUygcpJ8it2Sg1PvMst/AfoAQQBxrWlj84qoVfUaKb6ks8MK7oQDwmL3qT+HtgPnS+
         rW5DxWH/wWYzbSQ46atDRGjznHxfxHPK4jCkChT4fSMHpcLtdv/5EvgVCntp+XiOyQ
         +0Gf2xzd2AA6cQJplJSCJ+SNvKTMDmelNHx+jVvqF2W6/IywW7x2mvfHfIZKqMRJlS
         v48afowZkrreuF3DZzxVZ4q15hQfOTT6Fd2C2xtnDWi5/IFI9k2HVVcqdwXiPhONFx
         fjc7u2I/Po5EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3730E93B39;
        Wed, 16 Aug 2023 19:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix sending
 BT_HCI_CMD_LE_CREATE_CONN_CANCEL
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169221362099.4169.5061483289978372460.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 19:20:20 +0000
References: <20230815221803.2491905-1-luiz.dentz@gmail.com>
In-Reply-To: <20230815221803.2491905-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Aug 2023 15:18:03 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL when
> hci_le_create_conn_sync has not been called because HCI_CONN_SCANNING
> has been clear too early before its cmd_sync callback has been run.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL
    https://git.kernel.org/bluetooth/bluetooth-next/c/5109ebb80dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


