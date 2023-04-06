Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A461C7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 21:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjDFVAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbjDFVAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E17ED4;
        Thu,  6 Apr 2023 14:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEAB164CAF;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBE84C433A4;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=5GOYcpjCXrTJTg4gv8OrwqfP2Uo8jGUVfVGHDrjSYUw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oQ/jCLtVZSy3w+nB4xPK8VbNRgeq3CUz2oscZfDqMccf24yCRyELlWWMBF4yJsYWq
         MO6/1Q4/dWxa3xt/hZBYltNKexoAOTm1IS6GrjofVDfw0QR9XcvWCnRz3vMHEZ3VKd
         a56l0Kp/MWkv6jCEzjH7M/akX38WGLoQH6mjDhqJRvlxXYWQ1eXHymBAEbAkK4/TjQ
         F5JsliDmJWrcQA5KHX4gZeQYqDUZzkrj435AasPAYy+gBGV7x7jwOJwOpUwCcakLrg
         UF/nPVoshE5BBmbxM1A315/o+E5fjd17EnUyrym+6kmtKoVOUQiKpGuHJptTtzOGi8
         wT5vw9TW4Wv6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB099E4F156;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Deasset UART break before closing
 serdev device
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482069.2619.17204223621296227564.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230403122430.1024235-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230403122430.1024235-2-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 17:54:28 +0530 you wrote:
> This adds a call to ps_wakeup() before closing the serdev device, to
> de-assert UART break.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Deasset UART break before closing serdev device
    https://git.kernel.org/bluetooth/bluetooth-next/c/051711980f5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


