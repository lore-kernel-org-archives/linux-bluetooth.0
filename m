Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C9EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFMUu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMUuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 16:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91B10E6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 13:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1B4638F2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7183BC433C9;
        Tue, 13 Jun 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689421;
        bh=r8MMbOA8gE2ph/xk6NzvD4vvgYVXysGvwN9E2aE0SHY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gnfXs75Rbw22wgn05b5p3aE8aAQaaTr92bjahfuUgVDUZ6aaNsE9Oo2+0upktC9r9
         JzbNafUBbpdBy+bZeHl+aA0OEWz6BiYDpdu4aYuEWRK9u/9FW98GCryhMGf6JdT/6n
         rZiKvX3OkQTM5glVtdia2Gd0Ypk41vRuHiB+iIawv/hkzFGkxMMZiIopQlAwFq0haK
         AMz/iL1y0CydgoZ2MncISkmfpHLSX8xAQ87HWpkGemdTiazJHoy4ICEYLWlOwLdq2C
         VRl86TqF1ZdN9kouaiuRKYipGQR+d3d/nvPBKGBuSjv1x/phHwBsqdBTLGk0FqlQbf
         IxmZqLqhA+7EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A56BC32760;
        Tue, 13 Jun 2023 20:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/3] Code handling for VOCS service
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168668942129.9544.13475922727967955836.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Jun 2023 20:50:21 +0000
References: <20230612133251.194-1-nitin.jadhav@nxp.com>
In-Reply-To: <20230612133251.194-1-nitin.jadhav@nxp.com>
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Jun 2023 19:02:48 +0530 you wrote:
> Hello Maintainers
> 
> This patch series handles code implementation for mandatory features of Volume Offset Control Service.
> 
> Implementation of following features have been handled in this patch series
> - Volume Offset Control Service
> - Volume Offset State Characteristic (Read, Notify)
> - Audio Location Characteristic (Read)
> - Volume Offset Control Point Characteristic (Write)
> - Audio Output Description Characteristic (Read)
> - Set Volume Offset
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/3] lib/uuid.h: Add VOCS characteristic uuid(s)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0735ca179fdf
  - [BlueZ,v5,2/3] shared/vcp: Add initial code for handling VOCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52a4d79f22c3
  - [BlueZ,v5,3/3] shared/vcp.c: Make VOCS as an included service of VCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d2d2d12f59d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


