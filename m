Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJJVCA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJJVBT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 17:01:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5712AAD
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 14:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0E30B810D8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 21:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 918C5C433D7;
        Mon, 10 Oct 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435616;
        bh=70RVyVA+OLXzqcw/OVxIgDIigZA5EkJ7mtyfMhnvQyI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eKY6jz5cs4p30g2jM/itmVGe/wrc4hSdeG++/meuF3zQQqf0CY4e3L42YgIL0DViA
         8reQ1MCqw02bbd6IMlvdxgp/SLF4Xr3fkkhxPRTNhsLHtN4fTUNx6ddz1a2QwnttUv
         e3jZ2q9XJBec4a5DP8KfLxEWDKjkYiPckpHY4/RufJYAmz2hdWUcSNEz42+ycY8bEF
         W3MpOxSmmuJ2RdAjo3VgStct7/CajA9+SMw6WybimwxyXj2zp1nuW0yqTzPKP89epe
         41pak0DPZpXELNzZoL63rJwELZUjgbVb6S3BuoFAu3NbyG/vND+HJ5MQJawF47zXvs
         hmou7r71mIGow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7598FE4D022;
        Mon, 10 Oct 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_sync: Fix not setting static address
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166543561647.14234.4143384185397650870.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Oct 2022 21:00:16 +0000
References: <20221010203522.1251151-1-brian.gix@intel.com>
In-Reply-To: <20221010203522.1251151-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Oct 2022 13:35:21 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to program the address stored in hdev->static_addr after
> the init sequence has been complete:
> 
> @ MGMT Command: Set Static A.. (0x002b) plen 6
>         Address: C0:55:44:33:22:11 (Static)
> @ MGMT Event: Command Complete (0x0001) plen 7
>       Set Static Address (0x002b) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00008200
>           Low Energy
>           Static Address
> @ MGMT Event: New Settings (0x0006) plen 4
>         Current settings: 0x00008200
>           Low Energy
>           Static Address
> < HCI Command: LE Set Random.. (0x08|0x0005) plen 6
>         Address: C0:55:44:33:22:11 (Static)
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Random Address (0x08|0x0005) ncmd 1
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 7
>       Set Powered (0x0005) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00008201
>           Powered
>           Low Energy
>           Static Address
> @ MGMT Event: New Settings (0x0006) plen 4
>         Current settings: 0x00008201
>           Powered
>           Low Energy
>           Static Address
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sync: Fix not setting static address
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca57023e7c49
  - [2/2] Bluetooth: hci_sync: Fix not able to set force_static_address
    https://git.kernel.org/bluetooth/bluetooth-next/c/8549542298e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


