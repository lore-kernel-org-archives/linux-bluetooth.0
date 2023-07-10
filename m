Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26462EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGJTk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGJTkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71112E
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB6F6119A
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B25DC433C7;
        Mon, 10 Jul 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689018023;
        bh=+s9ofJHORqEjJlAOSLmVqs4I5TawP94KbRExT8pq1ck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g+YJEx13p3mrdg26XZkP1qEZdNb3dvH76P1hntg5blzxkSpQyXRHeT1/gY7/1r5lf
         XcMIma44Fe2kqUspZ8//7f0LS2Yq7CEPuy5RNfUEmTx1GIjw6f/2bXgvXQJ4uTJz8t
         3kg1Q6BO76oJ9Y051Hl3amp0odstkmurO6eAlApul1iFDEG/GYw4d5yRtJ7/IkU7lD
         nd+Azu8fxGrpZi65IQ56a9TQ9NPC5BC8owxJM9pYbbS2mGAqpkxnNO6NszD2Dfdyyd
         SvRsYpFnA6+Iuc5VuAgI5Gu/OwlqK2QitmX3ttwHEgOsRb9DN6y1mh5dIcUtbJzdEV
         wqYKc6Wjy0k6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F182BE5380A;
        Mon, 10 Jul 2023 19:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] mgmt-tester: Fix tests that consider 31 bytes the max
 adv lenght
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168901802298.22137.1702792252987182979.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 19:40:22 +0000
References: <20230707224434.677627-1-luiz.dentz@gmail.com>
In-Reply-To: <20230707224434.677627-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Jul 2023 15:44:31 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes a couple of tests that consider 31 bytes the max advertising
> length since in case of extended advertising that number is actually
> 251.
> ---
>  tools/mgmt-tester.c | 71 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [v2,1/4] mgmt-tester: Fix tests that consider 31 bytes the max adv lenght
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b9e7ca94d458
  - [v2,2/4] shared/ad: Fix hardcoding maximum data length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2cb07aa669e5
  - [v2,3/4] advertising: Use bt_ad_set_max_len
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=153aaeda2b21
  - [v2,4/4] client/advetising: Allow use of EA data length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4578395b5370

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


