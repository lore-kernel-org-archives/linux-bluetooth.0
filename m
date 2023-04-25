Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC47C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 21:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjDYVKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDYVKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 17:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA5121
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 14:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 834D163068
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2033C433EF;
        Tue, 25 Apr 2023 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682457020;
        bh=GQhkHecmq7bnPUhxKa4HDtrdffZ4L9MkD3LzMzGt4K8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cEoZKWMI8HAQYRSBes27XxOTXldu9kmPNJk6EP/tcY87JQLs7xX5aEffwvAorsFir
         bYZBbGAT6+9jr+nPLQVvGsq/wFMu2YYRubH6nJZH1GC7ynb7onwyXCCKzGN/yHIt84
         nINHKgCGTeipyboEcOQExhfLesqdFkK1uSCju8Q/edccs03BVQFnq4Wiqyc2TUJzRM
         RNYASYTAsc7XN3dRvSa9Tn8J33XW4WR9xMopnDbSN0aBbN5EQdyuJhIHRKnuqhMOQY
         ckVhXZHpyr3LkK/1tymLNU2MA0f5Hd4oun2n048qDNEpybZcC9zqqDv588wevyH7DL
         I2mwOhZtnlBKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3EA3E5FFC9;
        Tue, 25 Apr 2023 21:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/bap: add function to get location from PAC
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168245702079.26790.9427550310181073194.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Apr 2023 21:10:20 +0000
References: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
In-Reply-To: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Apr 2023 17:05:56 +0000 you wrote:
> Add function to get the PACS Sink/Source Audio Locations field relevant
> for a given PAC.
> ---
>  src/shared/bap.c | 14 ++++++++++++++
>  src/shared/bap.h |  2 ++
>  2 files changed, 16 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] shared/bap: add function to get location from PAC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5910b7852801
  - [BlueZ,2/2] bap: add Location parameter to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f88c59391b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


