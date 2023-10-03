Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E8BE8FDC4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjJCXUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJCXUc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFBE8
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 16:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46CC8C433C9;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375229;
        bh=rxWsuLcW2GdFoA1u2njszkkDPFTK++0xHcA1ZXRyQv4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nfD7QcGdyt29PghJkTn8znoaIqq+ni+K/RNTIN+RxPpLZufKe4QYwrlO17o9C1Dyi
         RnwytQIL4ZgcVBtTkC0LwLlc1XelbojRRunaq+liFLQ1EA7pzHyDq/Zvs4nuEbOQb/
         KdPrPYHX9fN1eZPFft1K6kzFVNAHeiKLuHliwGAQR6ZTR3NnH77Dj5UBGmwOpzgEDN
         YkV7ou2EAOUTvHtrth08XUFzQbi/Ogg29xZAFhyrgBLNCHlDN5rJJSaspE61L+/8tO
         jksdTKC9NTAodiGRS3A9LXHkz3lT9CZpRqZTtanfaUgHEZSD/xDxJXMESFI2Sgd5KT
         ZkzJ8q4sLKnfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F789E270EF;
        Tue,  3 Oct 2023 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 BIS unset
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169637522919.21629.12052597362468031555.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 23:20:29 +0000
References: <20231003143840.3009-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231003143840.3009-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Oct 2023 17:38:39 +0300 you wrote:
> This adds a new test for the ISO Broadcast AC 13, when the BIG handle
> is set but the advertising handle is unset.
> 
> This test depends on the kernel support implemented in
> Bluetooth: ISO: Match QoS adv handle with BIG handle
> 
> Iulia Tanasescu (1):
>   iso-tester: Add test for bcast AC 13 BIS unset
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] iso-tester: Add test for bcast AC 13 BIS unset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=232f6f68531b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


