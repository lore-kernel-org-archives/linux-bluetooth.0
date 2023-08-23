Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78978C3DA66
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjHWXBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbjHWXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A1E6A
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2FE652BC
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CBF2C433C9;
        Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831624;
        bh=I/cB6u31K6bXx79IcVU+dm4NUrlqMElx90Vvo4moi0k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RMqtbYvCsUmEnmdsvZyA30mEvNP7Y4eiZn7F6dC2HI6EYE2VrAP09kQ9VCLLysWa1
         Ci7UFTflXlrsiQQmZKUuPaSyMP4ZTWMlUt/Wr0hRqAFYsR0WsDAqTi1Ke9qVJdTFdc
         9/7iu1dJ6pfQwEwrEt6FEp3lYIc8Taj+1tghizqVB6sbXG9l97k/vszYft3Tz84bTe
         icNeuh+aFE2aWBT4WhksttGfUre2cfVn9bM0/WdxztHfoBmzqXOu++aLxcu7Ya6qbR
         noAXcRN7WoTmHg3iQ9k+PMmqKnleMEkzmTG/Bj/VqXJT+UWLowf6OINvCTJ9njtzwH
         nJFcMCcxh6Jfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E54FBE4EAF6;
        Wed, 23 Aug 2023 23:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client: Add agent auto argument support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169283162393.30787.11995845607372543081.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 23:00:23 +0000
References: <20230823205028.3903879-1-luiz.dentz@gmail.com>
In-Reply-To: <20230823205028.3903879-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Aug 2023 13:50:28 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds "auto" capability which behaves like "on" but instead of
> asking user to confirm/autorize it automatically accepts, which is
> not secure to be used thus a warning is printed when user selects it.
> 
> Usage:
> 
> [...]

Here is the summary with links:
  - [BlueZ] client: Add agent auto argument support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35c706f3986d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


