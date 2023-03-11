Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C1EC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCKAlY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCKAkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40913844D
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41603B82471
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB04C433A4;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495220;
        bh=xRHjrmeN800JbqAFEbbWIDg3AVCGDj/vJsHNJE1Yf2A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lYQEV9QOImiQ113zoyFNcM3YkhUAcM3zl2FRfV0kqo63Qq3svjHKzv20pzRmw8Hu7
         T8Zhmi0PkaeZ7RZUGf19msGUe2Mx6gzrjrQ6Ihws74x9aKhbXLNcgHTXGF4wky3G3l
         IXijcSyzVxXd968TXGGKd/MlhiqI5LoDiIgZgMBBXUpSUGrXC25l1cyYlWfwySJrj7
         V+IRh+eqhnV+nhut5t1SO/rWfrxfDJ1JfRd3QgtirmeyHuASP9XurtnjIFqMfQ/QE1
         R45Ga5lfrzTfCKq7w+7BmxQ86AfJEkQJgAiFILai+GNl864VfcXT/ngZnkMGLE2SdL
         n1jBazx9WZz7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCF4DE21EEB;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/att: Always queue BT_ATT_OP_MTU_REQ on the fixed
 channel
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167849522077.21816.1436185214763912331.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:40:20 +0000
References: <20230307211756.2581274-1-luiz.dentz@gmail.com>
In-Reply-To: <20230307211756.2581274-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Mar 2023 13:17:56 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_ATT_OP_MTU_REQ shall only be sent on the so called fixed channel
> since EATT channels shall use L2CAP procedure to update its MTU.
> ---
>  src/shared/att.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Here is the summary with links:
  - [BlueZ] shared/att: Always queue BT_ATT_OP_MTU_REQ on the fixed channel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=96ab7296cb92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


