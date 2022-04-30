Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Apr 2022 08:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382292AbiD3IEK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Apr 2022 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382272AbiD3IEH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Apr 2022 04:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C522BD4
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Apr 2022 01:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1AF5B81CFF
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Apr 2022 08:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93F0AC385AD;
        Sat, 30 Apr 2022 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651305641;
        bh=H+14wnnzAPWXdr0C/CBPTOYLpUtXuHPlotkQKTrGrh8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PSNK1SeiqWKCx8EPjFFi0UAFtId7K1fj0iS0PBwWTxPngfH4E7iL4PHkCEntuVF93
         6ydgwEc8RGL0ip4LFo0HCfCCKyDanzs6Kkngtuzu2c2DTKZlFDGesm3EEsPhyZ57oR
         IxcK7WIia2dLy9qHaGpqbo3GfseMPggv/Fj6sFuyS7tDEyZEBl7k1op6j+KTywAF+Y
         vl6BvNDjtlQeszO831/vj9VrNJeLcO3CorTHYwYoI7P40wq3y2H6quFwIn6FAnNIrj
         ZeYCSMeyqhq+wtCFfplrmDNrmfNiAKN+ApdijyvsIdppgUu0VqHVm2MD+JpYGskWZn
         G1H8l8o2b5Whg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BAB1F03841;
        Sat, 30 Apr 2022 08:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: hci_event: Fix checking for invalid handle
 on error status
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165130564143.32506.15386320521489025538.git-patchwork-notify@kernel.org>
Date:   Sat, 30 Apr 2022 08:00:41 +0000
References: <20220422195818.3640058-1-luiz.dentz@gmail.com>
In-Reply-To: <20220422195818.3640058-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri, 22 Apr 2022 12:58:16 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Commit d5ebaa7c5f6f6 introduces checks for handle range
> (e.g HCI_CONN_HANDLE_MAX) but controllers like Intel AX200 don't seem
> to respect the valid range int case of error status:
> 
> > HCI Event: Connect Complete (0x03) plen 11
>         Status: Page Timeout (0x04)
>         Handle: 65535
>         Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> 	Sound Products Inc)
>         Link type: ACL (0x01)
>         Encryption: Disabled (0x00)
> [1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
> invalid handle
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
    https://git.kernel.org/bluetooth/bluetooth-next/c/c86cc5a3ec70
  - [v3,2/3] Bluetooth: hci_event: Fix creating hci_conn object on error status
    https://git.kernel.org/bluetooth/bluetooth-next/c/aef2aa4fa98e
  - [v3,3/3] Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted
    https://git.kernel.org/bluetooth/bluetooth-next/c/9b3628d79b46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


