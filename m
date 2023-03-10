Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79FC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCJAUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCJAUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354CF4B65
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 495EBB8214C
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 00:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDEE0C433EF;
        Fri, 10 Mar 2023 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678407618;
        bh=w4gwxZ+2Su8iKGdm6VUZ1/2gQJ0xWfP+tNJROl3Ysi4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U5OMZc/egtTdsJOmAlBbJ1oVsZV2J17GTRgwptV+68J9yuJLudGj3kd05Rz8SzQB9
         6bEqQl3r6WMnAXJ+WmETP68bHqgXsbecjGo1zPesaJeZEPzfmXO7iNfnBCn9UW+anL
         W8is5oxGXIa51uSEk+SKAy/amF2soGX9sqGk0IuDxu8RDQepxLwqKyCgFou2PD0xLC
         Pt9m36eHaDlVo6cQay021OJSbr++BdDT1vz9wMGe2KXBER98kxH5ohc39f1dfsLkM2
         CGH5VSGCMTnQb6sGkzKJYszuo3jJirlPBWA5sp3Yy9xMQaMAzGLJ7qztAl4hdXwV+L
         QZuod28pqz51A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D391DE5250A;
        Fri, 10 Mar 2023 00:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btinel: Check ACPI handle for NULL before
 accessing
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167840761786.25154.15943833396609314301.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 00:20:17 +0000
References: <20230308075837.5559-1-kiran.k@intel.com>
In-Reply-To: <20230308075837.5559-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        lokendra.singh@intel.com, chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Mar 2023 13:28:37 +0530 you wrote:
> Older platforms and Virtual platforms which doesn't have support for
> bluetooth device in ACPI firmware will not have valid ACPI handle. Check
> for validity of handle before accessing.
> 
> dmesg log from simics environment (virtual platform):
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> IP: acpi_ns_walk_namespace+0x5c/0x278
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> Modules linked in: bnep intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate input_leds joydev serio_raw mac_hid btusb(OE) btintel(OE) bluetooth(OE) lpc_ich compat(OE) ecdh_generic i7core_edac i5500_temp shpchp binfmt_misc sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid e1000e psmouse ahci pata_acpi libahci ptp pps_core floppy
> CPU: 0 PID: 35 Comm: kworker/u3:0 Tainted: G           OE    4.15.0-140-generic #144-Ubuntu
> Hardware name: Simics Simics, BIOS Simics 01/01/2011
> Workqueue: hci0 hci_power_on [bluetooth]
> RIP: 0010:acpi_ns_walk_namespace+0x5c/0x278
> RSP: 0000:ffffaa9c0049bba8 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000001001 RCX: 0000000000000010
> RDX: ffffffff92ea7e27 RSI: ffffffff92ea7e10 RDI: 00000000000000c8
> RBP: ffffaa9c0049bbf8 R08: 0000000000000000 R09: ffffffffc05b39d0
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000000 R14: ffffffffc05b39d0 R15: ffffaa9c0049bc70
> FS:  0000000000000000(0000) GS:ffff8be73fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000018 CR3: 0000000075f0e000 CR4: 00000000000006f0
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btinel: Check ACPI handle for NULL before accessing
    https://git.kernel.org/bluetooth/bluetooth-next/c/44f771148fb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


