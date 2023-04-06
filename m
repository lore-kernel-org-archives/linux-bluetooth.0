Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BAC7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjDFVAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDFVAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AD7683
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFE764BDA
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F410C4339B;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=1rKTWMcbX3+eTB1PKHgYE3Hb2MPEcePhDbCYw32sIAo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bIPd/KdaNylxJLBFDpQ7hfgxHUSX+4eftPS4wPfSOJOXTITEQcRgirA6axiqCHp/R
         VyJ2E2qAyGIfEbN0hS4Y5pRmPLmEv/hHng9QhRwIP/wLpVR5tFPHBUYHqJJWjdyO3r
         GHd31foxlodQxaJJRRWGbb2aHk93Gz7OdyN34TqfOmPFd4dkXpwxm9yO+on1N69QoV
         E3E8TAXXeIi60vayBkRFz1wt4aJHurFHVEb1V8Vs+i/lEhrhCGSrBlPPVewj47MXd1
         ccgZ2pgVCpSESmJtByWVw5ZoY5TJvQmCncZzuCsoiy4m0M/gUbjVNr+qPl2INnZuw8
         Vu+z9bkoH4O6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83301C4167B;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: hci_bcm: 4 fixes / tweaks
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482052.2619.6076248429328151114.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230331211124.463003-1-hdegoede@redhat.com>
In-Reply-To: <20230331211124.463003-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Mar 2023 23:11:20 +0200 you wrote:
> Hi All,
> 
> Here is a series with 4 fixes for UART attached Broadcom BT adapters.
> 
> Note patch 3/4 is an unchanged resend of an earlier patch,
> the other 3 or new.
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
    https://git.kernel.org/bluetooth/bluetooth-next/c/6734b7202113
  - [2/4] Bluetooth: hci_bcm: Limit bcm43430a0 / bcm43430a1 baudrate to 2000000
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f3e94a46e16
  - [3/4] Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table
    https://git.kernel.org/bluetooth/bluetooth-next/c/c80b3429f37c
  - [4/4] Bluetooth: hci_bcm: Add Acer Iconia One 7 B1-750 to the bcm_broken_irq_dmi_table
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffd6167980f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


