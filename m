Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB2C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Jul 2022 23:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGRXUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGRXUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Jul 2022 19:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293282CCA4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Jul 2022 16:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39926159E
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Jul 2022 23:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F59C341C0;
        Mon, 18 Jul 2022 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658186414;
        bh=tNvK8omt4EvDTQMPjsW7/SCEqLoQPBItwIEHXAzmuIY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ks8EafD/kNS28XoIpsM++DDvrEsifxPnJDd3nyJ7gCpupKpGBs+UsL2riwO8YeTcm
         J/v5exw4PLrKwM6Z6/yT+Tgo+PmNRKI1UMgcNPgfakDN/l+4x6BjvFNiI/J4aYlwo4
         pHXrK6LJJrs4by7S8zrh+Lo8HV/Ejh6qaIRkUNsdIQPNp6wCyH5L6Ly7ME45zXsH7T
         cs2bvoP5kxg++EOrhQritvsBA0NqCFdZj5Z5xXKS0NCWPU1P6JwRXqkeH8pa2AqBwO
         YpsNbP0bPnx0O9ydWslqQnhGRTOK6Bvqlb13V/E8cOzivHTF9PtFNDVPmSb6nV3rYX
         r6hzPa8l3d0cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDDA0E451B3;
        Mon, 18 Jul 2022 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165818641390.5411.16922601141768984270.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Jul 2022 23:20:13 +0000
References: <20220714181224.3793757-1-luiz.dentz@gmail.com>
In-Reply-To: <20220714181224.3793757-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Jul 2022 11:12:23 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When programming a new entry into the resolving list it shall default
> to network mode since the params may contain the mode programmed when
> the device was last added to the resolving list.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209745
> Fixes: 853b70b506a20 ("Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Tested-by: Zhengping Jiang <jiangzp@google.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab345b04433d
  - [v2,2/2] Bluetooth: hci_sync: Don't remove connected devices from accept list
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff1688aab0d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


