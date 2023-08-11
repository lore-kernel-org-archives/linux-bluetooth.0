Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164E9EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 17:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHKRaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjHKRaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 13:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A030CF;
        Fri, 11 Aug 2023 10:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF42634CC;
        Fri, 11 Aug 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEDCFC433C9;
        Fri, 11 Aug 2023 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775022;
        bh=huCCSvxcjJag/aH5ObkQtncQzAlpIZjjeRaG+rPRVRQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L0YaT7r7v5j7boFNeFUWFIZIum4rJBmDkW2pygBpRrou9lgg86X2f6F/32WmaR0KU
         ksyLtts2dfAE3CgvKWgQGwkR0dF0hwFs5RIGSP/kbZrR5zdw0k0/X6ZIpUq//5RxVV
         rsW+W9lnaoK/TJMpgB0FJroO6PMW6OUjz1XLC8K0ZMJWJm8dAqbBhu4n8ZetacAA2u
         Rc4UBCeBkvXgtr79ubWjbkX8VEOm0PLgM93QxnNuPBl/pE4a6+ZbW7rQQm93Tqry3I
         /AJhVCVMoOR6F7uXs85K3bu3u3n2yML7t50gFtRH3fXuH3cvK1cuYdVxKyyC4aBt9t
         FJIqm3jmbDgAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AEDAC3274B;
        Fri, 11 Aug 2023 17:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169177502256.30118.4789677111506595993.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 17:30:22 +0000
References: <20230810144507.9599-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20230810144507.9599-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, hildawu@realtek.com,
        stable@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Aug 2023 09:45:07 -0500 you wrote:
> This new device is part of a Realtek RTW8852BE chip. Without this change
> the device utilizes an obsolete version of the firmware that is encoded
> in it rather than the updated Realtek firmware and config files from
> the firmware directory. The latter files implement many new features.
> 
> The device table is as follows:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ae8f7d53554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


