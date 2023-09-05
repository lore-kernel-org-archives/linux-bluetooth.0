Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A675CA100C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbjIEUIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjIEUIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1347D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 13:08:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89627C433C7;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936913;
        bh=uJuE9MBOxaoLEOwoMb5F/uJMKB7aL2COKluO1b+NTGA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pWku/Fglz1kxCtCGUXiJFNinmsbacef5otVUykgvvCCGSXXGlKJgZyJIYJq0DqsmA
         vfPVt0ZAMJL6xF2DeVDIjj9A/SZYFPO9bNpaEBu5lgwqs3g6lkk3N21U2JK7oOsCS1
         lYq2+21FOFXeTuMfXHUGRnfea3Y8+abBNIv/qm5JYrm0B//twppqeX46eXNn2hlpgx
         tacCBU7/FnVF70MIb4Fkq/12rxnMSBjtSzLtsDukq5d7P9FGx2gwa/KDnAoBCszdyT
         4Wo6Y7t42JwpXoPqdebf1VDG5K2J0DvMKY18Rx0mOpdO8s0fdrovqS817N3ldc5eTR
         l/rHUFheffg6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77E01C595CB;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: ISO: Fix handling of listen for unicast
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169393691348.22693.2684682455495633652.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Sep 2023 18:01:53 +0000
References: <20230828200545.580103-1-luiz.dentz@gmail.com>
In-Reply-To: <20230828200545.580103-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Aug 2023 13:05:45 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iso_listen_cis shall only return -EADDRINUSE if the listening socket has
> the destination set to BDADDR_ANY otherwise if the destination is set to
> a specific address it is for broadcast which shall be ignored.
> 
> Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: ISO: Fix handling of listen for unicast
    https://git.kernel.org/bluetooth/bluetooth-next/c/2595dd981e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


