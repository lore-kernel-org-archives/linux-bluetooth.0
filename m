Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A814C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 21:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbiEaVUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiEaVUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 17:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384617035C;
        Tue, 31 May 2022 14:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C479061348;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D3AFC3411C;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032012;
        bh=GcfQ54dGudm7ZHirEit88epzxfWGn1nphYP+Wy62oEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y6kHqXkA9whpiyTh5YyQ+NHKX6etzcrVPPnxpwQRr7E41zclGyy7dr5aV1NDpfOME
         BsyLxtKY+Y3jKd++8EJF5ao9yEuQJp18/JbxTI2MqFvU0adzBg4f7an2QHIalPRMMq
         2Jx7YpSiH+76MoHQhs11oVx7gLpju2k+6P4fP5ey92GrriMPrPVrIuU4L8ST8hX6Ci
         gIOnuZ9cUOmw2KC1W+13r9S2zzRIw1KfJ6FxOEZAhdwIx5CGrcJlMCgK5a71SQFtgh
         F202sQzeSwIYEquFnMnJFd62b3IxABXBNtlv2iXtgjyU0w5Tt6CbCbPflJgMUeCjXO
         Wp/t8ZiJM+65w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D2B6F0394E;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165403201205.25010.12372170867802214338.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 21:20:12 +0000
References: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
In-Reply-To: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 May 2022 15:45:43 +0530 you wrote:
> This fixes the return value of qca_wakeup(), since
> .wakeup work inversely with original .prevent_wake.
> 
> Fixes: 4539ca67fe8ed (Bluetooth: Rename driver .prevent_wake to .wakeup)
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [RESEND,v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
    https://git.kernel.org/bluetooth/bluetooth-next/c/9271cf2ecc9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


