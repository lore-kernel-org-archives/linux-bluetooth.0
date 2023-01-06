Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF4C61DB3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjAFUAp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjAFUAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Jan 2023 15:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2377AD7
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60B00B81E82
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB62FC433F1;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673035217;
        bh=9xCDzaSx5HhOX22jbv1SZybApapzaN/afrx0213l5MY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RvJX9SHvkSIypKrFCo1QgxqhAbHhXJpXKIHQQs2JfEebuIQDMdC9oJpwOtIYbk58v
         7frsBO+h5lVconvWpJ7QIdEUQhXkLmBs2iG8dhm/GQqljQRZlpmX6i+Oou0HKWD7sZ
         CLsx/AuN62mHmYeV0en9n5LS3FaBuYbgWFogTlYwgeGz/VDX1wmyOPwlAM6o59MOzF
         2wPMe1I3JeqCm2IgI4fQ4EyptY+oQIBkwo/riKj7Tt80LtWMi/MAdUW7WwsDP4dBTj
         EpzKAfDADSXJP5xHzUkmICnz1Ts1WonoHmeBK6gKtlMxS2bLIXFmkTdZXqMFH+Ezrd
         dnbPn9V++IJ4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D722DE270EC;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] shared/gatt-client: Use parent debug_callback if
 not set on clone
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167303521687.6339.12160035828988357153.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 20:00:16 +0000
References: <20230105220944.2373424-1-luiz.dentz@gmail.com>
In-Reply-To: <20230105220944.2373424-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Jan 2023 14:09:41 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If clone don't have a dedicated callback set use its parent so users of
> bt_gatt_client_clone don't have to keep setting the same callback for
> all clone instances.
> ---
>  src/shared/gatt-client.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/4] shared/gatt-client: Use parent debug_callback if not set on clone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6e3059ae8cac
  - [BlueZ,2/4] shared/gatt-client: Allow registering with NULL callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fde32ff9c9c0
  - [BlueZ,3/4] attrib: Introduce g_attrib_attach_client
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47b6cfeee333
  - [BlueZ,4/4] hog-lib: Fix not handling BT_ATT_OP_HANDLE_NFY_MULT
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f4c576ad243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


