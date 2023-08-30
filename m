Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9FC83F14
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjH3XA4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbjH3XA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 19:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74055B5
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 16:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7ECAB82028
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 23:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEE3C433C7;
        Wed, 30 Aug 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693436425;
        bh=oaO90CB6pdr3hqwP3mPCQIXTjgka0rgkkcS/GI3p3hQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fNpcjxgDdZrkVpWKCkcDWsqEqbyclB907gulzd1UN1kucEvqs/LW+0V9gSV5SA6q3
         wovmI7XPCnpd8ORF7+crKw6daRipCMi+nHwFc0XZpy5aWQuqcpVbOfNZV5FKKDuVYI
         VYqBZCe1qGU+Lu18ZfC17mnYly/hMpxmUIFTnA9fywo4HchxZiYOcAoCQIZPhXSV05
         6d37NBdBMP4nExkR9tbWsisDyGzqSzyfxPnKngEVFR6Ql7aC1fDDlHKbYLVSHikIq+
         sw0lcMS8g+PmyaMQ6/MVTt2FstK4xA6CL855oFUJp+XFqr1O9XC8+6jCwm9OHGIGYe
         tb/kA7jpqWjvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34785E26D49;
        Wed, 30 Aug 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: Remove duplicated code
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169343642521.10818.9740464125299225897.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 23:00:25 +0000
References: <20230828193011.551312-1-luiz.dentz@gmail.com>
In-Reply-To: <20230828193011.551312-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Aug 2023 12:30:11 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bap_create_io already handle streams of differents types.
> ---
>  profiles/audio/bap.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [BlueZ] bap: Remove duplicated code
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc35476450af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


