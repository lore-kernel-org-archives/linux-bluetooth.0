Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431AEEB56E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 20:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbjIHUub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjIHUu3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 16:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CBA7
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 13:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDFCAC433C7;
        Fri,  8 Sep 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694206225;
        bh=BvlEcnESsevXKnAz7rl8A46jTef1ZZHATBDq9hN8j9w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NXEpkDT1D4G1txnqXWzPsA77Ufda8bWkP4m2fE3wmfROnLbBI6LZ+GN/Of5kDjzMs
         +LON8GvVuvp6PLbedM+jHHp7N1HHKqcsIf2kl8hYY0WNCz8wm05ZFAm1bfEFOoxc3O
         NKsTqtoiE5BrjLO/69hZr4J2Ximzp1bGC1pCasgT0SWe3RfdMvHLqhTGvYolw/rIo0
         XZDAB2IL/xqm/onT547i6Y5ILONMsb1ek/rhP82y1rs7E8ZRFZQu6gEyGBvQl684Qq
         SntAcNeWtU+aI2RAC8TZGofH5EZLyeIjS880tp9CSVsWkORyr4wilb5k2aeSkoAsf5
         q4eZsYtkDBuDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D129DF1D6A8;
        Fri,  8 Sep 2023 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Add support for Intel Misty Peak - 8087:0038
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169420622485.6163.17147278831548380422.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Sep 2023 20:50:24 +0000
References: <20230907091550.1957138-1-kiran.k@intel.com>
In-Reply-To: <20230907091550.1957138-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, vijay.satija@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Sep 2023 14:45:50 +0530 you wrote:
> From: Vijay Satija <vijay.satija@intel.com>
> 
> Devices from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0038 Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
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
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Add support for Intel Misty Peak - 8087:0038
    https://git.kernel.org/bluetooth/bluetooth-next/c/ec63120307a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


