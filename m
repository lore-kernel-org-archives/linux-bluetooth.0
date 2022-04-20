Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 01:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348286AbiDTBM6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiDTBM5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 21:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC44818E1A
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 18:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C4961519
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 01:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB470C385AA;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650417012;
        bh=K46w5JgDDfnBcOk8nr3xKGPZTdTRPounf9A0y3dIfgI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XKn9SNTX9oNZx6rJKV6usPqrqARWAcfFv3sLPZU+tw7O6/HtXWEwHGZlEOZZ275yc
         MpKVuJ/6LefJGd64vRasJ1tiI6qTPHfbPa8nUxqB2+Zbn+01GEjl7DcJUcMpQfZKTR
         L1nxNjanbE4b5UMzkVg99s/e0kFGWZqqUuAbZXP7ZFje6M+bKWL1icCrp6R2Ohm7yK
         F+xT8wZqtYBFEYwFAjiJq2RLjkWrObqlXohLDCzXFaqhayM8Ti1Kn0dSg65LNqk00N
         1O4Mq2hfeZ2d6Pu1ApW6B++MlLA4zHEJoVQBOkDyAYyaVN2NjgrPWfqVugfppzuqT6
         SnVkgIu4w8Fjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFC60F03841;
        Wed, 20 Apr 2022 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bluetooth.service: Set StateDirectoryMode
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165041701184.8238.7355734299391782380.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 01:10:11 +0000
References: <20220419182237.2531907-1-luiz.dentz@gmail.com>
In-Reply-To: <20220419182237.2531907-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Apr 2022 11:22:36 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This sets StateDirectoryMode to 0700 as it is the current mode used for
> creating files inside the storage and it is different than the default
> systemd uses which is 0755:
> 
> [1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#RuntimeDirectoryMode=
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] bluetooth.service: Set StateDirectoryMode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=edc69d253445
  - [BlueZ,2/2] bluetooth.service: Set ConfigurationDirectoryMode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00cfb36e20e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


