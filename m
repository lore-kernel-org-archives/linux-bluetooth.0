Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7950C4708B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 21:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiK2VL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 16:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiK2VLH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 16:11:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1386170470
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 13:10:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE4D7B818F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 21:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FD5C433C1;
        Tue, 29 Nov 2022 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669756239;
        bh=dSqq0IzMS/3VsJNRCfnTh8C4UYZM6gLS1JiCzStguzc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Gz2E6SbM9WhxnBv2jjf4Jz370Bij88geseHxMGdp3BM6Xm2U4nX0M+Rl00d2ycIpM
         Pt7JT8k+duT74Fc2TYgG0Dlrx5fxvmAKSS+00i65t4jRmG1VsuwBfgGZBqJnDT7Ycf
         fZ5LbHE7VgbPZghBuvPi/CBleVQB0v5gJRl6ujgdhMjfz8dgMca9rlBvU6UXm1IcTo
         ZF21+wwJtuOsia1yUqESnB7MLGaoYrUvWt3wyuGO9si4cpUvPn4vQQbZwQZYr2A4CZ
         2EfcJbqlHal2uoX0iJIejM7D6+vf6j7kOIW7VekqrmK3EzGtnt6V+tlDL3Sn61boPI
         /54aK39/nLckA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C013E4D010;
        Tue, 29 Nov 2022 21:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek RTL8852BE support ID
 0x0cb8:0xc559
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166975623943.18742.10071846249599231175.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Nov 2022 21:10:39 +0000
References: <20221123081005.70536-1-dukzcry@ya.ru>
In-Reply-To: <20221123081005.70536-1-dukzcry@ya.ru>
To:     Artem Lukyanov <dukzcry@ya.ru>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Nov 2022 11:10:05 +0300 you wrote:
> Add the support ID(0x0cb8, 0xc559) to usb_device_id table for
> Realtek RTL8852BE.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cb8 ProdID=c559 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2cdc5f0c9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


