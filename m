Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617DEC4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiDSADC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiDSAC4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9EE00F
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C9AB81141
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43847C385AF;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326412;
        bh=tSaYho31IHpk+gX3TWhrKoMpGlI199We9mOU4HaR/3g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q8CF45Bb72SfvyCmLRzhdx4tQfIVKx4Gp9A6qbgjCuDv8K0IYRPOb3Vl0osoye6y/
         0qga4+qmu0NP5Q4ZdSeYa5389YPnYJ6rRpHpdWqT3OZMt1kRfUo0Z8MlwqaB9GrfVA
         4xucp+rBwJF7vGQmu+WyqiavikoYYZnUCLfYHFUeRq1OJJ4xUmOM7haHPH1W1/EKq9
         HhXhyRNJqXl0fZKZpGQ0he1M+YuWqAbyjhynoFn5BQoe7/5rbtwaaN6GqclZ2a7t/m
         F+Zq9S23WGzP9zAOGMNjelOL4ycd/7GShrBnlk2T9o032Ce2/VZKnKywNFZlFF4mlb
         aiWYlRbBuTIjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AC1DF03841;
        Tue, 19 Apr 2022 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test-runner: Add dedicated option to start D-Bus
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165032641217.24068.236472082063422371.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Apr 2022 00:00:12 +0000
References: <20220416001853.1240822-1-luiz.dentz@gmail.com>
In-Reply-To: <20220416001853.1240822-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 Apr 2022 17:18:53 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a dedicated option to start D-Bus alone which can be useful
> when testing the bluetoothd with the likes of valgrind.
> ---
>  tools/test-runner.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [BlueZ] test-runner: Add dedicated option to start D-Bus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb4997fb09fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


