Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A7FEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjF2T0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjF2TZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 15:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8E3AAB
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 12:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6196160E
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB7CFC433C0;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688066683;
        bh=SG1NkjvdDh9wxYdwSTO+Btn6p/7GcRX2t1gHa0fKsUA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AETXON52O+KD96OmvCf0WyKWinm7FHM+1uixbZCY5vAgQQX3OQeuRsJJFmv7n4sib
         bKknW9/OETb482Id4gdfUsSxEtE2TN1yzFQLTgTKyXGnyiqadrCRvs3rU8O9pFteys
         qGzEJHVTcW7Zly5r2POJlmZrLi7Wuj5mw/4/xp+kP8C9i4nDcpz3EtmX74MPI/U6ty
         2PVeUth4i4nklwoDuMJWvi2U+vtSDecwpoNRsGpz2/RaVjJPOw+ymgmjUpnK0OAK9R
         DS71nV0h1PWrMLvC5+hohj6vMzrZ7mGA7G4APFHqRsdX/9swbU+bhc/dQ54peiRXi4
         ZHGIg771nfAHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C699C64457;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: Add support for Gale Peak
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168806668356.29593.3335054694469300023.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 19:24:43 +0000
References: <20230628121831.827171-1-kiran.k@intel.com>
In-Reply-To: <20230628121831.827171-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Jun 2023 17:48:31 +0530 you wrote:
> Add hardware variant(0x1c) for Gale Peak core (CNVi).
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes  in v2:
> 1. Expand GaP to Gale Peak
> 2. s/GalePeak/Gale Peak/g
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: Add support for Gale Peak
    https://git.kernel.org/bluetooth/bluetooth-next/c/1c1fcdb51ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


