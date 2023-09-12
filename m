Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E1EE3F0C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjILSub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjILSua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137ED199
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8E9FC433CC;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544626;
        bh=h0hFX5EF0Zm7+xzW8vXlElgMVfcDwISIn++J0Wyye9I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZuwhydxoYzduDVkDLMmCXqp0iOkGHHPwl11mvpZIAJ+mwA795mw8ho4mt8ikaQsYS
         maB8yT1oKBNDHCbzEOrAou6B7DI223MC9X17Y7MqlsgYBdPEuerItKNL0DSV5jaZFS
         d537WJDVibh0a0JsKIheUWHgHDFfVO58QftMpIO3G85IP/DTddFlHci9pFHmabP4/Y
         VOFFEXCpIsFsclf2GQ0IFk0l948Bp26NWv7r69oln6zQiHB8DxZQ1FGCc6snCzLBOI
         jz3285L7f1i9DTHSLXZw0Ejf62pAnDG2Dud0GU94GIGhSte1lhifIv6c4ydZl3kUk6
         gQ/CDLD531TbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CD71E22AFA;
        Tue, 12 Sep 2023 18:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix not handling initiator properly
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169454462657.13260.14879403068503955588.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 18:50:26 +0000
References: <20230911223355.2701293-1-luiz.dentz@gmail.com>
In-Reply-To: <20230911223355.2701293-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Sep 2023 15:33:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Previously initiator would be set whenever a central key was found
> which turns out to be unreliable besides the MGMT New Connection event
> does in fact inform if the connection was initiated locally or not.
> 
> Fixes: https://github.com/bluez/bluez/issues/598
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix not handling initiator properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d2389d96702

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


