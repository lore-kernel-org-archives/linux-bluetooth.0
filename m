Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11BCC71153
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbjHWXA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjHWXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8FE50
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6BA365BE8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F34C433C7;
        Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831624;
        bh=Fs05oFlO3k9nAm1Pae8T1bVKRhJVEKnp+PeqYYPp3Vs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LDIny1U/zRzVhOXfsyJiEn/z6rsqXJPpAohnsKnz1wgJCoavAHzCypV3Fl7qf86es
         UdKDJi+MCqP2TacQ+t9jKegaoF2tCZDE+s8uTXBIax6ZRqMLIsBYQHsr3l4tGycAmR
         8LcjQdPPEa/0NzhHpwc2aFPT4wYpRQO2aa+a8CX2aqI5tIOs9vRJQZ0cqeca/ww9cw
         nG+l5FFtwE9Eyadk7Gqrk4KUoWgNuZ3CjaKS855yJMiI1+wetI1wxREtDhBuT0gFMk
         8CzUPykEiBBs2keP+1HyCbXWgR7Wug3NZaapFV9Gq2tY8iUjW7vJzm9Q1O01iYca1Z
         cxgXSuTWG611A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDFD0E21ED3;
        Wed, 23 Aug 2023 23:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v8 0/6] Add support for BAP broadcast sink
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169283162396.30787.14755218181596127577.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 23:00:23 +0000
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Aug 2023 17:29:29 +0300 you wrote:
> This series of patches adds support for BAP broadcast sink.
> It consists in registering a broadcastsink endpoint using the
> Basic Audio Announcement Service UUID,
> discovering of broadcast advertisers that announce the
> Broadcast Audio Announcement Service, synchronizes to the Periodic
> advertisements of the source and synchronizes to the BIG advertised
> in the PA train.
> To retrieve the BASE info advertised in the PA train, the patch
> Bluetooth: ISO: Add support for periodic adv reports processing
> was used.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v8,1/6] shared/bap: Add support for BAP broadcast sink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d49ea14f70da
  - [BlueZ,v8,2/6] bap: Add support for BAP broadcast sink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7850975b0d0
  - [BlueZ,v8,3/6] media: Add broadcast sink media endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9966e0f8f6d8
  - [BlueZ,v8,4/6] transport: Update transport properties for a broadcast stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=34d546038ab1
  - [BlueZ,v8,5/6] client/player: Remove Broadcast parameter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a824ce8f6f6
  - [BlueZ,v8,6/6] adapter: Fix UUID name advertised for bcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d0d62659c06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


