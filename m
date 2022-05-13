Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379927AbiEMLaU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379924AbiEMLaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 07:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0352B4CB3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 04:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9081D61DF7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 11:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0365C34119;
        Fri, 13 May 2022 11:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652441414;
        bh=v3j6IOobd+i4tuCxop3lZLOJYbssSBSH42/WYQ3Eviw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H9WXqLa0KvI0lIcsMeVEYJIXrjiNqwPq+O7W9CestdtgqroLANfyaIp755SjP77Po
         IhoTILSVTFKBUF5ibZ0jnEtckw3IpSlEkCM83mv1MNV/k2oZfl7ikqfa52Twa306nK
         TB0Q/otQItbO5sjkD/lm9q0sXwcH2x3hbJjonw1cq6Dmy4qG7c8fE01SHS0A3H3yVV
         SlTUOoq5vYut75edOe/Z7VpFJzhYXA0Ep9x3r8N+7LwEG/GAQaOYIdpX/Q/3EWocYx
         OE5zpi8AjPjr7NdRTlcRF58o2SiYwInkIkXxtK9+m3WqQ3REs8B+koFCEMT/mab558
         kx9/rB3fGnjhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE419E8DBDA;
        Fri, 13 May 2022 11:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: MGMT: Add conditions for setting
 HCI_CONN_FLAG_REMOTE_WAKEUP
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165244141390.14739.9647709531898144836.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 11:30:13 +0000
References: <20220512223134.1021074-1-luiz.dentz@gmail.com>
In-Reply-To: <20220512223134.1021074-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 12 May 2022 15:31:33 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> HCI_CONN_FLAG_REMOTE_WAKEUP can only be set if device can be programmed
> in the allowlist which in case of device using RPA requires LL Privacy
> support to be enabled.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9a347655d22
  - [v2,2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b42055388c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


