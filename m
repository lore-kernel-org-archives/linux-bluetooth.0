Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750FACCA47E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiFBPuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiFBPuR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63F2E6B3
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 08:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C8BCB81FB6
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 15:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A250C3411A;
        Thu,  2 Jun 2022 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654185013;
        bh=3IcmI6aTuTaZ9jT8NsJcigQPndxrKj7HswxoA95i+34=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LodZVhqVBaO0Y9KZXYE+Gsj34bPo+ScTnpLKOMXipjuB+ygTgs0si4KFi0Yv4MHuI
         nJj9tlHJJrakJQrL+YBnZ0gjxoUGpPKj8k50ucUK35Fyq8Qfnt/qo9SHd6B08PgUt1
         wBdY7w+KFZzmP41m9Bt3mxr+HN7iXGHIHbdBkuUNimtAaLgGeHU9ZMNMkEMwydwa8P
         S7Y46o6MneFOas6n5tdhTxDD/WV7xdh6EGRgdFpu8pkqu4kA4ZQXiU5AZ5hBkRYK7p
         iGFTdXqtKeoKCufD8YyVcKa/P/LOMABnF9T3G9W3E55qtMwDrGS1ve3GOBX9VmOCol
         6npDQBujhdEDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDA51F0394F;
        Thu,  2 Jun 2022 15:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add support of IMC Networks PID 0x3568
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165418501290.10758.3267160679920762449.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 15:50:12 +0000
References: <20220602092822.953521-1-aaron.ma@canonical.com>
In-Reply-To: <20220602092822.953521-1-aaron.ma@canonical.com>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu,  2 Jun 2022 17:28:22 +0800 you wrote:
> It is 13d3:3568 for MediaTek MT7922 USB Bluetooth chip.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3568 Rev=01.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=...
> C:  #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add support of IMC Networks PID 0x3568
    https://git.kernel.org/bluetooth/bluetooth-next/c/d60ea31cb434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


