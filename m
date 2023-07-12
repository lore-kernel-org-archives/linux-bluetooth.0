Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF1DC001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGLVKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjGLVKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 17:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490971FCD
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 14:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA54C61946
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 21:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2259BC433CA;
        Wed, 12 Jul 2023 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689196224;
        bh=mjetRKcA26BEvsmiifj2y4y6okeiEmfHUeFuRyBbvew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E/ju7YrxE+u/6zU6aE5bDqUo3yi2V0UQepyODcknIyVFbzUpyPNvU5MsHL/p8VWIL
         joAr78b9gbJACOwOb7g9zFio/DXlMFxwmEWrr0OAjiVp27LnwBaVC2aWjT65dPqBYC
         7e/DHivAOY11yHeGR9YO7kjUXXpsl1oYJWCPzviF9Xk8bYRTBgAaJsgNv3m658fBmy
         VMASD/ioN0By3+TJK+GSgJ4EtB7CRmINfXbcpjafeZdmRVOQhiVN6gToQ6LML4NrzB
         SVqqLUX8ozOGgGBftjpPtE53X3edfalmGsntndjY5Lbqbg50XgSdMzuvrvb2dH2IEb
         F406Baw0diXuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04F18E4D010;
        Wed, 12 Jul 2023 21:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SCO: fix sco_conn related locking and validity
 issues
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168919622401.11357.16209979465018497480.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 21:10:24 +0000
References: <490b5c6a0e13047fd1bea42d3184b46623adc359.1689003801.git.pav@iki.fi>
In-Reply-To: <490b5c6a0e13047fd1bea42d3184b46623adc359.1689003801.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, pobrn@protonmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Jul 2023 19:48:19 +0300 you wrote:
> Operations that check/update sk_state and access conn should hold
> lock_sock, otherwise they can race.
> 
> The order of taking locks is hci_dev_lock > lock_sock > sco_conn_lock,
> which is how it is in connect/disconnect_cfm -> sco_conn_del ->
> sco_chan_del.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SCO: fix sco_conn related locking and validity issues
    https://git.kernel.org/bluetooth/bluetooth-next/c/23ba0a1d51bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


