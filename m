Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B34EC77B6F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbjDFVAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDFVAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57257695
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6318E64CA9
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C91E8C433A1;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=+jwGM4DKGW9rM/d2CG3JX9vju1BH+IPCgrmoDr6jHZs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SUov4R6Ufq0uNX52nH3hDd6G2nbXLYeVFzCi47ogtIiqqOXTFoTP1tLUz9un1zkDv
         t8/blmPvuRB8f7Q78dqCWGAWaYf8iFC1la+sgNchM4Qx5dXrk9G+DE+XLakO3ixEFg
         jPx+wSvbknb7xbOe66wWfxQYA+F74DKYTVwBeBqVlPM/71Gk+LeAVu2l6ZGXCNi5nQ
         Fnex8LBND2Dkzbt14PSMLeh4U6qEtZoj3gUny/s5SLYhK4ZeaL0T/Oejnt7dfVqVky
         npryfry1mhecBv15ZH9BOrQPyUP8ciEbc/s3meaNpTgBsRywXAlaDPOxsx5lu9roLZ
         drM4yf7NKhc/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3084E4F158;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Set ISO Data Path on broadcast sink
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482072.2619.17846943875971851872.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230405111918.4885-1-claudia.rosu@nxp.com>
In-Reply-To: <20230405111918.4885-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Apr 2023 14:19:17 +0300 you wrote:
> This patch enables ISO data rx on broadcast sink.
> Claudia Draghicescu (1):
>   Set ISO Data Path on broadcast sink
> 
>  net/bluetooth/hci_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2,1/1] Bluetooth: Set ISO Data Path on broadcast sink
    https://git.kernel.org/bluetooth/bluetooth-next/c/32947ea30644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


