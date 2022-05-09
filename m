Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbiEIUEL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiEIUEI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 16:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C081ACF90
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 13:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCDE3616CB
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 20:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32080C385BA;
        Mon,  9 May 2022 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652126413;
        bh=+ElJa29Du6vFrxR7Ha6LtQLp12SUDihT+OcwMHJHz1A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d2aRTaBuVcmdasuFvxHv5lWYFsvdznaIjOkYku8XRflrRKNO9YP5VTeuwfb6FR3wr
         YFtlE3YRbvktM0eiDrJWWDMOkwfmAppqqPwrvBDZ8X/rZK5/M5N+XchASUaYqPu+5W
         OUUErx6rhYqYHv8jzk1qw6/R6jzI8xB9Z51TrNh38L8lwSi9kVTR0Tu8F7DyHtVqic
         72mc/q54soZQzYjNCpJduUAZC/SJdE4mtGue1YSw2ECYNv/QV8f5SSRHkuoDB2nPqn
         J1vIMc0F0i4mvJShlWTQnp66hSZLrBQZo0vmVgWJwBrp0EceTI1Srp0okBR2KssF29
         /gGO3QTiTxyjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16617F03928;
        Mon,  9 May 2022 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] advertising: Treat empty LocalName the same as omitting
 it
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165212641307.14471.6216928612174766443.git-patchwork-notify@kernel.org>
Date:   Mon, 09 May 2022 20:00:13 +0000
References: <20220506230819.3954905-1-luiz.dentz@gmail.com>
In-Reply-To: <20220506230819.3954905-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 May 2022 16:08:19 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This treats empty LocalName ("") the same as omitting it so not name is
> set in the advertising data since some D-Bus binding seems to have
> problems to omit properties at runtime.
> 
> Fixes: https://github.com/bluez/bluez/issues/337
> 
> [...]

Here is the summary with links:
  - [BlueZ] advertising: Treat empty LocalName the same as omitting it
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0106d92a1e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


