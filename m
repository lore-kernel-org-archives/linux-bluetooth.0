Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A78C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 23:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiHPXUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiHPXUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 19:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4CA74BB4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 16:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75749612DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 23:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D94A2C433D7;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660692015;
        bh=MvZdYaiGoYLImnlVJU8d8g/6MVoPcxUAUC0Qt/IXzPk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cqK+AWBwIo7Gt3K/No4HgZVknmKkE1kL12RwrsoX7xZep+t4nrJADDAWeB2WOfv5L
         RFUdDlGDjn66/HDuwsmewpF8jk3BYgntvE42XxmCLKTiw3TYwFogHQ5z7n2XfeL5JE
         ZpZVy72AmVmPM5vwBgyI0Vjg1Oz/3lgxQscKi4zDzhWBx1YZvktRl8x0fVEwuSxSe9
         t0wg1x9usCSBiUI/rk7iyzdVJaISJE8ri1qelUxdPuvVzmkuPzNCCzV7NAHRgNlNU0
         hd36BGqE2j+vYZNir5CawwHHmGSfZmadqgxP63FDdXdIOwQLC7i+gBg8KBxqeWqHoO
         XYoUjL/Dm7hZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8A7DE2A051;
        Tue, 16 Aug 2022 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: Introduce tests for Disconnect/Reconnect
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166069201575.20856.17985708882157909983.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Aug 2022 23:20:15 +0000
References: <20220815190401.1176081-1-luiz.dentz@gmail.com>
In-Reply-To: <20220815190401.1176081-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Aug 2022 12:04:01 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces a test that do use shutdown to disconnect an ISO socket
> and then another one that attempts to reconnect it again to emulate
> upper profile transitions.
> ---
>  tools/iso-tester.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

Here is the summary with links:
  - [BlueZ] iso-tester: Introduce tests for Disconnect/Reconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c3f35d6fd12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


