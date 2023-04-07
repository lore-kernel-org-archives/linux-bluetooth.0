Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B541C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 19:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDGTlr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDGTlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 15:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1135FE6;
        Fri,  7 Apr 2023 12:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A115651D2;
        Fri,  7 Apr 2023 19:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC12CC433D2;
        Fri,  7 Apr 2023 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680896503;
        bh=LTwM6B9bXlrZlNBiKgr8YuQPNzMio2yhGAeYlYznra8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kD5b4x7ma0Lo4HB6eU8DsJcafy2JJf7wHvcHmgu+GzU8ua+e1KNFTXG8F1cq1VyH1
         OGcVqwYqVpNTvhNEFlHRGlMfEjD51wM8nniQIMmvmlmeMFBzIBClgGhI1DsQU6PeQK
         wp+uGXfEEHcvk7XJ7WyVR7mH3ankbHkOaPFry4qEAbDOaaL9kJ1t+P40it54BGpNVN
         piNaSP6xZ1F3EaaPJlMlF3dbCedZM84D0Ezbf72ALeLGY3yWxMGmCrjYvGNEU21UVv
         j0/uzEZzjB8sl9+F7KBfotTFsQghsrApdWQf1xJ1XZllSVAgRhRTR2u/XP45Zu/ay8
         D46PODGMlCeew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 968ABE4D029;
        Fri,  7 Apr 2023 19:41:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-03-23
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168089650361.19462.15346565048908939729.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 19:41:43 +0000
References: <20230323202335.3380841-1-luiz.dentz@gmail.com>
In-Reply-To: <20230323202335.3380841-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Mar 2023 13:23:35 -0700 you wrote:
> The following changes since commit bb765a743377d46d8da8e7f7e5128022504741b9:
> 
>   mlxsw: spectrum_fid: Fix incorrect local port type (2023-03-22 15:50:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-03-23
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-03-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e63a2dfe73f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


