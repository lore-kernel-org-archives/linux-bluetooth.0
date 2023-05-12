Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E61C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 20:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjELUkl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjELUkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 16:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A326B3;
        Fri, 12 May 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5477654D3;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 176F2C4339E;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924022;
        bh=V0pMFVHAuJqDt1SaxN6ONTrEJHicTlCt/hIc5lto7C8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V7hnWvea0feVqMTFe9xd3VMmP1irAJ3zB6hpb59v8YHpx51sLF4MvCW9xRj3+nh2i
         yp2ptJVMgoeUDmLv7yAEmeVCYunwFf96K8lhOekdvzs3N03fak1s2GcOcKBi6qgoWF
         rRAo9ba+wVmBNQvsSCGy37/1/wc8TvU0SrAamJiCHPf6jsvPzXXsCDy/NlcH1qB7G9
         nx0SPaucp27xBOsydH5GQClURqm2EErPbsLMmTXbybqeJXdwIxCt8Jnws52u41D6kZ
         W2JUgpNwtL1il2WuzRXMmNyqgkk6Y6yMvd1mkHWT0OT1j0oFVrELysjdrJrMYVXQah
         qyvFeRonUFNCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7A13E4D00E;
        Fri, 12 May 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: Add device 6655:8771 to device
 tables
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168392402194.13139.16401468603783736020.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 20:40:21 +0000
References: <20230509194524.9361-1-dan.gora@gmail.com>
In-Reply-To: <20230509194524.9361-1-dan.gora@gmail.com>
To:     Dan Gora <dan.gora@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 May 2023 12:45:24 -0700 you wrote:
> This device is an Inspire branded BT 5.1 USB dongle with a
> Realtek RTL8761BU chip using the "Best Buy China" vendor ID.
> 
> The device table is as follows:
> 
> T:  Bus=01 Lev=01 Prnt=02 Port=09 Cnt=01 Dev#=  7 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=6655 ProdID=8771 Rev=02.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00E04C239987
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: btusb: Add device 6655:8771 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/376b10586124

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


