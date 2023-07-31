Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAEAC00528
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjGaSA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGaSAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 14:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF4E5C
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 11:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 497F761260
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF8BC433C8;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690826421;
        bh=DOXgqoKeuaFjdEaJMWcbXvmg2Cbyn7R3DAKxcR3fYIA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dhpm07rdhnjgVLkdHwtfcg2ZSaRt2WSiwGuAR6HgxFjJjzH9F7oJlUrS8HG88WpFT
         Pp3xnStjWL4S1aVdFFr6gYatdJ4izu8MQt8dDkkgt6ECqWOqR6Hdt71SN530Jmcwhy
         z57+sGbo9wmGVmRW/LoAlbrQ4QAA1d7jSRBKtGCk/JVZoJEF8pM7iyxtA2bRAnixIx
         iJ9SWRRtVtBxltHZRGjbyMav5GBw9u12+RaL/tNIcFakm9YN+6DOJShNI5uOkhutfh
         sdoGyfvqVjXujaSFkvalDDRM75VNwnYfkKin+ph0X6dBRr+Vl+hGfpj8eIJiYNlWjx
         309DfMEWLW1ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 978DBC595C5;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 5/5] monitor: Add parsing Service Data of UUID 128
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082642161.19346.3065289127944133511.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 18:00:21 +0000
References: <20230729190945.1427101-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20230729190945.1427101-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?q?=C5=81ukasz_Rymanowski_=3Clukasz=2Erymanowski=40codecoup=2Epl=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Jul 2023 21:09:45 +0200 you wrote:
> In the advertising report, instead of parsing EIR 0x21 like this:
> 
> 	Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130d
> 
> We can do bit better
> 
>         Service Data UUID 128: Vendor specific
>           Data: 01480d130d
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,5/5] monitor: Add parsing Service Data of UUID 128
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d60b555e8e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


