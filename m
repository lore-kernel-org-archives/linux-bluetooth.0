Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA6EE14D0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbjIFUa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbjIFUa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 16:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA951BC1
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 13:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 950B2C433C7;
        Wed,  6 Sep 2023 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694032223;
        bh=khPRrN3FWawog6l0bN0eP1sl0H78P//dKrRZH1Xg/AI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OrJtSFD/YCdsauEeIBQwbgYAOFWHSZF0Ij9gVFzHoGeLUTCjogqtS05ZsTbIgRdzQ
         sivPgPp9rbc7yuoUXCUA8F2bKtxC4aSLGGIKiQonmjamLQ0NspbpGEQyWbmzFZ2nm1
         9ILq2eKGHPg60CD55EOPdVZsFUS3Z9iA9yzDbJmfu32mgB255I0I7hoZ5KnSqDiipY
         KLbgdfvzh9PE8LQ6z/G7miIsfs6bm1Uh40BccwHLVJuexO5Jm9NwWOVMSJ3n5z9unq
         qedoextLIYBuOU8G/saHfLZw2HNrGOZ9rcbjN4iEutnKczFkDnXd/NLpGiaPBea0oe
         8t5rVrBJ0adVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DBDEE22B0E;
        Wed,  6 Sep 2023 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: ISO: Pass BIG encryption info through QoS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169403222351.1730.3024614854000477917.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 20:30:23 +0000
References: <20230906140103.9183-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230906140103.9183-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Sep 2023 17:01:02 +0300 you wrote:
> This patch enables the ISO layer to set the encryption field of
> the broadcast QoS struct, according to a BIGInfo advertising report
> received after PA sync establishment.
> 
> This is useful for the broadcast sink scenario: the userspace
> opens a socket and starts listening for a PA sync connection.
> If the PA is associated with an encrypted BIG, the userspace
> needs to be informed.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: ISO: Pass BIG encryption info through QoS
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2fc183c43e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


