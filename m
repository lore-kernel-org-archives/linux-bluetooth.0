Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A60C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 20:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbjELUkk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbjELUkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 16:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB87270D
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6F46588B
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1469C433D2;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924022;
        bh=WcKGLhktGaqJ9Bep6iAaUra3bjGYcvJ8e8T4NKR/fAI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FCVQvMmJmeKjKfpOhyXVRGB9bZmeA/P9426tVk2hNvAJjGEYV63Q7b6I+kEiabTGl
         lohD8Fh+fbJ58DKtL9G5fZWSZ2TbC/lcr5d0dVBvUs644qiXByD4c4Dmt7BAYUgmWw
         8YroI8gNAioBGxWRAerQlpIHU1FYJBtkwYkXBr4M5xeBZeNShhTrh+4qjyZxIserQX
         H+eLvrDxj90g9RnCzbyVNLHeVqwXn4w09GwmTDCTESssE5EBMx8+MIRlC1wNM+lu5i
         oJEeqSYTsLb8TR0COi9OYUYLlylxTg0OkkfSmfRsxSRtMDU0AM91FyvdQB9MRUOVvP
         Nm0FUb/j7Soxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD2C8E450BB;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] client/player: Fix crashes accessing metadata
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168392402270.13139.8281338396110690581.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 20:40:22 +0000
References: <20230511000155.3721222-1-luiz.dentz@gmail.com>
In-Reply-To: <20230511000155.3721222-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 May 2023 17:01:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If metadata is not set the respective iovec is left NULL so it needs to
> be checked before accessing its fields.
> ---
>  client/player.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] client/player: Fix crashes accessing metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67fd8479f11c
  - [BlueZ,2/2] shared/bap: Fix not sending ASE Receiver Stop Ready
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24b4ba1a3936

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


