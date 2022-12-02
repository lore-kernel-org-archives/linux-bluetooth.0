Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF71C4708D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 21:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiLBVZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiLBVZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 16:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5649EE941
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 13:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A35E5B822BF
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 21:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68176C433D6;
        Fri,  2 Dec 2022 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670016341;
        bh=ub4q86QGxjeFrEgqf7U1nlE/oGdjRb3seZwAuiO9zEA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H1bcb55nDtObNAq82Uuj9DsynaKMAEpWdRFYdgaR6m1/dikJPX9U7KlFWFldvJZc4
         xO+AI9S5wQYWVIyTptOHf6J1YII21zzPxLIw58eXqzHy/yhv75NFsWuvFXbr0dxD0a
         bxDJehMjstoCnrlKdZny1ilrpWNYg5f63fkIMExD3cEQyxiXt4SDXNCx7qROTp6iNJ
         hXQ3IwH61VxS/zKPc2DHWhQOFxW7uslfMNpEYCLmR0x2cwwpOQY8u+3uxaQl+IcnLT
         v7Ab4VB/zjnJ/kW9Cvo9HsuwfXcdBGJGuLkefiGqVKsf9vCeKdoc/uyMbgqDf9e5w8
         lEfzYrVPLS4pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5801CE21EEF;
        Fri,  2 Dec 2022 21:25:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] monitor: Decode vendor codecs of
 BT_HCI_CMD_READ_LOCAL_CODECS_V2
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167001634135.19139.11556597169989719149.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Dec 2022 21:25:41 +0000
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Nov 2022 13:18:36 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to decode the vendor codecs includec in the response of
> BT_HCI_CMD_READ_LOCAL_CODECS_V2.
> ---
>  monitor/bt.h     |  6 ++++++
>  monitor/packet.c | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Here is the summary with links:
  - [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25d6c9a0468f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


