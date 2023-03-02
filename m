Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D53C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBUKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBUKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 15:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F652384E
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 12:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF2C615C4
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 20:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF945C4339B;
        Thu,  2 Mar 2023 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677787817;
        bh=ZkvyUdlcTdy1zfWSt0y2kwLMoS6SODXMPeO5FSn77bM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jbrE4f1a+arfha5VyqaG6dH8YNgiH0D38HcUNjwM2xQK4gHFNT++7JCD6E17hL7Ic
         DC8RmfIAZRA/ACPrKMtZ7VykauobfjUW3VdYL5fl0Ed1/cDfoLu4ewhylYpRH738Hl
         bsb9L1Wb9PhmfKgvCyDl2fbjkr5SJ5a4WFaPNzsgS11dQKZ9abRgBcbq87Fn+LCGBc
         qu/+iE/Ce5lP6MNEo91EHZWQ0UQvags6fr0Ci8dy8BtmdFLlbLMEPxBNAv9o5Atuos
         EYEDR3cvXnbVGNQXxIP8RpOmTF6YzSb0BPixg6pBXtRbXWluWoLawj/NIjxzrc9I62
         TD4a/ArSntkkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7112C395EC;
        Thu,  2 Mar 2023 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix smatch warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167778781774.25097.3984036782861093485.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Mar 2023 20:10:17 +0000
References: <20230227235255.266852-1-luiz.dentz@gmail.com>
In-Reply-To: <20230227235255.266852-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Feb 2023 15:52:55 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following new warning:
> 
> net/bluetooth/hci_sync.c:2403 hci_pause_addr_resolution() warn: missing
> error code? 'err'
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix smatch warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/80fb206d2840

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


