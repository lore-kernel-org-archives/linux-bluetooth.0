Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A84ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiH3Va1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiH3VaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D12D1DB
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70F1B81E28
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39278C43470;
        Tue, 30 Aug 2022 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661895019;
        bh=UNX7IsT531aGrlSosmQhYCEe4o6pTEeiEuAI8YWzHxA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MLQpFGErr9De3KQ3ov6Fgi4TrGATg3FALCEJTcGOcV5stBmx+R1zwcETehdML9r2t
         lp/nOKzYS6kU8lUUp+SEx0AH7Snjez9tFUZEVeJZqvHKaaoaQF2IVNF1eiFuppvLzR
         GEa25KnEfiOaqFc7B/w9eP86PglqcTPeyQxURrIzsNLHvC4TyB3qHrF65tzFKop1X3
         O6gfFAWP08lWlvDRu1DOjMuNqESnmKpny2Hw+UIw3S+MrHDr3MtA4y46GQQPaY0rrI
         sWCjDFucO8xPtszGyAzc4Xq+z/G1vLFXsyRsna3vBvWMyYVR1lbE8fc3C+9TsnpFz5
         yr2QwpHEJmRKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18E99E924DA;
        Tue, 30 Aug 2022 21:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] profiles: Add remote endpoint path to
 SelectProperties
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166189501909.8541.2876604320701887935.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Aug 2022 21:30:19 +0000
References: <20220830144734.55263-1-frederic.danis@collabora.com>
In-Reply-To: <20220830144734.55263-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Aug 2022 16:47:31 +0200 you wrote:
> The SelectProperties method is only called on the central (initiator)
> device. But there's no information related to the remote device for which
> is call is done.
> These commits allow the audio server to link this call method to the
> appropriate remote endpoint.
> 
> Changes in V2:
> - Set endpoint part of the dictionary properties
> - Pass rpac to select function instead of DBus specific path
> - Add a new commit to keep consistency after fixing previous
>   patch for a checkpatch warning
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] profiles: Add remote endpoint path to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb62d17e26f6
  - [BlueZ,v2,2/3] doc: Add remote endpoint path to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdff0e3ce300
  - [BlueZ,v2,3/3] profiles: Fix function definition style
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d04b64003d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


