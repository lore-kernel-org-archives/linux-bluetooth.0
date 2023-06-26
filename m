Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F76EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFZUuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFZUuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88077AA
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 13:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A0960F59
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63010C433C9;
        Mon, 26 Jun 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687812621;
        bh=mkWm+pm4b+2d4TA/zkgt3uByAj5eMdxtAP4nKe6f71c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OpIe/vXRG1fBv35jkKIl4r33PYP3XWnqq/COlvTVFegBiaTIl42dBhxdkpxtgVc8D
         O4y5yd3l8DO9LFIv4++cO2t5/gUAMfFgQ8L8Xa8Z3LyGAoOXX1GpsoxB5PzjyL3qqD
         Xu4P/UAOOiOtdrxqlLVXTchyiABo0eI7JgGWS/XWyDNjp9wQjXAGdHU038vafg8DnO
         j2ZDjTWELl76UoUOqgonF75r4tpQgpzYb0jdrA49dJ+2sIxLUEYJH3ElHZqC6rFJEL
         ByP+ZE9tcPlqBxgv+mBcb8qFY1z78xEbUSanp7dV+XQoe3t6GSQ56et3zbgAhy4is/
         jBx40oIGjzUPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44B9CC395E0;
        Mon, 26 Jun 2023 20:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] btdev: Fix CIS Established Event parameters
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168781262127.4690.6367611945749333173.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 20:50:21 +0000
References: <20230623212430.1702254-1-luiz.dentz@gmail.com>
In-Reply-To: <20230623212430.1702254-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jun 2023 14:24:29 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ISO Interval and Transport Latency were inverted.
> ---
>  emulator/btdev.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] btdev: Fix CIS Established Event parameters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f018d52d4ac
  - [BlueZ,2/2] iso-tester: Fix checks of latency and interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d6456a2537d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


