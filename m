Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD865C27C7B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 21:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjITVAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjITVAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 17:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07CCC
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 14:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9928C433C8;
        Wed, 20 Sep 2023 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695243624;
        bh=z1IWI/PLJabrghThI2hKT1o2wtAHUOxpwurP0G7q5mo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T1a2yPU/QpWuFBtlusKLckyX1R7oGLJO+JgWmLGCBXhke6awQdXmNOMSkJE4emYYG
         VoeZgUbQuhSQtHXyenaqv6bTruxVO3SSFeilUD+lV7AIq0DjdL4rWDQDGqOj7QdQRd
         /PqHBII9BYHUuGnRJvM0anQmRGeAJykInNmCs/hcS7a2sVlfQvb7P9iC4ajJngSyGd
         TKhK4sES9zk3Q9sEG/72Wp5E0F3y+6VsZpyjSRAhrEhkvsH2DICQrU4chZZtfA9NSr
         N4/JDMe0nXpE1PdW7LyUc/DizZQkkuWFMoifF5luRkREBZ3d/4aQCl6+/BhJgLTkkN
         QzvdjDmJ0fwAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D49DC40C5E;
        Wed, 20 Sep 2023 21:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] media-api: Convert to ReStructuredText format
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169524362463.6493.17987809161472655076.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 21:00:24 +0000
References: <20230920001004.355664-1-luiz.dentz@gmail.com>
In-Reply-To: <20230920001004.355664-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Sep 2023 17:10:04 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This converts media-api.txt to media-api.rst.
> ---
>  Makefile.am         |    2 +-
>  doc/media-api.rst   | 1047 +++++++++++++++++++++++++++++++++++++++++++
>  doc/media-api.txt   |  889 ------------------------------------
>  test/example-player |    2 +-
>  test/simple-player  |    2 +-
>  5 files changed, 1050 insertions(+), 892 deletions(-)
>  create mode 100644 doc/media-api.rst
>  delete mode 100644 doc/media-api.txt

Here is the summary with links:
  - [v2] media-api: Convert to ReStructuredText format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f479c2404ecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


