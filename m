Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91688C7618B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCNTu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCNTuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705E2E808
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE2AAB81217
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A81A5C433EF;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678823419;
        bh=3PUt6eIXTwomjg2c8+P1fgTFhTtzVxAGe7O2gox8tCs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gfx/OLBG01k41YXG4CwfmIRo5E5l6Atp34/V6s83EI2UxEBTwnj3+HA141OjgBONd
         YG3S+tIADyx036bk+4PZAPTpxzOiJh44Wm3Dhn40KuIHZe9JlP43bAwu3wQWcoGXlo
         bvC1m5Ej7kvwxihB5Rg5GSlrGg3liHg5TTrij69x3Qp0V6zihcr6wRdQ3NYG9LLJQG
         7Ih7w4XZP0Ko9gfxIopPFasGlZPXFcUzShX1KK4YQHb3lGUc8F2OIl29G5qXwENN4v
         MaisKEcSF5GMfiBI9HJaAeP49IbkyBVqgPg794I/XoPmIGAdGDD7oAwjthBzBTB9qo
         wDr6x+zDVlH4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D312E66CB8;
        Tue, 14 Mar 2023 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] btmon: Fix decoding truncated data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167882341957.5310.3144633202876049373.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 19:50:19 +0000
References: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?q?=C5=81ukasz_Rymanowski_=3Clukasz=2Erymanowski=40codecoup=2Epl=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Mar 2023 15:52:17 +0100 you wrote:
> Some platforms use different filtering and for this purpose,
> some of the ACL/SCO/ISO/SDP data are truncated.
> 
> In such a case, included lenght is smaller the original size.
> Without this fix, btmon stops working after first truncated packet.
> ---
>  src/shared/btsnoop.c | 2 +-
>  tools/btsnoop.c      | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] btmon: Fix decoding truncated data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ae44c74aaf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


