Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C89CC001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 19:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGYTu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGYTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE619BF
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6436187E
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0219AC433C7;
        Tue, 25 Jul 2023 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690314622;
        bh=WWgW2I11KrMvPYi46g5snzKXtMTnPXBm99zoOkfaDys=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E1ygexOVHqApdU/kDNLDULYt/3GntjNH+MQsw2R6UEXmpcXeEoqHFvdHtpN1KLqoA
         uNys+sO7zC/k7h1xsgdFtiedCu0XkICag5ZF6Owg4S7vzRzCVK0htlCoUUjKDB7s1X
         hp7hEAaNNNiaxn+1ycxkt2md6NZoeYJ2YU+Lv9vAYOaODW3q43+nw9s4vDAqpPOpQo
         FkXJ7Fk6B+ZfH0Yfq85Mw5opLa5d2C/L7rbo+Dq9WdmkQTlPpqnwyFc58J2DthKM+6
         1PHdg67KOWmRavbJJ19vgAQz1yXxw2N+PC1TUEzXdFo6IF/MtVpMlfO1BiroA2VwXO
         bGlH/NfrqPYgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D274FC59A4C;
        Tue, 25 Jul 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/3] Fixed the crash observed with VOCS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169031462185.19624.11352500926929002201.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 19:50:21 +0000
References: <20230725112126.49656-1-nitin.jadhav@nxp.com>
In-Reply-To: <20230725112126.49656-1-nitin.jadhav@nxp.com>
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        pav@iki.fi, luiz.dentz@gmail.com, sathish.narasimman@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Jul 2023 14:21:23 +0300 you wrote:
> Hello Maintainers
> 
> This series of patch handles the fix for the crash observed with VOCS when trying to pair with LE Audio TWS earbuds and few other issues.
> 
> A crash was reported for the following patch by Pauli Virtanen <pav@iki.fi>.
> Patch Link: https://patchwork.kernel.org/project/bluetooth/patch/20230612133251.194-4-nitin.jadhav@nxp.com/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/3] shared/vcp: Fixed the crash observed with VOCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06ec4f61000a
  - [BlueZ,v3,2/3] shared/vcp: Fixed issues related to read audio location and descriptor
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a0e392b40fa
  - [BlueZ,v3,3/3] shared/vcp: Corrected handle size to accommodate included service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d714becb7df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


