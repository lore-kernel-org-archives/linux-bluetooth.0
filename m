Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CAC4321E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiLBVZp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiLBVZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 16:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD52EDD5C
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 13:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC542B822BD
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 21:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64804C433D7;
        Fri,  2 Dec 2022 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670016340;
        bh=nTMk8nVIoV8fGinKRDV10QMqWq9waLnzCJxeMWmXDN8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XkfgbCyEkOOOlL6p6ijwnCWRIP+SyUU5KDJvDS65xasNpnPjNXgKN3x+WH/9JDdj3
         6kSucooOLPLcVj0ErKn/cCZ4iv1PG8N0aUdUKOQryeBuTq6ubOPDYYitauUxNx6kS2
         hKfoyDQzuIc1uKvWfrFmUahc/WbONBu3IieXga/MYxG6MUvJcS7eeHHj3ZqWOE84SH
         qckam2orpEV72xt3R3vdL45/bo4Tr0crqQt69WdOvqt5PxEsEcC5Ap24i0rVKUEfSM
         QZwmIEKA7GKL9VopgX3l4q19TH5xYp/cYLJUM3FBZh38C1O/HiVHiptDUhCZ60pIUQ
         dXG8dO27zlKeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50170C395EC;
        Fri,  2 Dec 2022 21:25:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix crash when replugging CSR fake controllers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167001634032.19139.9607328902746890019.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 21:25:40 +0000
References: <20221129205413.1537851-1-luiz.dentz@gmail.com>
In-Reply-To: <20221129205413.1537851-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Nov 2022 12:54:13 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> It seems fake CSR 5.0 clones can cause the suspend notifier to be
> registered twice causing the following kernel panic:
> 
> [   71.986122] Call Trace:
> [   71.986124]  <TASK>
> [   71.986125]  blocking_notifier_chain_register+0x33/0x60
> [   71.986130]  hci_register_dev+0x316/0x3d0 [bluetooth 99b5497ea3d09708fa1366c1dc03288bf3cca8da]
> [   71.986154]  btusb_probe+0x979/0xd85 [btusb e1e0605a4f4c01984a4b9c8ac58c3666ae287477]
> [   71.986159]  ? __pm_runtime_set_status+0x1a9/0x300
> [   71.986162]  ? ktime_get_mono_fast_ns+0x3e/0x90
> [   71.986167]  usb_probe_interface+0xe3/0x2b0
> [   71.986171]  really_probe+0xdb/0x380
> [   71.986174]  ? pm_runtime_barrier+0x54/0x90
> [   71.986177]  __driver_probe_device+0x78/0x170
> [   71.986180]  driver_probe_device+0x1f/0x90
> [   71.986183]  __device_attach_driver+0x89/0x110
> [   71.986186]  ? driver_allows_async_probing+0x70/0x70
> [   71.986189]  bus_for_each_drv+0x8c/0xe0
> [   71.986192]  __device_attach+0xb2/0x1e0
> [   71.986195]  bus_probe_device+0x92/0xb0
> [   71.986198]  device_add+0x422/0x9a0
> [   71.986201]  ? sysfs_merge_group+0xd4/0x110
> [   71.986205]  usb_set_configuration+0x57a/0x820
> [   71.986208]  usb_generic_driver_probe+0x4f/0x70
> [   71.986211]  usb_probe_device+0x3a/0x110
> [   71.986213]  really_probe+0xdb/0x380
> [   71.986216]  ? pm_runtime_barrier+0x54/0x90
> [   71.986219]  __driver_probe_device+0x78/0x170
> [   71.986221]  driver_probe_device+0x1f/0x90
> [   71.986224]  __device_attach_driver+0x89/0x110
> [   71.986227]  ? driver_allows_async_probing+0x70/0x70
> [   71.986230]  bus_for_each_drv+0x8c/0xe0
> [   71.986232]  __device_attach+0xb2/0x1e0
> [   71.986235]  bus_probe_device+0x92/0xb0
> [   71.986237]  device_add+0x422/0x9a0
> [   71.986239]  ? _dev_info+0x7d/0x98
> [   71.986242]  ? blake2s_update+0x4c/0xc0
> [   71.986246]  usb_new_device.cold+0x148/0x36d
> [   71.986250]  hub_event+0xa8a/0x1910
> [   71.986255]  process_one_work+0x1c4/0x380
> [   71.986259]  worker_thread+0x51/0x390
> [   71.986262]  ? rescuer_thread+0x3b0/0x3b0
> [   71.986264]  kthread+0xdb/0x110
> [   71.986266]  ? kthread_complete_and_exit+0x20/0x20
> [   71.986268]  ret_from_fork+0x1f/0x30
> [   71.986273]  </TASK>
> [   71.986274] ---[ end trace 0000000000000000 ]---
> [   71.986284] btusb: probe of 2-1.6:1.0 failed with error -17
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix crash when replugging CSR fake controllers
    https://git.kernel.org/bluetooth/bluetooth-next/c/dbd24be48422

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


