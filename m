Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EDECDB474
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442942AbjJLVu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442911AbjJLVu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 17:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2EB7
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 14:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CCCFC433C8;
        Thu, 12 Oct 2023 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697147425;
        bh=TsJpC8Qlra1x/c1+ZBt6L85HL/4kA9rbW6P0xzjKV6E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S+LbY5xVtFs/Vrf3ukbhD6XrCNoT1YTjulx5xs2IAFUOj5U5iz+ldQrcgVPhFaR+V
         woSuXZ36Pk0iktKAr8A+4KE7dLoDG9uzdz/UDdRfGTxxH0AFCyL3Hsb5i1uo67DH8v
         vgLkHCDwB5IiGS5CxrCl3EYWMcpnUJrifYy/emZEuf0jyve7JE2+tJW9rrQ/FBA88e
         dzHtK4NXLltGbM1OfgJRPdnQWT4PYTJC6q8JXFnFF++YiE4luEWkinaSRXrU0zf9vR
         enO1OKXj7LysXFY0IWG9KMtJUL0l3QwuC24GMX+9XaQ+MzFsgeUCnhQw6s38b7EdfP
         QiGQPp6YyVANg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8528CE21EC0;
        Thu, 12 Oct 2023 21:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Update transport acquire/release flow BAP bcast source
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169714742553.28993.2457157390061512967.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 21:50:25 +0000
References: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        iulia.tanasescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 17:52:40 +0300 you wrote:
> Update transport acquire/release flow for BAP broadcast source to
> fix failure on transport release, and second acquire
> 
> Silviu Florian Barbulescu (2):
>   transport: Update transport release flow for broadcast source
>   bap:Update transport acquire/release flow for bcast source
> 
> [...]

Here is the summary with links:
  - [v3,1/2] transport: Update transport release flow for bcast src
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=052534ae07b8
  - [v3,2/2] bap:Update transport acquire/release flow for bcast src
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e347792f41a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


