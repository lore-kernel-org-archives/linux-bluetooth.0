Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AAEC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjFGTuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFGTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225151BEF
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ABBA63B4A
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C91C433EF;
        Wed,  7 Jun 2023 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686167422;
        bh=1nPmJHPCPTl8Y/hBLsoQCUfk3rsF/rAqjHBX4JBkJRY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hdOqsJ9MFyJYAUWknuAl7+S8tCIv3r7pV9jQRWT+96V2gZD9V0u5iZruVRKsFuEF8
         vrAiVb7NceNO6116lEFiKb8e8F0EryfMa4dNup3L1+s/TZNQRC3sayD+E/yX08q4RR
         v0UnIDlLdaxIF/unks/Jp8GBil8hPdLK5DtuJYZYX5LPAKcfhArgI1V1zvrC7KTAOL
         ijUszZdaFdlUQNhWBUrEGbsrj2dkbPZlGhsfF5onIQwF03DxMaEJI9Lx5qbUgyiBno
         8KMJh839ZYIy8rfSuV6qL/FszSwatSlNmjKAQAUR4Kq7OD8cRW+3t6zoaIczUyoOMv
         IYwoMT3pQdo/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4C9CE29F39;
        Wed,  7 Jun 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media: Register app objects in proxy_added_cb()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168616742185.16860.6931728637611457817.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 19:50:21 +0000
References: <20230527231458.673167-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20230527231458.673167-1-arkadiusz.bokowy@gmail.com>
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 May 2023 01:14:58 +0200 you wrote:
> The proxy_added_cb() function is called every time a new client is added
> to the application object manager. Registering media endpoint and player
> in that proxy_added_cb() callback function will allow to register new
> endpoints and players not only during the initial RegisterApplication
> call, but also during the application lifetime. For instance, this might
> allow to dynamically enable/disable support for additional codecs.
> 
> [...]

Here is the summary with links:
  - [BlueZ] media: Register app objects in proxy_added_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=08d62744ce17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


