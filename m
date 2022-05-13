Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C58EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 22:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384802AbiEMWAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383472AbiEMWAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 18:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4754BED
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 15:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8065B831EC
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 22:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 928E3C34114;
        Fri, 13 May 2022 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652479219;
        bh=M3OfJ8v0d/JG/2y5L19H8DY3lJbzO2hQwRyB4bxulC0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S0PagdpgN/S6m9yavMohzPYjOVowvlCFaS5ScGFY3d0KENHev/9fvol61WEd3r4RF
         UXcAckddc/sM3K5xopwNJ8XaSCpKt2M4UWzCS4JZ8FVP1kNbVd4+1WYUFkt7exvBFg
         0Sp8yvegFewuWKBiLI0oUpuJ7IMGBt0oSY2loVCAS8Td2wVPDmKt8aBIZzPeLv19sn
         Ir5StQUnKl2M+SCP5xtezhKYSoE8Oc+cOWEmSIVD/vESCLpS3jd6+qYNx2EY7i6nHi
         K1SHlmwXtxo8YAawVt66mfi/25KpINyHfmY+UG+6bibbG542tfDxY+hcImxZFj3Jv7
         KOL8ZbyA0BojA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 724F1F03934;
        Fri, 13 May 2022 22:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] hog-lib: Fix not able to read report_map of instances
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165247921946.21318.2166375099859690207.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 22:00:19 +0000
References: <20220513010359.1061926-1-luiz.dentz@gmail.com>
In-Reply-To: <20220513010359.1061926-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 May 2022 18:03:59 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If there is multiple instances the gatt_db of the instances was not
> initialized causing the report_map_attr to be NULL.
> 
> Fixes: https://github.com/bluez/bluez/issues/298
> 
> [...]

Here is the summary with links:
  - [BlueZ] hog-lib: Fix not able to read report_map of instances
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7955b2099dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


