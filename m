Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52336C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 23:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjHDXaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDXaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 19:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE410D2
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 16:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B48B96216A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 23:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2079FC433C9;
        Fri,  4 Aug 2023 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691191822;
        bh=ctvS8XgAyeSdymc+6lLkW3V9cGWvibz7qcpsNR6X1KI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WVBMVQVNSb451GhIpWARjpEmjIeatZDZBRyCTRxeq8J/sMQyiPHe7qS2RCGo69Spf
         DYAru2fYN2bTULeYClL3hjPJxRq/eWEDvmG3wv7O/9JrGxyLmEplttc2CIdIIcaifZ
         l+kCbfWEPdC1kfoGFzNae+WXKaJMXRudKAF6VLC4vZHJ62sdeQ8cGOgaXVzSF/ieC2
         uxe40ULrxaPKVHZQYxOr9pvhCKo9d7xB1pU9S37VxdqV4A8TN2y4IsY8XbhlujQd/b
         55otQKBZfVHAzvZXMnshOobbrU680h2sh8kI4nt5fCZE8ZvfTVI77lRBYWU8lZXrV6
         b9KE/5OkbVdaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07C51C64458;
        Fri,  4 Aug 2023 23:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: Fix test ISO Connect2 CIG 0x01 -
 Success/Invalid
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169119182202.26954.2637766634810911747.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 23:30:22 +0000
References: <20230804215733.1049271-1-luiz.dentz@gmail.com>
In-Reply-To: <20230804215733.1049271-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Aug 2023 14:57:33 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This test shall succeed rather than fail as this appears to be a bug in
> the kernel code preventing Set CIG Parameters to work properly when
> there are concurrent tasks only one CIS is being programmed.
> ---
>  tools/iso-tester.c | 29 +++--------------------------
>  1 file changed, 3 insertions(+), 26 deletions(-)

Here is the summary with links:
  - [BlueZ] iso-tester: Fix test ISO Connect2 CIG 0x01 - Success/Invalid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9665025cc042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


