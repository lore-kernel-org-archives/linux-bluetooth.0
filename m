Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EBC761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 21:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjC1VA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC1VA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 17:00:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010E1BFF
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BF39B81E7B
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 21:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9168C4339E;
        Tue, 28 Mar 2023 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680037218;
        bh=66nqd1I1LNhS9t8n72D5KTxbUkansUBUr3Y1xic6fV4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RFUHV6gvlzTu6kI/qE5bulyTZrdiDg2riG70XUVdckny7awY5hiJaaSrcYEaOfbde
         BM6Wsk+1iA3lCxmrBbRolDQI0Bh+b6WyRXbTLWGjmNyiYP8v48Im9sK21l1JVmXB3U
         2hYGTiqcmisHk3v945DMsKI8rkVKwp550mQNNFUa5g17s2H5vjpYAp8YY+0APxybGE
         Py840ATOMjUg28RuRpeqwPsRvyIha7DZXH9+Afr9Amf+P9yMlZmpiOHB2IVn8E2JGO
         H+9ZNw/Pec9Ixj3PCBTj5f1uM67hadKTRFt2yAVHmJ3n+KpZBNu1XKCJrI4wAHFCLh
         QXwHyb2Whyyyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0FCFE4D022;
        Tue, 28 Mar 2023 21:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] Bluetooth: Add device 13d3:3571 to device tables
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168003721885.12776.13811491148580419424.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Mar 2023 21:00:18 +0000
References: <20230323174604.30088-2-Larry.Finger@lwfinger.net>
In-Reply-To: <20230323174604.30088-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Mar 2023 12:45:47 -0500 you wrote:
> This device is part of a Realtek RTW8852BE chip. The device table is as
> follows:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3571 Rev= 0.00
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
  - [2/2] Bluetooth: Add device 13d3:3571 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb3248d369af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


