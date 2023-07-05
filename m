Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458FC001DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 23:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjGEXAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGEXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7281990;
        Wed,  5 Jul 2023 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9D26181A;
        Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAF4DC433CA;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598024;
        bh=m3io7ukx1kfDWn/qTp/iXxzEDzf1sw6ivsUxl+kAAKQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qh0gAHTmy32bR1OWHxLD38GIhOZapQhu/N9kiM16q72wMhiNJHhheTw8/mE6UdESy
         FI/m9aIGOeVTL+UKXMm30sqPEwDeyjd2uBtnYNw64yQQOiBRC4G+LJU6FYxOPi7T3Y
         Ol0uuzca9xuVL0/H48jLAY3aaLEnDAPfsVrzUe3xY3FYM29c+A0wNQucVyIm94goSj
         qZTwznIecYO2wfXeDZ9GtOAs/KdoTRV/fZCTCAOnUIr6D8UyXFDlY1pRKmG4Ad861m
         ypjQfwoR7h7T8OR4CQr0P4zC6MKicmcp4yNJKta4T83M6o185GaiMZFBoOaUHO3X+N
         FIvUHryMFwF2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1737C6445A;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168859802465.24898.1483765626079378080.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:00:24 +0000
References: <20230702210138.226929-1-valentin.david@gmail.com>
In-Reply-To: <20230702210138.226929-1-valentin.david@gmail.com>
To:     Valentin David <valentin.david@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  2 Jul 2023 23:01:38 +0200 you wrote:
> Asus ROG Ally gaming computer has a MediaTek MT7922 chip that uses USB id
> 0489:e0f5 and needs to be added to the table. Without this, the device is
> not usable and gives the following error:
> 
> Bluetooth: hci0: Opcode 0x c03 failed: -110
> 
> Output from /sys/kernel/debug/usb/devices:
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
    https://git.kernel.org/bluetooth/bluetooth-next/c/10912d85b17a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


