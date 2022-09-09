Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5BDC6FA8D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIITay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiIITa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 15:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992A97D67
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 12:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54541B8261C
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE0A6C433D6;
        Fri,  9 Sep 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662751817;
        bh=V0sG0+3Ej6SwEWZ0wmaNCkQbBqEFDeFO+HfeDNSZKbY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=d9BVJwSB/Cldo80fc4Np5v8UbIJvHHkpOStH3Y3R3TzrW2cfvq0Y5rS+eOVhq9hhF
         n70l0sw/AOMKF4bTl9JW8cIWc+GbJrS5Ycl2Q65lTJONFJqXGvOteiQpcH0M4o5Vvx
         G8Q5CdcpYhieq6CFQXS0Jgb4eTGgP24NIM2uXtQHnBGenBf+N5P/o0UdXB75XgtRjB
         vwRkTvRA+gN1F4B5jwGyAoPJDaJNLYw8N8ZDXVl77I24q5a6zxoYX+dd5SpHiictTo
         pqnrS70jdiweCpXM5Y1GD3dWHJEVu9Uj4dDooHpL2/0SRzt30jSRoyz2BaM8C1lUlF
         fVAI4IW46cNLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0B62C73FE7;
        Fri,  9 Sep 2022 19:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Mark Intel controller to support
 LE_STATES quirk
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166275181684.14413.17881202405230639284.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Sep 2022 19:30:16 +0000
References: <20220907071945.9925-1-kiran.k@intel.com>
In-Reply-To: <20220907071945.9925-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, tedd.an@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Sep 2022 12:49:45 +0530 you wrote:
> HarrrisonPeak, CyclonePeak, SnowFieldPeak and SandyPeak controllers
> are marked to support HCI_QUIRK_LE_STATES.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [v1] Bluetooth: btintel: Mark Intel controller to support LE_STATES quirk
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd0a1794f433

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


