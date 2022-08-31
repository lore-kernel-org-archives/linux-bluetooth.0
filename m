Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A5EECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiHaXK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHaXKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:10:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA362AAA
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78007CE2370
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2029AC4347C;
        Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987417;
        bh=qt9EKkWzjlE7B/sj8RlZgcFjcgy4FV6lAZUoaOh+xZY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g7d7rRO2tSaKRynK+P3EP4UOMo9Qx3UOIqCC+sXnz2Id3tZOKpsziHiQIc7//D0wr
         TCR8SXkF+DvQYrv3RAppsSLkkkGM2UbXrGYAIipp16oIb8GFNbdRxFfiJhvOvMinHj
         zlb+sOqGYY7SDrRBt/piDKmEDVLvp9rVjwyd6JteMfajvteKBfxvoPNwjgMTwFrPkg
         9Zuu5HGIop/3c84aytA1K3EyQ6ON9Xef1TNPKqm0i+dMJw1+1DRy494TVRuicC67Yr
         PX1N9lgNo9W3q11gHbI9Php25YD3eHQqEE8Nr9Q6vo/YQK1xjXTfDAYmC8DxXD4Jc9
         HfEF6TvKVjbrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D73AE924D6;
        Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media: Fix registering PAC endpoints if ISO socket are
 not supported
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198741705.19908.11574360179107012733.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:10:17 +0000
References: <20220830215444.1141653-1-luiz.dentz@gmail.com>
In-Reply-To: <20220830215444.1141653-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Aug 2022 14:54:44 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If adapter don't support ISO sockets the PAC UUIDs shall not be allowed
> to be registered as they depend on ISO sockets to work properly.
> ---
>  profiles/audio/media.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] media: Fix registering PAC endpoints if ISO socket are not supported
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a84aa0e6e5e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


