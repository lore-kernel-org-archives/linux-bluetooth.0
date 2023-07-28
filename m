Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC5AC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjG1Wu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjG1WuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE63E1984
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4D962214
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF19AC433CA;
        Fri, 28 Jul 2023 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690584623;
        bh=g+Y59QCRN3u3ayRqLJHs/V5hboWNejqbolFXtr8h44E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nTv+l/E9xI/09c6ABa/sE/ogq4NjaMJm937U36TUJJjVkji+CyBYR1BGaUXEkB1n0
         XtrYJxQNIdIVD3KwEfcMTIf0Dh6vPn7X8GqS3HG650NpFBBG4jrrZehn+pi8T5oHIt
         e9259/0+W/xkIcG6VN9/0TYAImRrwKpU5dvBUkVptY+n1Iq4kSw/QT2Bw7TPybM881
         +1EObHbqCYKYpRflk6tvgfSoYcUcAbU2eyog7ljhHCvcT8+tX/DxQFDXypdxtQbEtw
         78yYSl4HQH1ChcShsI7NyA7bPrfrG4WyolgwUSiH2VEV6AaKoz8YrolwKFeZ+BOaWm
         epBYyqXPSY0Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D92AE21ECC;
        Fri, 28 Jul 2023 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Fix generating IRK for adapter with privacy
 enabled
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169058462364.19376.2651147391731808361.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 22:50:23 +0000
References: <20230728044556.575664-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230728044556.575664-1-simon.mikuda@streamunlimited.com>
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jul 2023 06:45:56 +0200 you wrote:
> When root folder for adapter doesn't exist we will get this runtime error:
> src/adapter.c:generate_and_write_irk() Unable set contents for /var/lib/bluetooth/00:00:00:00:00:00/identity: (Failed to create file “/var/lib/bluetooth/00:00:00:00:00:00/identity.EKQ581”: No such file or directory)
> ---
>  src/adapter.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] adapter: Fix generating IRK for adapter with privacy enabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=16c1166d8737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


