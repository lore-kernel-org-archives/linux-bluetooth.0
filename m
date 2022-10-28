Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227B6C38A02
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ1XuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 19:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1XuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 19:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED25B11E
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 16:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E5EB82DD1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 23:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAFC6C433D6;
        Fri, 28 Oct 2022 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667001015;
        bh=CCwQAqpoDLHKOLB+2BoTefD5ebIhhFtnDypgCxgW154=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EnP+jOaFRf9JUQUnjta5piQVNHC4+rHSso46AY7xzunKS6wr3N54LhVgRdpgvhEWn
         RegfooD5G7pY4qES/Fl8VbGr+4GUaRmm/y3VV5YiMic2usl6szm3oWtTsZZKsyIEAZ
         jA1+lDNVz8ce8RoaZTFv8ooyy4cOlRAI4war3ir/XCL2Ao7OxiI0dS6I/2Tt7xiZdk
         R3h9jh3zKo7x256xGi89i2kGSjyH2zBZs5emmKH2HbgWdebHuKI7JWO7G+cAgx7jzr
         7KbK/ke42+Y6cvUIaNwYCqWI0BLbKNw73JdLei1i5pLCSE/t73fO9zH1R8zuaxT1ll
         AMQ+MBzbk6zIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FC59C41676;
        Fri, 28 Oct 2022 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166700101558.30161.7237012145255361765.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Oct 2022 23:50:15 +0000
References: <20221027232528.1996093-1-luiz.dentz@gmail.com>
In-Reply-To: <20221027232528.1996093-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Oct 2022 16:25:28 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds CONFIG_BT_LE_L2CAP_ECRED which can be used to enable L2CAP
> Enhanced Credit Flow Control Mode by default, previously it was only
> possible to set it via module parameter (e.g. bluetooth.enable_ecred=1).
> 
> Since L2CAP ECRED mode is required by the likes of EATT which is
> recommended for LE Audio this enables it by default.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED
    https://git.kernel.org/bluetooth/bluetooth-next/c/98f18bb78b7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


