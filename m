Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83094EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjF0TuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0TuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6933211E
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FE661214
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5FFBC433C8;
        Tue, 27 Jun 2023 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687895421;
        bh=lPfox//GcSMGlFzndNjArWmqFsDZiR0BQTDAvtZrjpg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MIPuOlJtTt0lL8B0J+j1+y1ggUq8dowEKUOGXcpY/AU/x/2+RG+6AMgfP14HboZH6
         O/X2IKFiI7WMJjGz1hh79X/a5SWHEEeks2xoFK6fyzpv61x+ZONh3+sUDlJ2u3T2BH
         ER6lvAA/QuqaT1YdxNrZMf8eLfFrbBEoGfXNFQdsvfBCww4V1SctChIBfoy55N647d
         CUYhmESV/Lt53XVroyGlgFU1gd5EjRCfYA7lnBcd0ulzywzoshXj7doD7XKQVq0sux
         6/C1BXBXnpP0IcvcVD9E8nmOxzA5s7D6AFS2INxLrzdkK495AAUpfUEcS+kPajS42O
         OKf076h6FPAww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8965C64457;
        Tue, 27 Jun 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Fix parsing of vendor specific codecs
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168789542174.8703.15897147127322911382.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 19:50:21 +0000
References: <20230627183446.2488049-1-luiz.dentz@gmail.com>
In-Reply-To: <20230627183446.2488049-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jun 2023 11:34:46 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> While parsing vendor specific codecs cid and vid fields need to be
> converted using le16_to_cpu.
> ---
>  src/shared/bap.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ] shared/bap: Fix parsing of vendor specific codecs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6bfbd28420e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


