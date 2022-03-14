Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F4FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiCNXlY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiCNXlX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 19:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BCD3D48D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 16:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7035861497
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 23:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1361C340F4;
        Mon, 14 Mar 2022 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647301210;
        bh=kk4XUI+iHuJQi2xpmNg2veT8DsevFcNETB8LAIub/Rg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VQJRPw+Vys+L63HAfRAG/B1tM55I9wUVzPd4YOpnYVLA/6Xb7AUWc7ufiEPqn+nVO
         hfgqANg+RpMuJhJCKtk3Yb++CpkYVSoA/YiA4S5F2M/5UAXBn7zbccG4kAijOdGVWL
         G+80Fw3BldPc9ECB6jV9iIhL5eXk7TrjriMya1US8bnatkXqR/Ioz4CLqlfpre0kQr
         Ow7BSVP4Zs7BxrFvthvNJ3jPPF5+58pcIfLaltt70oN21Zh0+5XJ/8RMkqmAP2q4Rq
         USHKvUy7xKLYdWQzKosfw33SzzbtANbv/XKo6B+2vWQ02/lgHrFbjK0a4gQwUazv3U
         S3kxRBaF2+GXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7D7DE6D44B;
        Mon, 14 Mar 2022 23:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] gatt: Print error if gatt_db_attribut_notify fails
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164730121074.18839.12006572635522029824.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Mar 2022 23:40:10 +0000
References: <20220314215010.23822-1-luiz.dentz@gmail.com>
In-Reply-To: <20220314215010.23822-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Mar 2022 14:50:09 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This prints an error if gatt_db_attribut_notify fails.
> ---
>  src/gatt-database.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] gatt: Print error if gatt_db_attribut_notify fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8fb8f9e73ff8
  - [BlueZ,2/2] gatt-db: Fix gatt_db_attribute_notify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=411d63ec33a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


