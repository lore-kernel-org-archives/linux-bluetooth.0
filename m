Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5AC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 18:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIZSMr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiIZSMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 14:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32D6B645
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 11:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9489B6118B
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B9BC433B5;
        Mon, 26 Sep 2022 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664215216;
        bh=oDcysPFKWl1FNIjg+c8XtaPeoxwhZr3dBhCN4Bt52cQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RcPIc2XsmCtQ0pKgOJG8QovdGvpvSDeCXbkSDPFtg8bNU6vxDjR3oE2RyuhR6vAl2
         DmC+4ZhPm+3Q3Zki8hpMkYEB1aSek8DA+7vjXsDMRYCey/JAPTjF+pYNxJtm98b+uk
         pA7hTG0VvXtOvhYdBu9/KDuK61qYVuPK8xCID89EoZCRMuqNqsHUIFH3uBkPUENKdL
         iUPfane85PjR7YRKG8pmVRR7MmV979HdkSw7w2hZISRIZ11n9MaNKNUX3TjZUMOgoX
         zjzZS3PYJEhuZ9alu/k1CfoMWiLpb5vEBWNkU+TjjTUzxcdMMp7u1o4G6RMzgPM/TP
         ToB2QtGKDz5SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D71EEC04E59;
        Mon, 26 Sep 2022 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/mpris-proxy: unregister object path if player
 registration fails
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166421521587.25050.5261779057199581580.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Sep 2022 18:00:15 +0000
References: <20220925163139.194382-1-i@hexchain.org>
In-Reply-To: <20220925163139.194382-1-i@hexchain.org>
To:     Haochen Tong <i@hexchain.org>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Sep 2022 00:31:39 +0800 you wrote:
> The `owner' string, passed as user data, is freed if the player fails
> registration, but the object path still exists. Upon program exiting,
> the lingering path will be enumerated and the attached user data will be
> freed again.
> ---
>  tools/mpris-proxy.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] tools/mpris-proxy: unregister object path if player registration fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7738e9ac416b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


