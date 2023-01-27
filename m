Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7176EC61DB3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjA0ULE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjA0UKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 15:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1C29402
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 12:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6581B821D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 20:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827DBC433D2;
        Fri, 27 Jan 2023 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674850217;
        bh=fU1DrFktkMFUwCVBz7oqhY3pZl8+6dZkg/IWY5+2wR4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tJSaEHP3R8IdJVj1YMgo2ZQQj/XTn6SOeGBDWruDXU1mzSzUYMTfc/s75sQugnzDG
         DBVtZeV30KtwIStwzyxRmEjReJ8Fgzp4pBzw7/7d7GA3jfNJ+v7uEr9G9tDxkaA5mG
         koUjB9gdAwHLDb25kRcu+W2dwbOnDHrBZXwCmYZFP2dlW1arDCd2zNqCb9nob/eMny
         tz+qqDaiz+9zSPaXRE8PKxQ47qOLim1JDQ9nPifij97GpDl2k0mb2vt8EcxEyDR8rs
         lhxAkGphIGmu2CmoxCPIDAG9j3TAq91/Kc8D8X/h1igCV7Dw3dB6rl+eQZxM7MYMRx
         G6+NGF5wfGHlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EC05F83ECF;
        Fri, 27 Jan 2023 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/5] shared/bap: Fix not detaching streams when PAC is
 removed
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167485021744.15183.7216347847931429843.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 20:10:17 +0000
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Jan 2023 12:12:38 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When local PAC is removed we attempt to release the streams but we left
> it still attached to the endpoint, so this makes sure the stream is
> properly detached by setting its state to idle.
> 
> Fixes: https://github.com/bluez/bluez/issues/457
> 
> [...]

Here is the summary with links:
  - [v3,1/5] shared/bap: Fix not detaching streams when PAC is removed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d159973ecec8
  - [v3,2/5] bap: Fix not setting stream to NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=414c8650acfe
  - [v3,3/5] bap: Fix not removing endpoint if local PAC is unregistered
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8aed9db4b13f
  - [v3,4/5] bap: Fix not checking if request fits when grouping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=814e3535a1bc
  - [v3,5/5] bap: Fix registering multiple endpoint for the same PAC set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b61044d52917

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


