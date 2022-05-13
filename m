Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 00:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359707AbiEMAAQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiEMAAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 20:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37028B6A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC0976209F
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49873C36AE2;
        Fri, 13 May 2022 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400013;
        bh=9ehyDdWAzuSSVDWmwyl3S8zLa/AKd0Yyz8uN78yYYgA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QylcOl6/1yIj8HOW/2LwoHKZruBFuhSjGyidv0Rw2/l10a9E/YpXvuayyJ1FgdVay
         02/HoU6vNIHfbWFggYPUY72nNZ+90JnO8dkpG2Zl+k9tJDXcp5A8h6hBEiCF9G8aRN
         HBF65/10SDK1nF1ojbEETtd5eITd2xVmsCjqIKiPiI7p+VpsaQ1CqJgFeOkv/ZJJaq
         BBokBeSyepcSXBZMLK0SjxpJCJgHMgQJ1q2ooF4AEHfwKWfIGAKArQ4Gd33W4m6sVz
         pqbpvGA4llKwGHEg81T4mOWyMoUq6779X7dtQcb/xN/uSXs4zFFw4CqtZ5p5nkVPeI
         cOwr3Mpt44rnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20B63F03935;
        Fri, 13 May 2022 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] service: Add initiator argument to service_accept
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165240001312.24546.13959771486568015942.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 00:00:13 +0000
References: <20220512005515.844857-2-luiz.dentz@gmail.com>
In-Reply-To: <20220512005515.844857-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 May 2022 17:55:15 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds initiator argument to service_accept so profiles accepting
> the connection can use btd_service_is_initiator to determine if the
> connection was initiated locally (central) or remotely (peripheral).
> ---
>  src/device.c  | 18 ++++++++++++++++--
>  src/service.c |  4 +++-
>  src/service.h |  2 +-
>  3 files changed, 20 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] service: Add initiator argument to service_accept
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd24715bb226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


