Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA0C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Mar 2023 00:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCYAAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 20:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYAAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 20:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051561BA
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 17:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9467762D07
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Mar 2023 00:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011E8C433EF;
        Sat, 25 Mar 2023 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679702419;
        bh=9Ww7q7ytPilUdK9Q7xR2+56R1bqzlfibEopiula6n1g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fTTagVPuY4BIS5G8KG1dxq+9EXKRu6kCVkE/Uc1idnpRO5ZjXuSLTk04hlUMnmyf0
         EY3Uhd7gLI5nfBvPz/c1C9PVgbWrec4qP+N8nn4diCQoWdnl8TACC/qilv9DiQIixh
         POZJp+JSiJOs1icYv/t/Q+7M78fLk3133ZwxnFel5U4Y+rGGuu6xwLbQJoEwDnktID
         8VMbix31HK6214E4zFPYvODcayaSHaPvPGScOe3o2JW1HL+eSRK6M2QhDWPBeCq4GU
         ywb9C0U7Ytt8IiZUaCAPZDL3700cXqF9fs6PrGqhIn4ggH1OERKZekDlMQwPJorq5s
         IsBBcIBErZB1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7050E52505;
        Sat, 25 Mar 2023 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] shared/shell: Add support for -i/--init-script
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167970241887.30520.96957124269960060.git-patchwork-notify@kernel.org>
Date:   Sat, 25 Mar 2023 00:00:18 +0000
References: <20230322011349.2763404-1-luiz.dentz@gmail.com>
In-Reply-To: <20230322011349.2763404-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Mar 2023 18:13:48 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for -i/--init-script which can be used to provide a
> file with commands to be initialized, the commands are then run in
> sequence after completing:
> 
> client/bluetoothctl -i client/power-on-off.bt
> Agent registered
> Changing power on succeeded
> [CHG] Controller A8:7E:EA:56:87:D5 Pairable: yes
> [CHG] Controller 98:8D:46:EE:6D:16 Pairable: yes
> [CHG] Controller 98:8D:46:EE:6D:16 PowerState: on-disabling
> AdvertisementMonitor path registered
> 
> [...]

Here is the summary with links:
  - [v2,1/2] shared/shell: Add support for -i/--init-script
    (no matching commit)
  - [v2,2/2] client: Add samples init scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb1c694100b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


