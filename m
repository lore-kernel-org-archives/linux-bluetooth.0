Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0836C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 23:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjE3XUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjE3XUX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 19:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DAEE5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 16:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C64F6634FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 23:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F895C4339C;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685488821;
        bh=Dyl3Nq6T3AbZQy39zi99Snny2BsLlEw+vWjQaINlp40=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EF85ibS09CUyesayCNjt7IXJG5KczanJyXSo2W/ZLrSLtalm97NeYuN3d0ygHYb2H
         cY9bmf8qG/oXiM9let0ycVyjE1nCXEbe9iWomnEePneu3g2leHbjr+Ma802xNkEt6e
         wD9GcEGeJEdNL1t0Yp6a+LK8EsU76P7GUsz0Acdf9aiYaINHH2cXahM7y43j1fbKLX
         iqracokOM3hDmFWBb7qToChM+bemrYRTersQ0DF8JnEOsisrMLLHvFKWmPLaCiUnEW
         4QCssbb3oxMiafDfoSMmW428d+jpUe3p/mjRhdvHFPsT3VfVDKUF9+pRNKCJ0xMFsY
         4I9v3QKxKcDvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B9EAE52BF6;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] iso-tester: Add BAP Broadcast AC tests
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168548882104.30926.6709770977617423883.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:20:21 +0000
References: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 May 2023 09:24:56 +0300 you wrote:
> This patch series adds 3 additional iso-tester tests, based on
> the BAP Broadcast Audio Configurations.
> 
> Since Audio configuration 13 requires a Broadcast Source to
> create a BIG with 2 BISes, this support has been added in
> btdev. This implementation also depends on the kernel support
> for multiple BISes, introduced by the following patch:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] btdev: Support multiple BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97edc78bd81f
  - [BlueZ,2/2] iso-tester: Add BAP Broadcast AC tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


