Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLPVkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPVkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 16:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8C6C716
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 13:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4853462222
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0E27C433F0;
        Fri, 16 Dec 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671226816;
        bh=m9ENK0FEZqJsUUsNcHW9cpL46LZyh/6MggDpDWtdlg8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hvZqeEhv8NlQ2MVa94pL+uynX1w1qwPiA05qypIkMC9Tdwx2bOyFn6q43jFUvjltM
         A5qWlovZHKWPhcvxU0XbmIDo5a7k2lc7NQaax1h8oMd2uB3/00Uv0pGRxL3/Gkh0nb
         MrPAJwxiUbSe38RtGpc6vNRdDI+1/824ku3a6T1q57WtimKhCiWU+W/p6AUzzHsk8u
         2axmchVgK4o4g2YGfdWH/rBCf4vgIvU22FLa/91JmE0QkOaOXlm4LWpvRsYkR0Kwzf
         7EAN0fNaLIS4WdoTCIpj844CTh6dugFZRnT5GcC8pU5yWYDXEy5p/OU8QRxFcQB7e8
         U2KLo3/qrBTMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87612E21EFC;
        Fri, 16 Dec 2022 21:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix issue with Actions Semi ATS2851 based devices
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167122681655.4154.18045394353973425846.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Dec 2022 21:40:16 +0000
References: <20221216201247.297210-1-marcel@holtmann.org>
In-Reply-To: <20221216201247.297210-1-marcel@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Dec 2022 21:12:47 +0100 you wrote:
> Their devices claim to support the erroneous data reporting, but don't
> actually support the required commands. So blacklist them and add a
> quirk.
> 
>   < HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0
>   > HCI Event: Command Status (0x0f) plen 4
>         Read Default Erroneous Data Reporting (0x03|0x005a) ncmd 1
>           Status: Unknown HCI Command (0x01)
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix issue with Actions Semi ATS2851 based devices
    https://git.kernel.org/bluetooth/bluetooth-next/c/0bb039f39058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


