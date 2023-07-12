Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B75C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjGLWuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGLWuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9701B19A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D71C61986
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8468AC433C9;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689202221;
        bh=nmMT3zrcEmKyiNxPsMpOVniDSvs5ia94v21mPw+QpJA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nDo/eBS9M2gVr5SthXqrcsBn5EWhoHC8MM2OTDted4SNRC4REICU0HTHkE7SZn7mE
         j/Oa4PmlV1C6mhiHCC7LecqnVE52+E79gtsMYIE+TnwQzmWJWCBrZz8PpsLqpW9CFS
         B6iW7rZBLWvl9ppIKtAjyRMeSZjiydzXjdbxrZpZW61Yg3zluXX7hq+WiPkmR7AfHJ
         M0sEy/JB0p98Ua06QFotFyq7UChoFIOs7rZaNUM1lSNfaqPoOKXWu/lIXLEY76l/Et
         nsJwtLst11PimOOpJd64p44qJfA0ZC7yLiC8JWokoppdAY6qsSryRBtRhvdWXBeeP1
         ErIhBdGKunv+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E766C4167B;
        Wed, 12 Jul 2023 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] shared/ad: Use util_iov_push_* helpers to generate
 data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168920222138.32437.4150773018743381539.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 22:50:21 +0000
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Jul 2023 12:38:50 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of util_iov_push_* helpers to generate the data.
> ---
>  src/shared/ad.c | 163 ++++++++++++++++++++++--------------------------
>  1 file changed, 74 insertions(+), 89 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] shared/ad: Use util_iov_push_* helpers to generate data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c48468328f28
  - [BlueZ,2/5] main: Remove DEFAULT_SIRK
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b0087bc3d25
  - [BlueZ,3/5] shared/util: Introduce strisutf8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1b33eb8bf0f
  - [BlueZ,4/5] shared/ad: Make use of util_iov_pull_* to parse data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc2ab4ba3c61
  - [BlueZ,5/5] test-eir: Run tests using bt_ad
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8f916b7ee6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


