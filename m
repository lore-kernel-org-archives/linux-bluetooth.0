Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC506C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjESUUX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjESUUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 16:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A2101;
        Fri, 19 May 2023 13:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C0DF658C6;
        Fri, 19 May 2023 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB3BEC4339B;
        Fri, 19 May 2023 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684527620;
        bh=W+1y5pThaFFE3SpILZFKpyqE2TZwN+fc8Bqgv3UwvCI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qTn+7cT42uUN4tIaRMsQ1HvwgaQ2Ipf553F8fAhTB4aEvx9P6CVZMtiNHAKrm0EPA
         BV25m+/XYSKzep9JIsTQS9n1o+GZVMK233sNUNwWbcEzcQlX0tF3hqtDXYGirVxGEn
         uN4tWcRhNFtOZ3DkEfwm46L3qAqJM0H8sisZ3Uw4jmrpSoHdcJdAgMl0GNyjZFpGjP
         CE2bO3rFRg4sTKkL8EZDATLUoQFIBOjyufckh2YImUgFc0y7yy81HS8t1pe1H2bhwP
         RQ/b3h7PYDYIfIDbkdprUDrfM2im8c8eO71o53SByKAHCLhJ+5Y/E791O1Y365pr5n
         Awze//Wo3wkXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F65FE21EFA;
        Fri, 19 May 2023 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btqca: use le32_to_cpu for ver.soc_id
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168452762057.10748.3201481225692918444.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 20:20:20 +0000
References: <20230519104324.4623-1-minhuadotchen@gmail.com>
In-Reply-To: <20230519104324.4623-1-minhuadotchen@gmail.com>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 May 2023 18:43:23 +0800 you wrote:
> Use le32_to_cpu for ver.soc_id to fix the following
> sparse warning.
> 
> drivers/bluetooth/btqca.c:640:24: sparse: warning: restricted
> __le32 degrades to integer
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btqca: use le32_to_cpu for ver.soc_id
    https://git.kernel.org/bluetooth/bluetooth-next/c/0f1e103dc579

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


