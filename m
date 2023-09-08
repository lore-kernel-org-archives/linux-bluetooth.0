Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDE2EEB572
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbjIHUuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjIHUub (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 16:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCDB2;
        Fri,  8 Sep 2023 13:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06D34C433C9;
        Fri,  8 Sep 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694206225;
        bh=1oC3unuPY4W2Ce2yVgXMfOxQiB4DCDJ2bQBhfLNXz4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hHxceuVbk/xIXsBVcXUE1q6lEUGsnk7d9ubmsHG2nBGhWNogevJVeiOC2lFSitXzj
         iswWz/a4xVWsYwCYVC0fk8oCwIUMq8u3G9TyW5fiHLaMDG6HkOZwrdT/goow7FwKch
         f9orgtYOEAIWkkeKxUIxg1U/756BY6gEroh4pdKHcGSYFCnP5AOvDiJubRx33xq0TZ
         W1/FShTOEQiT7Ffw0XdDbnIB6adLOVwAtxCMCXSFHzYtgdKxPbuNyKJ28J6gdwxh9W
         IjkPri5MWdcO1OeJwR8/NcDWa6lMmqkEQt80GvExNYZWrX4xj1FYSc/EXSvbCsVdZT
         fpFDdrxrRmA9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5EFDF1D6AA;
        Fri,  8 Sep 2023 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Avoid redundant authentication
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169420622493.6163.1195791709998663185.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Sep 2023 20:50:24 +0000
References: <20230907043933.v2.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
In-Reply-To: <20230907043933.v2.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Sep 2023 04:39:34 +0000 you wrote:
> While executing the Android 13 CTS Verifier Secure Server test on a
> ChromeOS device, it was observed that the Bluetooth host initiates
> authentication for an RFCOMM connection after SSP completes.
> When this happens, some Intel Bluetooth controllers, like AC9560, would
> disconnect with "Connection Rejected due to Security Reasons (0x0e)".
> 
> Historically, BlueZ did not mandate this authentication while an
> authenticated combination key was already in use for the connection.
> This behavior was changed since commit 7b5a9241b780
> ("Bluetooth: Introduce requirements for security level 4").
> So, this patch addresses the aforementioned disconnection issue by
> restoring the previous behavior.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Avoid redundant authentication
    https://git.kernel.org/bluetooth/bluetooth-next/c/4c8a783f3882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


