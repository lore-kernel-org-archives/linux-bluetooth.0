Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFFDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiDFXcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiDFXcO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 19:32:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89D6F8EF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EC05CE2495
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 23:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 795BFC385A7;
        Wed,  6 Apr 2022 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649287813;
        bh=G0gBTMAeNWDGDpwVj5mV0Qz8luEwZJf3HSIfDSzOcRo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iL0WQwNzuM/7Jj9QnV4qcGViDeek9XnnIKXU0hCwt2G4i9ItFmMW6ebUjcKo2i8Tn
         65dPKvynVyiszHuyG13uzETlKwV1HGdUtIJjFj+VM2jBV4e5IBRSp38U33cvfi99xr
         wD3vJw06RkBFHnqA8SA2CD4YbHQhGTit2rkrU9CZs7237OM6E2ocx37Cpcsy6s9CnZ
         WELFOH3531FNAuEB4rmfVXrjRXWxelBLrU3zM2KBJ0L2JtOF1i799GOGdt+0/PA+SQ
         wDUiqiU6kqDp1m+KskaPcbuEwtSLe09pkd8WmjnKN2OE99+QudNzt6jehZJJuiLDWN
         7J0pqKgNEkSgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B6D6E8DBDA;
        Wed,  6 Apr 2022 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC BlueZ] gap: Don't attempt to read the appearance if already set
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164928781337.14953.12626381396586592126.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Apr 2022 23:30:13 +0000
References: <20220404201750.1082470-1-luiz.dentz@gmail.com>
In-Reply-To: <20220404201750.1082470-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Apr 2022 13:17:50 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Devices are unlikely to change appearance over time which is the reason
> why we cache then on the storage so this skips reading it on every
> reconnection.
> ---
>  profiles/gap/gas.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [RFC,BlueZ] gap: Don't attempt to read the appearance if already set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bbeabca44a3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


