Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF98C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCKAlc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCKAlD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:41:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2FD133DB5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815F261D97
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 00:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19ABC433A7;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495220;
        bh=Rxy5xiyauyHM5FlJVT+w624RD23NvC7TG4vLysLyQR0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uxcQAb9C2v7CH88tnd9ANYN/jxJSKbYbziWDdq6m8Kau4BFh0OoAJjeXxaXManOd4
         1XEMgHsfZnzzO2f14p258erleGOScoQj/ER+YomceICkFKCUxIoTTDYiov//osXPMg
         KOW5IzciZp2dKEkv1rnZUCJNvjvmlQ7IrnTqUO1fCjPMiS9ivqZ/r4Zwc10cqoqLws
         IqnWsT6W3mKS4d95PlqR7ipvamRmjkNJIDSc9A9zF/QJGqaG+j4CwEkCGZNQJp4iPh
         PN3SEpNZ7bBR/EoEUySJA30HmaMODH5graREOoUATnKcK73/qSbLs6T4xSM1Y9jHkJ
         sT2JKRPWOMIOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C49A4E4D007;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] iso-tester: Update High Reliability presets
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167849522080.21816.8868222366994265405.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:40:20 +0000
References: <20230310214001.3891437-1-luiz.dentz@gmail.com>
In-Reply-To: <20230310214001.3891437-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Mar 2023 13:40:00 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This updates High Reliability presets as published in BAP 1.0.1:
> 
> https://www.bluetooth.com/specifications/bap-1-0-1/
> ---
>  tools/iso-tester.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [v2,1/2] iso-tester: Update High Reliability presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0847e005d33
  - [v2,2/2] client/player: Update High Reliability presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31ab084f072c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


