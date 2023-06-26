Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA7EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 20:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFZUml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjFZUmc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 16:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8951BC0;
        Mon, 26 Jun 2023 13:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EE360F7B;
        Mon, 26 Jun 2023 20:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A58F6C433CD;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687812134;
        bh=/KXyd21CfHb6rzo+c1XgD1UT5PbguXa+XvRxeJl+LEQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L5k0TFPrgdU0w6KY1en9+UavUbxblgQZJ5Xes4oreW1VXIhhuNhevPqLC8lc5NQan
         8yTP7hWp2VFwdKtDPfnIT2iWhBbjcmELjNPe7hmz6lXOLi39OBYmhRie6C8k7mMcbp
         IjTRkkMXG47G8cG8oWVbku54v1T9MBU5OtyHsVIEkWNVM+y4F5hl/frDIU51qYyJQO
         dY2ShfpvqF+EoczgVlmY89s2Nu4EgByXCB57NcQiG+MYF8Mtl9NT8q8A//Cvy2A2JB
         sUf3qVCg7f8zd7Vk9kK/T4Yjbz8jqF/DFfMYBkBDfID/gL+z1lsom43XvP7Vs9o5E5
         EsGj1oGfiaD/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B505C64459;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168781213454.29844.5739328500636012482.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 20:42:14 +0000
References: <20230624170810.298776-1-ruinairas1992@gmail.com>
In-Reply-To: <20230624170810.298776-1-ruinairas1992@gmail.com>
To:     Matthew Anderson <ruinairas1992@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Jun 2023 12:08:10 -0500 you wrote:
> Adding the device ID from the Asus Ally gets the bluetooth working
> on the device.
> 
> Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d5475f4a29c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


