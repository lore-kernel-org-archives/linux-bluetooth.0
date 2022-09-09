Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9FECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIITaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiIITa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 15:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965197B3C;
        Fri,  9 Sep 2022 12:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DA1B82627;
        Fri,  9 Sep 2022 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08469C433D7;
        Fri,  9 Sep 2022 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662751817;
        bh=TlR5KkdKFGZEA3IVTZd6lKfqF7mgIKXOnZzTEUCZlvE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s49j/z2MegOyfjiF+cd/XOyEPA+aOWDq6rAVy509zPAAoguzoTvjHvjcxm0NBcRXW
         +ns9TWpkTQ2hN8zitTFp0aF6ZtHan15j1OepuokEG5+4C+uZW2vDl4JWXhdaZXPFcm
         QI3wW3PUyb8SGNou5PoO4Fe2mSWnQA3kBvNIQUTFq4KlkAiQC0p0HvCGELdiHn4kNt
         mYIL7BDIXn6aQUYh11pRzvTTmGr6pjG53rVHqlngILghmvXrxh/+7dEZqXPTMinZNX
         3KhAKQlBKn1pY3FyoFUl8B1jYZeCEKVHE03JsyNkXwjaQFcbSy5ZfMkNqNBn2wx18M
         tC15R/g8ZSdug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDDEEE1CABD;
        Fri,  9 Sep 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add a new PID/VID 13d3/3578 for MT7921
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166275181690.14413.3140542582465641512.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Sep 2022 19:30:16 +0000
References: <575471871695aaae73ebc15eee73411ee53f4bb4.1661596165.git.objelf@gmail.com>
In-Reply-To: <575471871695aaae73ebc15eee73411ee53f4bb4.1661596165.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chris.lu@mediatek.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Aug 2022 06:55:58 +0800 you wrote:
> From: Chris Lu <chris.lu@mediatek.com>
> 
> Add VID 13D3 & PID 3578 for MediaTek MT7921 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add a new PID/VID 13d3/3578 for MT7921
    https://git.kernel.org/bluetooth/bluetooth-next/c/a614ee94a849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


