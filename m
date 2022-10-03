Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 21:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJCVek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJCVeU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 17:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C32018E
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 14:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2366118C
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 21:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06A63C433B5;
        Mon,  3 Oct 2022 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664832616;
        bh=mFfULEXopfGJjIWwIYTVi2Q4Pvd3R/qVKct/Fgq/jfc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d5gFrXLIcybHvOEB8vfGRfg3jrXHTxUSpkdnn1jlU9gFYI+NwB1SQTnop4RTU55NT
         pO5ltaMR2lk5eyalcM8CtPAPsjPly+aoJE1kg3puqJSChiYRxRY+Klk0bykMcoyiLG
         vSnRuRPR7I/IQ6nZgwjw50RMt90e/+Jor7js6gTZBxqf4LS9TgY+oqvhLCK0HJzq3E
         NW/TMmvKO5/Az3g043COy6kcE93FWndFKFOiPLrXKsfeXCMLrrpP3V4yB2yjD7b9AI
         K6fujFDFFgykhvehVmJ+iF6ppK/qBzUekAMAQxyUraEfUzuPwUZE1AQuSZxJl7JPQW
         Zip0XRrOaCFdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9105E49FA7;
        Mon,  3 Oct 2022 21:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Mesh: Fix IV update and KeyRefresh procedures
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166483261588.16287.9790491542388999429.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Oct 2022 21:30:15 +0000
References: <20220929110344.26130-1-isak.westin@loytec.com>
In-Reply-To: <20220929110344.26130-1-isak.westin@loytec.com>
To:     Isak Westin <isak.westin@loytec.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Thu, 29 Sep 2022 13:03:40 +0200 you wrote:
> Hi,
> 
> Here are some modifications to the IV Update and Key Refresh procedures,
> based on PTS tests:
> - MESH/NODE/IVU/*
> - MESH/NODE/KR/*
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] mesh: Ignore Secure Network Beacon from subnet
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=926d16db8ae4
  - [BlueZ,2/4] mesh: Ignore SNB with invalid IV Index values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7d050890f01f
  - [BlueZ,3/4] mesh: Allow Key refresh to skip Phase 2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d22d5424430
  - [BlueZ,4/4] mesh: Allow Key Refresh Phase 0 to 3 transition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=291cff068009

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


