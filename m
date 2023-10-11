Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B8CDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJKVU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJKVU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765CCA
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5EF0C433CD;
        Wed, 11 Oct 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697059224;
        bh=eORQdaTeqnjmTHxTyAfs7g3w9gSl6+eIQnGLd6hZMts=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fKRrxaVjG5BtBrXSlktAYSnWaFF+Ep7viyu7vUeAfxBS5oXnPyrGo2uebBb2Z8vVd
         S0tNUu/DyA8uf+x0vzKF3BE46Pj2lnYcBUSH651vixWOkyHZNyUMPBX2R5akLbRgcs
         /2vCOLAGLxH/oMLArpKuqPORzc4NY9F2rI0mwF4Tw1X/D16/O5l/fNpENiA9vWamEi
         +LrGboYduDrCa9GQVow/gZMR2GUADwE+T7fyfVwJ0q+mdOzeae3LPnUTzySwFsbJUu
         BXQ92zIlzy/gdrVgT0RBPPkQo/xoP+SnGzCkZEZdE8QTcOgUcnHy0Pz0u9bp3fr00M
         TasORabPAUIGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABE5FE21ED9;
        Wed, 11 Oct 2023 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] input: Fix smatch warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169705922469.14030.6153557602325320356.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 21:20:24 +0000
References: <20231010215853.629963-1-luiz.dentz@gmail.com>
In-Reply-To: <20231010215853.629963-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 14:58:52 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning:
> 
> profiles/input/device.c:165:26: warning: Variable length array is used.
> ---
>  profiles/input/device.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ] input: Fix smatch warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=afb47b13c600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


