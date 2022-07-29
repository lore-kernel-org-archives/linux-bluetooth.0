Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15319C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiG2AKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiG2AKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDBB86D;
        Thu, 28 Jul 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6060561D09;
        Fri, 29 Jul 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB6C3C433D7;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659053414;
        bh=VQFeoKnk/a/g5X0qE7WXqg4KJHj+79PlNWob3t5Lres=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l6GOagcPyKqjRIJXeHkvM6JXC794dTubGe1ch10CaYRePkVHwxbtuiHXk5s+tifdO
         8nwJue9oXTD/4pz+c3eHGq43dUSa73O4wAXLfIGwTMCnLGeNfhWU4Mi8haW5PZxn7r
         tiG3zGLwkoL/JVCdg3QT6ZHh7XZHErTT78gfl6hYCYXiaQA/8ksljtm+HbKVx7LJqq
         80FpyD/U/VsfTct/Y6+tDOBvz0NQW9yAyNvWm64Rr27N4b6H66T883Bl6VOxTQJudf
         1QXX5VnJCOlZDFoXdESoP4PgDrRXcBRY4r8J8PUTKY+/wnjdlcEFEdTbFajIGoIR2z
         XbrLqRjI2Czvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3736C43142;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165905341466.26440.11072022692863950015.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 00:10:14 +0000
References: <20220720011002.5221-1-faenkhauser@gmail.com>
In-Reply-To: <20220720011002.5221-1-faenkhauser@gmail.com>
To:     Fae <faenkhauser@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Jul 2022 20:10:02 -0500 you wrote:
> Fixes bluetooth on HP Envy ey0xxx
> 
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a50481b4de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


