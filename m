Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Mar 2022 09:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiCRJlj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCRJli (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Mar 2022 05:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE32C3DEA
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 02:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B3B60FD8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 717C9C340F0;
        Fri, 18 Mar 2022 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647596419;
        bh=Eqt17Q9c1HxTWIuKi48jYzzxvfHYoh4sGAw530sUGfc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a48cLVh5qMQ5mL5yyD2Y1vseux06XKt6AV87LoBC9rgHExHLf7watN/ubupJV1Mjn
         rXIi0PaUOKX2XwYHPuO6UC2BFV/LelI8EmIZCFQJ+WaH8jTV4bgsvVjYYMFuGy/9KV
         k1li8beYAaEvxs9b0G+GlXM824CBihUZTWICfkBNDLFKBp9IOCK5pkmGiRaCAjQlvf
         rvEipXWd38AJEzgeYPMP8un8H7tudk+xBHgo3iiGxeWLbWvVzB2urcsk+XuqTIzj2w
         CCserA9dtopOIqeCo/m6cn3wDc59eRVzwgyFutgBKoh7f8kAzvcD/aq/WnLsR/eJTk
         hqF2wneCa1OCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 566DFF0383F;
        Fri, 18 Mar 2022 09:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH resend 0/1] Bluetooth: hci_bcm: Add the Asus TF103C to the
 bcm_broken_irq_dmi_table
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164759641934.7287.13568620078791288894.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Mar 2022 09:40:19 +0000
References: <20220228113841.476174-1-hdegoede@redhat.com>
In-Reply-To: <20220228113841.476174-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 28 Feb 2022 12:38:40 +0100 you wrote:
> Hi All,
> 
> This patch seems to have fallen through the cracks, hence this resend.
> 
> Regards,
> 
> Hans
> 
> [...]

Here is the summary with links:
  - [resend,1/1] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
    https://git.kernel.org/bluetooth/bluetooth-next/c/cdd7d32d639c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


