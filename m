Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJGPKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJGPKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 11:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81860482
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A415CB8238F
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 15:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AADCC433B5;
        Fri,  7 Oct 2022 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665155415;
        bh=xtTl/VKt60kXXdjjoInktjJNQVdRFP8ByeFONEwHJtI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hnvjhXuPpxsaY4oKk3JqVzQrX313XTnsE9lQmWqLqymJNzQ9PLl1sRhjV+ZjWNMqk
         0LtgtBiKEkKZJ358tp0xExvUDyrMUCcKNnU1UpKGGgB4r3azfFYSPlFmSkcVlV5YLF
         JS0KQUCJhC/qXIBxxVuKOZ2oTj7PvUktBxZPEwbqmpt3iCT0JuBJsXIlcKAUtMV4Jk
         8rpKsUCys/VXriJIgtzmZuwek+msbBy5NiHUH3qqV28Lp4vAOZ3lKGBbRVVN5bKpyd
         qBH+WTFYT9GNl6ksWAGRw9TRbJqX+IcDP46jCvZskwBI+FQ2+IW3MKbSLibimNz1Ke
         oDMjTjyoUAQOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50532E21ED6;
        Fri,  7 Oct 2022 15:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools: mgmt-tester - Test for HCI cmd after static addr
 set
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166515541532.23839.8956223510106185835.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Oct 2022 15:10:15 +0000
References: <20221006225326.641765-1-brian.gix@intel.com>
In-Reply-To: <20221006225326.641765-1-brian.gix@intel.com>
To:     Gix@ci.codeaurora.org, Brian <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        tedd.an@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Thu,  6 Oct 2022 15:53:26 -0700 you wrote:
> This change checks for the expected HCI command after Static Address
> change requested.
> ---
>  tools/mgmt-tester.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ] tools: mgmt-tester - Test for HCI cmd after static addr set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc598fa12c08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


