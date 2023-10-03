Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4005E8FDBF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjJCXUd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjJCXUc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E63DC
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F3ABC433CA;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375229;
        bh=1iZcCgrBZMlkWRkIFeIUXqJWM2OX3QVnOopuICG62+s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AaM9uw/OJ/yaUzRTJYJoc4gz/5BOZeBLM1LsMDOmOywlBw5AC//w7IoiGSRgO8fdf
         AMTzPOkenT99ZVhvEe4wQKqyHzATTHQmiVRvFRsY96ddq+rQFbw9eutWkBc/1Pxw8P
         9j6HLKNEsSS+QbHHAp4PzfhRxBr/L2j9e+G3eU8NI/iwakjLiE7zskYTDKm9sqCcBW
         59Th9zz/u36HL/w8n5d8tUSeV8VUol/8R5ACB5y2TDb0QiMcSU2LvVOn4zEG1HfrEb
         4ReFrGvtkwa60KHorqXkyXlQVugqsuXwOtwgj8CpsADS+CrpVxHcCzcgfGqpeZccIW
         HB2PzvEXHEU8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38A84E632D1;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/mgmt: Fix registering pairing callbacks
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169637522922.21629.5075861699176018133.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 23:20:29 +0000
References: <20231003211442.3348427-1-luiz.dentz@gmail.com>
In-Reply-To: <20231003211442.3348427-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Oct 2023 14:14:42 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Don't register pairing callbacks until mgmt.pair is called otherwise it
> may take over the role of pairing agent when bluetoothctl agent is in
> use.
> ---
>  client/mgmt.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ] client/mgmt: Fix registering pairing callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9741e47aebcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


