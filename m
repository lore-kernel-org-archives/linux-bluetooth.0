Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACCEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUUXL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGUUWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 16:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8732358C
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 13:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2341761DA1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 20:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82CF5C433C8;
        Fri, 21 Jul 2023 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689970824;
        bh=p7/nrQqqbsfVs7HZzKwh2zIRg6xa+p5HBNSXnBkzfiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r05Tiu1UnQMiF6/8mdunMdtTZyUlsXI70foNMeS1WOSmtBVImAjRu+7d6p6BoOSDQ
         ye530yVjXukfkUumHq7WAcDvavZ3sV7EfLy7kPmYFiZMPj7O+Ag3v+RyEltWVqb0ud
         hwG36mdgZpC5MHrXwrvyrenb7S0EQKxnQYlcA7aCvcwP/xg1c1Qa9yH76g6M3yhWIw
         3JzcpIKE7PM7MtvKZ7BmMxoB6S5qSGt9VPXw5lhyZn8KuZyZieNS9KLiucZ4NNbye8
         js5il0D60yfneXs0xVmq42NA2Ix2AkRU92eTgI+Oo3TMAkbmjwKjiK1jzLOj5tcz6s
         igul3Onx7ZPWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 625B3C595CB;
        Fri, 21 Jul 2023 20:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Minor monitor changes around Broadcast
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168997082439.4572.16183134229145105760.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Jul 2023 20:20:24 +0000
References: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?q?=C5=81ukasz_Rymanowski_=3Clukasz=2Erymanowski=40codecoup=2Epl=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Jul 2023 14:03:16 +0200 you wrote:
> Grzegorz Kolodziejczyk (1):
>   monitor: Fix invalid Create BIG Test command
> 
> Jakub Tyszkowski (1):
>   monitor: Fix adv_handle size in the set info transfer packet
> 
> Łukasz Rymanowski (2):
>   btmon: Fix obvious typo
>   btmon: Make BIG identifier consistent
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] monitor: Fix adv_handle size in the set info transfer packet
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4337eb25b04c
  - [BlueZ,2/4] monitor: Fix invalid Create BIG Test command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc9f3a8e510a
  - [BlueZ,3/4] btmon: Fix obvious typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aee361c8eb0f
  - [BlueZ,4/4] btmon: Make BIG identifier consistent
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d8ca06631b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


