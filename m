Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB46C83F12
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 01:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjHZBlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 21:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjHZBkl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 21:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930C1FC3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 18:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 214A762846
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 01:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7359DC433C9;
        Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693014038;
        bh=Sez514pbqH4JCvlYGl9HNEjRlU9PhsBMe/tHD1ADyJQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BnTTre7x5uFa3S9Z1zRY5QyAzrkKv9jlL0ZJL3TnhuE5wprTxZoQjhhOEyCwBHAuw
         9h64jJn53h1eGfHblQx3KKiYyBnkvarOOpfg1E4azrq83CeLpfJoR3xUJFTG3vEIXv
         kTnUf6j+IyM52pK+XDG7RAN9suL4Cq/ObwDw20vz6keEJhsTzRoojP2/AsUxSJ9OEW
         GMh1MrEuhI0/MYo2nPbVyVxmQJDPzyPub/MP8fUW3hC9I1F6zuRjzi13B0mXtoLVOB
         WBvPaed6XBKko8sH1EOWUI60Fg9OOYEUiwvUUMRbxBHKV+S6xQoPg74IsvCaVbcadD
         cuiOLI39wtlzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B20AE33083;
        Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2023-08-24
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169301403836.445.16197016876453596509.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Aug 2023 01:40:38 +0000
References: <20230824201458.2577-1-luiz.dentz@gmail.com>
In-Reply-To: <20230824201458.2577-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 13:14:58 -0700 you wrote:
> The following changes since commit 59da9885767a75df697c84c06aaf2296e10d85a4:
> 
>   net: dsa: use capital "OR" for multiple licenses in SPDX (2023-08-24 12:02:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-08-24
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2023-08-24
    https://git.kernel.org/netdev/net-next/c/3db347476311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


