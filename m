Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62264C636D6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBOXuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 18:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3992ED45
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 15:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5318361E00
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 23:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6EB6C433AC;
        Wed, 15 Feb 2023 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676505018;
        bh=tYlLNiq3DkNVCUajoLQtyKsMYoL22COtEJOUWLcTaj0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EATG8BtbFuQJu+3MdgXQBvfk4XKXRGMtSSdfWYIwqoHU0FVsw6Bbyi/JxEvo+HOaK
         aSN2zRsmI6Vkbo+SVyGAdMzym6UHZhXpit4WEkfUQk8GBvQfjqP8+nSQPU1TVfGvt3
         rLA5a0ft/P+ue+DV51ASvgpdLA5/VUvi+Yw8/EO2Y13O/lCHEhJu2duh19mmkpa1pN
         OsBph4BUoGizncb8i9VC1sRwmhD2e5v4khhjNa3Sehf+wvVJjbLicrQa6IsKQaw2I/
         IyaXF3ywOoj7kBIgRqf5I9PQUfuexVE5Oxk0gTmn37+AGJOO/Y5ejvwfWfZDsqDqji
         8T5Q/H2h8R2OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A154EC41676;
        Wed, 15 Feb 2023 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor/att: Fix ASE frequency values
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167650501865.26864.3762769850143596859.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Feb 2023 23:50:18 +0000
References: <20230215005629.990585-1-luiz.dentz@gmail.com>
In-Reply-To: <20230215005629.990585-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Feb 2023 16:56:29 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the printed hex value of some of the frequencies.
> ---
>  monitor/att.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [BlueZ] monitor/att: Fix ASE frequency values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa50506c9f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


