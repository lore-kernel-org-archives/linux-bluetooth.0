Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E128C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbiCXTvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiCXTvs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 15:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008E55775
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 12:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A9260A76
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 19:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C512C340F4;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151414;
        bh=73DJgcluABiC3qu5kOdgYuarOyh6vU4k4A8WTulKoAc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s+p0uiWj1IouprzSowY8aqoptwUwlS1LQRvmXjLpbb/fFDFo8KOm8Z4RmAnDnUxyM
         MzCUSnM9CkAzgqzteaza+1cRmME5AlXjSgPOnZMvRIQ46akRXmPIF79q5+/iIBHVJR
         6n7KKJAr4FvDFjApXFXRxAxYrrGz7o1GZ9JFv2HhUqErCAS5hKe5TqDuajvXC3rESL
         Anjl/dOJE8a4gYCme92W92tOx6BqNR6gfLm8N54BYDr1Pb4TK5mtym7IGmHYja42aD
         L2uInMiOfGtTCA8QG8PCApDtg/xKsliVHIeYINTLURd9vEbCjKfuUCu9lrNQtqZ/LB
         wDc0yG18V3N0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37F48F0383F;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] att: Log file and function names
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164815141422.1997.9379921497394554955.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Mar 2022 19:50:14 +0000
References: <20220321205529.2469387-1-luiz.dentz@gmail.com>
In-Reply-To: <20220321205529.2469387-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Mar 2022 13:55:25 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds logging of file and function names.
> ---
>  src/shared/att.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] att: Log file and function names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8039d42687fd
  - [BlueZ,2/5] device: Don't use DBG in gatt_debug
    (no matching commit)
  - [BlueZ,3/5] gatt-client: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0870ce5e1fe
  - [BlueZ,4/5] gatt-server: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55c25d91e4d6
  - [BlueZ,5/5] att: Rename att_debug and att_verbose to DBG and VERBOSE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1b808c128fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


