Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCCFC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 00:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDAuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 19:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCDAuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 19:50:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956E5F6FF;
        Fri,  3 Mar 2023 16:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099D461986;
        Sat,  4 Mar 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4966DC433EF;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677891020;
        bh=rVcauREmGmmQhQT6XeByGl7eoUGolgEpVbV3+QvEZEI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U3UE4Tek4mroXX3oKxCGw23OL2tPUkWiy7Kz684lj4s0OOcNulWQe5xcPbmThex9M
         qfVrrpSBcu0mqArjhbszDRdlt7kRgIolGmPdHPvz+tK9ZpUsesnA5elFK3BUuAsu9Y
         B2fyqi39Ppspuu5g/HDYsc1cQfMW+Vw4u4SnK+qmZ6k48Ikxdc3bl6BFvG6cWi1r8P
         ay2kNfbD+L9CrBJX5oBRD57F75tDqjSBi1yPM36MU7u2oilfePYuAp963u9ARlSte3
         mQxtLtuZXXztrcSsNRDdKbRJrWjNayC6BToyBllSOu4zpu8fGLvusC59IfkrH+1ByM
         VuxkETT+GJV5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30C70C00445;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3 V4] Bluetooth: Add support for RTL8821CS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167789102019.19976.12427542691000246930.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 00:50:20 +0000
References: <20230228152205.133582-1-macroalpha82@gmail.com>
In-Reply-To: <20230228152205.133582-1-macroalpha82@gmail.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        macromorgan@hotmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Feb 2023 09:22:02 -0600 you wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> This patch series is to add support for the RTL8821CS Bluetooth
> controller found on the RTL8821CS WiFi/Bluetooth combo chip.
> 
> This has been tested with firmware version 0x75b8f098 which has been
> submitted by Realtek for inclusion in linux-firmware.
> 
> [...]

Here is the summary with links:
  - [1/3,V4] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
    https://git.kernel.org/bluetooth/bluetooth-next/c/b564bad5b54d
  - [2/3,V4] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
    https://git.kernel.org/bluetooth/bluetooth-next/c/8b449db459d9
  - [3/3,V4] arm64: dts: rockchip: Update compatible for bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/d305437d4d2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


