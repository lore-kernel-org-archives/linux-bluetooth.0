Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9072DECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 21:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiH3Va0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiH3VaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6394F69B
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED29618C5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AAB5C43140;
        Tue, 30 Aug 2022 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661895019;
        bh=9PYm6miB9UNzkDiw7F3ZA6pPFMOxubU4jv0lJYiWvpI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IvNXdA5GcfZH6vW7b8auUAmVIgO6OgGBkTFpcGe7WLfUnHWgZYjv9Lz14fG9qP5Pp
         agKGZEUWtbN2Pj5e7kFd8wzBsfmu0elun+oZEfjiHFeGPp2iVgbqKtwA/7R4T+4GTb
         hfmxuvyz50qgKUqLaL4eyOOY+xtCEDMzatCraCXyQaXj7m7+AovdG54pQ/kdqwMfwT
         qOthqF8pvNuOUp2TDFsYETE7BwnWiqSDsS4aY+RCzfDuWGeIMjl9Q/DjUTnRZKtydg
         v5BQJ4z4em2wB0fu6liA6GieUzFpaBgrvGOO65zih/W/YuwNo9ZqWlFu8wyTCTwYOF
         VlUMck0lF4eSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21CC1E924DC;
        Tue, 30 Aug 2022 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/3] profiles: Add remote endpoint path to
 SelectProperties
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166189501913.8541.15255176357450201959.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Aug 2022 21:30:19 +0000
References: <20220830205411.68299-1-frederic.danis@collabora.com>
In-Reply-To: <20220830205411.68299-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Aug 2022 22:54:08 +0200 you wrote:
> The SelectProperties method is only called on the central (initiator)
> device. But there's no information related to the remote device for which
> is call is done.
> These commits allow the audio server to link this call method to the
> appropriate remote endpoint.
> 
> Chnages in v3:
> - Fix GitLint issue
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/3] profiles: Add remote endpoint path to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb62d17e26f6
  - [BlueZ,v3,2/3] doc: Add remote endpoint path to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdff0e3ce300
  - [BlueZ,v3,3/3] profiles: Fix function definition style
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d04b64003d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


