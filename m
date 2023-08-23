Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96BC3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 21:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjHWVVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjHWVVQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 17:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289B10E4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 14:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D899665E89
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 21:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E50FC433C9;
        Wed, 23 Aug 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692825624;
        bh=83DXrjL3lUhlsI5hlFVdzSFgCl0xwmwWiBmfDOdAf4s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KqqaInyBiDyYAlhqnvZyJURogZbvLVqXwWZO2jtHQin5N82998ue+FtXqOJR5MBEz
         hVZLLiNpt87D6ilI84z7sTMQ79jeXdcn+KJ2Ty8zjgU3UzOYTaqehPj9Sz8Oiqx3+v
         jlzAIb9quKNYApQTALxsuIZxiUoXh9QuUpSOqnVc8jGJH1yAPedIh9WQYFJzzN1puD
         K0Ei653DTOVWHL+zhyPbLVRyaM5e1X1ysO+gakc+4IeNVSWKwZiK74K6PiT68uNVc+
         nU3dVLWPjpVuEHhDVRk9fMRFfag1oYvkv4+nIew5+BOX1sfxWrcjP6KeBCxchw8Wq8
         2+6oWkVfnp05Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 036ABE4EAF6;
        Wed, 23 Aug 2023 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169282562400.8293.7219728296935052147.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 21:20:24 +0000
References: <20230823194128.3893244-1-luiz.dentz@gmail.com>
In-Reply-To: <20230823194128.3893244-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Aug 2023 12:41:28 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces HCI_QUIRK_BROKEN_LE_CODED which is used to indicate
> that LE Coded PHY shall not be used, it is then set for some Intel
> models that claim to support it but when used causes many problems.
> 
> Cc: stable@vger.kernel.org # 6.4.y+
> Link: https://github.com/bluez/bluez/issues/577
> Link: https://github.com/bluez/bluez/issues/582
> Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
    https://git.kernel.org/bluetooth/bluetooth-next/c/1098ecdb96b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


