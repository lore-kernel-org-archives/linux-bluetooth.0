Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJRUam (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJRUac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 16:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC96293C
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 13:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 213A2B82108
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 20:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB3EEC4314F;
        Tue, 18 Oct 2022 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666125016;
        bh=FyrXeOtFSgZX4R9GkYdpH3kSyveVY2aunkj5h19B1yI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FQni/Lgaw5IZYOPgekMY3kZDtZ9ST+hqJOC+60x9+II1FgWLTwYHeO7kqzmsb7347
         kRUb4m6pxXKN1O8Z7j6EPwQgwy++iRmuvZasnL+Xtn2O2HAH2CrGZ9T4yjqAAdE/6V
         xTrcF5Eo4a0Lr0u8d5r6GYagA1BBxNunpwHg2H+gYmSunPlgVoL2VDv8jsg4BXk8x4
         bxlzdxGA3Q6lz7q6En3PCB5+o0T57AC8NZVDzxZaGc7X1w13HFfFqemqpivRXfNLVe
         Qmd70OntvTziQlGabqdTDCD1lXsaXd88DTpjQOqnk3wnziU1fm4+vO3jkZkOo0my3T
         /3FFUQb9F9lbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76369E29F37;
        Tue, 18 Oct 2022 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/4] Media Control Profile Client
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166612501647.17712.7174869691777891549.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Oct 2022 20:30:16 +0000
References: <20221018043831.342821-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221018043831.342821-1-abhay.maheshbhai.maheta@intel.com>
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Oct 2022 10:08:27 +0530 you wrote:
> This series of patches adds support for Media Control Profile for LE Audio.
> These patches primarily focuses on Media Control Client Role.
> 
> Abhay Maheta (4):
>   lib/uuid: Add GMCS UUIDs
>   shared/mcp: Add initial code for handling MCP
>   profiles: Add initial code for mcp plugin
>   monitor/att: Add decoding support for GMCS
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] lib/uuid: Add GMCS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3a204b8a2c0
  - [BlueZ,v3,2/4] shared/mcp: Add initial code for handling MCP
    (no matching commit)
  - [BlueZ,v3,3/4] profiles: Add initial code for mcp plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=123e1ee1ce06
  - [BlueZ,v3,4/4] monitor/att: Add decoding support for GMCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07fd4b948251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


