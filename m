Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE9C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 23:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCVXpU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCVXpF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 19:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7B732CE4;
        Wed, 22 Mar 2023 16:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AD46234E;
        Wed, 22 Mar 2023 23:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 156F3C433EF;
        Wed, 22 Mar 2023 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679528675;
        bh=X0T3MzV72DC3xsS/BzUx423vl2zXQuHSu+yzIyuL82w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RCHAuZ8+cJJARHXGI+dpKAFV4q2baBzE328b7YD0UOY02PVuvIv88UlBwT4HK5I26
         peLgac+q269msGYmbjkf+GtqnpMTffG/r0BEaEWxaeTazk92R3iKeSs94NTCiAMXtl
         2FVj+ySE9KjU9zc1cggLf2IPUy5SO/S1lsqnb20P4tKFfCDbBA1vx5tl0a2fKdijP+
         B9I2tDXy+lihutNwcOsMd/9Gksqb4u+vpFzJ+cJ37yqmmL7n9LTnIHuGU3gTrSCAXK
         fGFLEuPDE+9S5YcV/ZOYOu5N/4Udyo5+y9ve8xruxqw0GSSk6zOec5vl/7+4U8eCj3
         KPA77uIfH1cCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED14FE52513;
        Wed, 22 Mar 2023 23:44:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3 V5] Bluetooth: Add support for RTL8821CS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167952867496.26660.4065106798245519325.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Mar 2023 23:44:34 +0000
References: <20230315173657.28692-1-macroalpha82@gmail.com>
In-Reply-To: <20230315173657.28692-1-macroalpha82@gmail.com>
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

On Wed, 15 Mar 2023 12:36:54 -0500 you wrote:
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
  - [1/3,V5] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
    (no matching commit)
  - [2/3,V5] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
    https://git.kernel.org/bluetooth/bluetooth-next/c/60f8c67d065a
  - [3/3,V5] arm64: dts: rockchip: Update compatible for bluetooth
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


