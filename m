Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85670C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJSUk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiJSUkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 16:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495BD259E
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 13:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40799B825E3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 20:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECF2CC433D7;
        Wed, 19 Oct 2022 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212018;
        bh=pBzBaR9qB1n8dBVscvTCRigXP0viAPEJZFhPC5moAJc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jGhQeXFZhliopmTicz9lChk3lIsTFd9/o72gyITxiXwiJBxXTi1xd/vcu8i5dKzom
         0MlU+nrk5OKlRombBEvoHakk/U1cwFoe2GwsRu9VVi9GzJTmaxYotNZbLqr38v/CnU
         4hGe54zvM3FKXhBqVIjpc5cno7Sry9HDHPtluwdJrHbRdpGy3N51n+SUeRFBV06T8V
         RwL2nY04QLvnjl+6O+FeZtU5K882qF7CdSFt3jD76dHkPH7xPWEsXr0/j2ZwpE8lbK
         ad+Dz2u6NR2RkaxR6MKE6DE9hBHKMqXj2U/LZYrwBRsSoppoDdMP2XN/lsPw2/n1gE
         iEGc30wzeFXIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8DEDE270EA;
        Wed, 19 Oct 2022 20:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] settings: Fix scan-build warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166621201781.31309.3295541299434875636.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 20:40:17 +0000
References: <20221018234600.3990980-1-luiz.dentz@gmail.com>
In-Reply-To: <20221018234600.3990980-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Oct 2022 16:45:58 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning:
> 
> src/settings.c:281:7: warning: Branch condition evaluates to a garbage
> value [core.uninitialized.Branch]
>                 if (ret) {
>                     ^~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] settings: Fix scan-build warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c739ba22f09
  - [BlueZ,v2,2/3] monitor/att: Detect cache changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a49b47f241ce
  - [BlueZ,v2,3/3] monitor/att: Revert treating Notification/Indication as a request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=68155e2f7e66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


