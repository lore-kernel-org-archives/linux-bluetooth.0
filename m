Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8BBC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 22:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGNWaQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNWaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 18:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06255466D
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 15:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DADE62036
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 22:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABF6CC341C6;
        Thu, 14 Jul 2022 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657837813;
        bh=JJLzzIMlvIlFK1MgQulsmMUwZEFYpiHx8hETSHWebBg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LdyU2MsPysKp547VZ23oKyzwZUcviZ+sf0eaMg8j7041aornHioBMteScgVsiygS0
         JA4KgXGFHlJSsLGU1hpsnttb2P9sw3m07mDvAq/LvY1yBPCdiOO8Nf1GON0CxF+VGR
         3MTGSbu70K4PzD7xCFIAulKM6Bn1zQITsh7Cyqz5RaqHi7+x+RCTvKHUJlHIVxc+l4
         ZY3jnzJSt9kIETmT9cITfQugh25RHsyriVGWZganGKzef5xRjQxKq9mWBDD8BPLzvT
         KAzhx6XGdZ46cctf6S34dbR0a+vRunTFZTUPUuA3LcLTEIuD2FKjeGjwb386IYJbj/
         KvN3nxvMHBWnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9270CE45227;
        Thu, 14 Jul 2022 22:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] main: Default device_privacy to true
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165783781359.2596.16132188136596521441.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Jul 2022 22:30:13 +0000
References: <20220713234655.3524356-1-luiz.dentz@gmail.com>
In-Reply-To: <20220713234655.3524356-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Jul 2022 16:46:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If privacy mode is not strictly set to network set it to device
> otherwise network mode would prevent reconnections if the the identity
> address is used:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part B page 2837-2838
> 
> [...]

Here is the summary with links:
  - [BlueZ] main: Default device_privacy to true
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af998fd32c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


