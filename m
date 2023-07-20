Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D788EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTVaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjGTVaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 17:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849602111
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 14:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154E161BEF
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 21:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74394C433C8;
        Thu, 20 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888622;
        bh=hB76O8L/3kyOw/Rf+8lcGMxl2BmfTcui2YywHih5QYE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fT8tuv7DcMYFu2UWShtummXrf/5erzFuHfHFukcGtuQygDK3JhjZU/gpmf9PcNuCB
         4HszRs9LuE6lvhieAAJoTpIIgRUdyeP5UYN5DCScH8PatDlEUWNjijlsAscydNQchT
         wRf1+Z/ONxtIpZroqDRkeembdCALhZ5TMeOoeESCuMzuSIspZaif4DVBNPJaU0JpkS
         XR1hzQq1UTNR+Fw2AHlBYJQuETT4/W/2Pq/mhvaARkeBvK1WMxtl3DEDlwODkzbMS+
         MYIH/zZu1DY4wpFjWLLm/J7S+maD+vz4y3m2/U/qi7DUGWVRmS3Cy4m3LdFyQTAvF3
         ZE2E7VW3RSkbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50D53E21EF5;
        Thu, 20 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-07-20
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168988862232.31694.16200084762361612051.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 21:30:22 +0000
References: <20230720190201.446469-1-luiz.dentz@gmail.com>
In-Reply-To: <20230720190201.446469-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 12:02:00 -0700 you wrote:
> The following changes since commit ac528649f7c63bc233cc0d33cff11f767cc666e3:
> 
>   Merge branch 'net-support-stp-on-bridge-in-non-root-netns' (2023-07-20 10:46:33 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-07-20
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-07-20
    https://git.kernel.org/netdev/net/c/75d42b351f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


