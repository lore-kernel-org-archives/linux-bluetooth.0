Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46DCC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiFQVKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiFQVKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 17:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C6C6B
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F199620AF
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 21:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80488C341C6;
        Fri, 17 Jun 2022 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655500213;
        bh=dPF7VKjGdtlNvZXA7nC5d5t6viNcu6EVCIhNGMWY1oI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u0majFbJK2rS49PYqPMUxYMUGcRzHiy++3DWcLOqzAhRk/wU43DnfBjGx4uQQjpP7
         wnJEKjB7zXMsS5Z3mKK/tTLcW2SI6JNZFWowTcbMa/tz0jyp8cjJjxHXszswWKa9Cz
         oW1LE3w05S5toIIQKJ5c+err+iWhlNOg2j8WQuWO5Mj/vYCJI8CVIfgSsNLVVaaGtM
         8nVzbiDvi7ANue1x1/0RBSgpOD5tUPTvaRiqsbtQ0havkZP/E9FZ4xNNLB8Mt3m13K
         kjBVgwHbeKW22Nkuveo/TPyll+FWTutVitfx8AR2W4SjvvOJtIaozvfuW/qZc8a44P
         zLHzsZbmDoGJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68EA8FD99FF;
        Fri, 17 Jun 2022 21:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH 1/3] doc/mgmt-api: Update for Add Extended Advertisement
 Command
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165550021342.3032.8156104576248865760.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 21:10:13 +0000
References: <20220616195803.99346-1-hj.tedd.an@gmail.com>
In-Reply-To: <20220616195803.99346-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jun 2022 12:58:01 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch aligns the input parameter for Add Extended Advertisement
> command with actual data struct and add missing flag descriptions.
> ---
>  doc/mgmt-api.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/3] doc/mgmt-api: Update for Add Extended Advertisement Command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7378408ed4da
  - [BlueZ,2/3] monitor: Update flag information for Extended Advertismement
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2479a013a202
  - [BlueZ,3/3] tools/btmgmt: Add support Add Ext Adv command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3075ff8fffec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


