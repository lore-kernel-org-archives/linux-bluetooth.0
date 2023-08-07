Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ABC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjHGXUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHGXU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93381721
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65B3562314
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 23:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C14ECC433A9;
        Mon,  7 Aug 2023 23:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691450422;
        bh=4chEL0QAj4WCHFDX7o1sFMPP6ybp00n6+4Te3wT4cSg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E/PJs0TUlVGwEv8DNZDmAOFOMCuiV64Xl25l3qMixLpCuJ9n57FZ3pSfws9QKE5Wf
         JsmUqCVpbjtYRe7p6XLTi/USkc1nTRd9S8F/nRq34AGipwDlQuNlfmN3vmY9gGC00j
         7z6nGjOCQh7F3HwurvZLaiAIWK9j2qx4p884//MeQWpLjWa6BlRCr8i1hm+0U/8BJu
         ALzSghRXoPWjYNLG80IYRU771uaBoZo+VD5jP6kkGcViu1uZz8gIUaQqKyGBaUzKFM
         lGRlyeOG7ob1h/cGk1HvcVRzF/AZCKhmEQeFy25NNYBxI8+9F5eIwYz1dw3ilitvoA
         JkI40VXpaG3jQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A49F4E33096;
        Mon,  7 Aug 2023 23:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Plot RX information with -a/--analyze
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169145042267.20955.2357194734963583129.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 23:20:22 +0000
References: <20230807215825.1251961-1-luiz.dentz@gmail.com>
In-Reply-To: <20230807215825.1251961-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Aug 2023 14:58:25 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to plot the RX information just as TX:
> 
>   Found BR-ACL connection with handle 256
>         Address: XX:XX:XX:XX:XX:XX
>         RX packets: 60/60
>         RX Latency: 0-39040 msec (~20294 msec)
>         RX size: 6-344 octets (~34 octets)
>         RX speed: ~0 Kb/s
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Plot RX information with -a/--analyze
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d987ff347b83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


