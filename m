Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34EECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIOVKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOVKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 17:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9EF49B41
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 14:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE3256269A
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 21:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 496F9C433C1;
        Thu, 15 Sep 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663276216;
        bh=rj7Hqc8UDIDhpgBP3O51vPhKrSTJe2n0YOiTAR6SeKU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P6w5LyGisxLQapwVPe82nS/XIw7ihTRREwq1rgDGhA1b1zJKdhxblv6cM1eoL21KK
         ae0bSRoijdfjFUc6Fh1eu7Wna+ghBFYuqekFXtWL2Z+ETTCgAI3boRwko87WNb0YVD
         mASlo7mbd6Vsl1QBBkCp8f1C6h9ejmykMwD2YUNdAmyyEHEtirvhsTOp/3TrCb0oiJ
         qk48LLUiSMfuFjqaVq1Hizh+hdvHUHiP6piRnvcXItitCBh04n+HQp5cC5vKGaiSXc
         65CEztfYH+p6QQRGsxolbXVG6e+y20QcXDlpH69Tpt6atD+tSyjLtJeNwO8+E4VYkH
         ttt/Hcg4cf8dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FD7BC73FEB;
        Thu, 15 Sep 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: Fix possible deadlock on socket
 shutdown/release
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166327621619.17907.17699080247763339009.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Sep 2022 21:10:16 +0000
References: <20220913233157.526041-1-luiz.dentz@gmail.com>
In-Reply-To: <20220913233157.526041-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Sep 2022 16:31:57 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Due to change to switch to use lock_sock inside rfcomm_sk_state_change
> the socket shutdown/release procedure can cause a deadlock:
> 
>     rfcomm_sock_shutdown():
>       lock_sock();
>       __rfcomm_sock_close():
>         rfcomm_dlc_close():
>           __rfcomm_dlc_close():
>             rfcomm_dlc_lock();
>             rfcomm_sk_state_change():
>               lock_sock();
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
    https://git.kernel.org/bluetooth/bluetooth-next/c/812e92b824c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


