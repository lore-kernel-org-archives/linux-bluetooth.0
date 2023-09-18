Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA513CD37B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjIRSka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRSka (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 14:40:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB9DFC
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 11:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2737FC433CB;
        Mon, 18 Sep 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695062424;
        bh=i/TvcXvN6MQLL9SYs9cdpLStLYbh/XomliG1sLLfuNA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qI77tnNutt7Dm8AwiFiqiS/JKCzaY8klBdKr1Pu5tD7BJUzvd3BFKlIg1s9sPwJKD
         RIXcedPsjawfysaNGZYtLCXK4I8n+pYrFYVDBJBLca5CO50fwPOGLqNiWJMSrTjjWN
         5/76Id5bjzGUK0Dx1Lc1PCefug5McNCCNjqRHBIAb/EO77dViDyOxdJa4oeiztnkXW
         Iazx6NlUPvP7e3lmiH0LL47tValxTKXYjJsimSxE/Ix53JGcS0XYsmvRJe7/y8Lj+W
         IYqisxpSSO6lmqN+XmAfGJkBcNIdcFuB0tkUWuNUK+WsjlV2g75EBobsBd4xVHfNlg
         xTWsG8H63mz8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ECB3E11F40;
        Mon, 18 Sep 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [BlueZ V2] configure.ac: Add enable_btpclient and enable_mesh
 for internal ELL
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169506242405.18411.2293762261732422715.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 18:40:24 +0000
References: <20230917172520.46145-1-koba.ko@canonical.com>
In-Reply-To: <20230917172520.46145-1-koba.ko@canonical.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Sep 2023 01:25:20 +0800 you wrote:
> when checking enable_external_ell != 'yes',
> even enable_btpclient and enable_mesh are not enabled.
> configure still prompt the error.
> Then ELL must be installed to pass the configure.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ~~~
> V2:
> * correct the wrong-spelling
> * add BlueZ tag
> * rephrase the commit description
> * change the '&&' to '||' condition.
> 
> [...]

Here is the summary with links:
  - [BlueZ,V2] configure.ac: Add enable_btpclient and enable_mesh for internal ELL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04e18c0dcbc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


